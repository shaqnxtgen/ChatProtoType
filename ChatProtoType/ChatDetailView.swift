//
//  ContentView.swift renamed to ChatDetailView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ChatDetailView: View {
    @Bindable var viewModel: ChatViewModel
    let conversation: Conversation

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if let index = viewModel.conversations.firstIndex(where: { $0.id == conversation.id }) {
                        ForEach(viewModel.conversations[index].messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                }
                .padding()
            }

            HStack {
                TextField("Type a message...", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button("Send") {
                    viewModel.selectedConversation = conversation
                    viewModel.sendMessage()
                }
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle(conversation.title)
    }
}

#Preview {
    let vm = ChatViewModel()
    let sample = Conversation(title: "Sample Chat", messages: [
        Message(text: "Hello!", isUser: true),
        Message(text: "Hi there!", isUser: false)
    ])
    vm.conversations = [sample]
    return ChatDetailView(viewModel: vm, conversation: sample)
}
