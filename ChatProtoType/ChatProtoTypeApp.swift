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
            ChatListView(viewModel: viewModel)
        }
    }
}
