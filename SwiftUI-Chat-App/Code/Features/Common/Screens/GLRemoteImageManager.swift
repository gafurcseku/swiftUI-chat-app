//
//  GLRemoteImageManager.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import Combine
import SwiftUI
import UIKit

extension URLCache {
    /// 25 MB in `memory`, 50 MB in `disk`
    static var glRemoteImageCache = URLCache(memoryCapacity: 25_000_000,
                                             diskCapacity: 50_000_000,
                                             diskPath: "GLUI_Image_Response_Cache")
}

@MainActor
final class GLRemoteImageManager {
    static let shared = GLRemoteImageManager()

    private let urlSession: URLSession
    private let cache: URLCache

    init(urlSession: URLSession = .shared, cache: URLCache = .glRemoteImageCache) {
        self.urlSession = urlSession
        self.urlSession.configuration.requestCachePolicy = .useProtocolCachePolicy
        self.cache = cache
        self.urlSession.configuration.urlCache = cache
    }

    /// Fetch existing image from `cache` and return it, if it exists
    ///
    /// This method will use the `URLRequest` to get the cached response.
    /// If the response's data is empty or does not result in a valid `UIImage`,
    /// the cached response is removed and `nil` is returned
    ///
    /// Otherwise, the image is returned
    func existingImage(for url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedData = cache.cachedResponse(for: request)?.data else {
            return nil
        }
        guard !cachedData.isEmpty, let image = UIImage(data: cachedData) else {
            cache.removeCachedResponse(for: request)
            return nil
        }
        return image
    }

    /// Create and fire `urlSession.dataTask` with the given `url` to retreive image
    /// Valid responses are stored in the `cache`
    func eventualImage(for url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await withCheckedThrowingContinuation { continuation in
            self.urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    guard let data = data else {
                        continuation.resume(throwing: GLRemoteImageError.noData)
                        return
                    }

                    guard let image = UIImage(data: data) else {
                        continuation.resume(throwing: GLRemoteImageError.invalidImageData)
                        return
                    }

                    if let response = response {
                        self.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                    }

                    continuation.resume(returning: image)
                }
            }.resume()
        }
    }
}

// MARK: Errors

extension GLRemoteImageManager {
    enum GLRemoteImageError: Error {
        case invalidImageData
        case noData
    }
}

// MARK: Combine

extension GLRemoteImageManager {
    /// Create a publisher that returns the cached image for the given `url`, or attempt to fetch image `url`
    /// and publish that image data once received
    func imageStatePublisher(for url: URL) -> AnyPublisher<GLRemoteImageState, Never> {
        if let existing = self.existingImage(for: url) {
            return Just(existing)
                .map { .fetched($0) }
                .eraseToAnyPublisher()
        } else {
            let cvs = CurrentValueSubject<GLRemoteImageState, Never>(.loading)

            Task {
                do {
                    let uiImage = try await self.eventualImage(for: url)
                    cvs.send(.fetched(uiImage))
                } catch {
                    cvs.send(.error(error))
                }

                cvs.send(completion: .finished)
            }
            return cvs.eraseToAnyPublisher()
        }
    }

    func currentImageState(for url: URL) -> GLRemoteImageState {
        guard let existing = self.existingImage(for: url) else {
            return .noData
        }

        return .fetched(existing)
    }
}
