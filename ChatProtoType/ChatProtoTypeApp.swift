//
//  ChatProtoTypeApp.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

@main
struct ChatProtoTypeApp: App {
    @State private var viewModel = ChatViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ChatListView(viewModel: viewModel)
            } else {
                LoginView()
            }
            TabView {
                ChatListView(viewModel: viewModel)
                    .tabItem {
                        Label("Chats", systemImage: "bubble.left.and.bubble.right")
                    }
                
                SettingsView(viewModel: viewModel)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        }
    }
}
