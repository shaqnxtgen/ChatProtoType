//
//  ContentView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - ViewModel
    @State private var viewModel = ChatViewModel()

    var body: some View {
        NavigationStack {
        VStack {
            // Chat ScrollView
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.messages) { msg in
                        Text(msg.text)
                            .padding()
                            .background(
                                msg.isUser
                                ? Color.teal.opacity(0.2)
                                : Color.blue.opacity(0.2),
                                in: RoundedRectangle(cornerRadius: 8)
                            )
                            .frame(maxWidth: .infinity,
                                   alignment: msg.isUser ? .trailing : .leading)
                    }
                }
                .padding()
            }

            Divider()

            // Input HStack
            HStack {
                TextField("Type a message...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 8)

                Button("Send") {
                    viewModel.sendMessage()
                }
                .padding(.horizontal)
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white)
            }
            .padding()
        }
        .navigationTitle("Chat") // Top navigation title
        .toolbar {
            // Add a button to navigate to Settings
            NavigationLink(destination: SettingsView()) {
                Text("Settings")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
