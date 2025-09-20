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
    
    var body: some Scene {
        WindowGroup {
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
