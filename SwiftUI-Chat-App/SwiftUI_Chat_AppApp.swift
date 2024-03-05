//
//  SwiftUI_Chat_AppApp.swift
//  SwiftUI-Chat-App
//
//  Created by Md Abdul Gafur on 5/3/24.
//PT Sans ["PTSans-Regular", "PTSans-Bold"]

import SwiftUI
import SwiftyBeaver
import AlamofireEasyLogger


let log = SwiftyBeaver.self

@main
struct SwiftUI_Chat_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            DashBoardUIView()
        }
    }
}

class AppDelegate: NSObject , UIApplicationDelegate {
    #if DEBUG
    let alamofireLogger = FancyAppAlamofireLogger(prettyPrint: true) {
        print($0)
    }
    #endif
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M $J"
        console.levelColor.verbose = "🐷"
        console.levelColor.debug = "🛠️"
        console.levelColor.info = "ℹ️"
        console.levelColor.warning = "⚠️"
        console.levelColor.error = "💥"
        
        log.addDestination(console)
        
        return true
    }
}
