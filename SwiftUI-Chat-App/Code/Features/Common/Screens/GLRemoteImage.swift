//
//  GLRemoteImage.swift
//  SwiftUI-Chat-App
//
//  Created by RootNext15 on 6/3/24.
//

import SwiftUI

public enum GLRemoteImageState: Equatable {
    case noData
    case loading
    case fetched(Image)
    case error(Error)

    internal static func fetched(_ uiImage: UIImage) -> Self {
        Self.fetched(Image(uiImage: uiImage))
    }

    public static func ==(lhs: GLRemoteImageState, rhs: GLRemoteImageState) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData): return true
        case (.loading, .loading): return true
        case (.fetched(let left), .fetched(let right)): return left == right
        case (.error(let left), .error(let right)): return (left as NSError) == (right as NSError)
        default: return false
        }
    }

    internal var image: Image? {
        switch self {
        case .fetched(let image): return image
        default: return nil
        }
    }
}

@MainActor
public struct GLRemoteImage<Content: View>: View {
    @MainActor
    private final class ViewModel: ObservableObject {
        @Published var state: GLRemoteImageState

        init(url: URL?) {
            guard let url else {
                self.state = .noData
                return
            }

            self.state = GLRemoteImageManager.shared.currentImageState(for: url)

            GLRemoteImageManager.shared
                .imageStatePublisher(for: url)
                .receive(on: DispatchQueue.main)
                .assign(to: &self.$state)
        }
    }

    // This needs to be `@ObservedObject` instead of `@StateObject` specifically because we _do_ want this `ViewModel` to be re-created when the containing view (`GLRemoteImage`) re-renders due to a change. Like because the URL changed.
    @ObservedObject private var viewModel: ViewModel
    @ViewBuilder let content: (GLRemoteImageState) -> Content

    public init(imageUrl: URL?, @ViewBuilder content: @escaping (GLRemoteImageState) -> Content) {
        self._viewModel = .init(wrappedValue: ViewModel(url: imageUrl))
        self.content = content
    }

    public var body: some View {
        self.content(self.viewModel.state)
            .accessibilityHidden(true)
    }
}
