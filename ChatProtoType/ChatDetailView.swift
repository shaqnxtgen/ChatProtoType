//
//  ContentView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - ViewModel
    @Bindable var viewModel = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in MessageBubble(message: message)
                    }
                }
                .padding()
            }
                        
            // Input HStack
            HStack {
                TextField("Type a message...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Chat") // Top navigation title
//        .toolbar {
//            // Add a button to navigate to Settings
//            NavigationLink(destination: SettingsView(viewModel: viewModel)) {
//                Text("Settings")
//                }
//            }
        }
    }

#Preview {
    ContentView()
}
