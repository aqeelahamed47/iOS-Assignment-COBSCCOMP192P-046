//
//  AqeelAhamed_CW_iOSApp.swift
//  AqeelAhamed-CW-iOS
//
//  Created by Aqeel Ahamed 2023-09-24.
//

import SwiftUI
import Firebase

@main
struct AqeelAhamed_CW_iOSApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        setupAuthentication()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension AqeelAhamed_CW_iOSApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
