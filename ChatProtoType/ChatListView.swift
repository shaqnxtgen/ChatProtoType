//
//  ChatListView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ChatListView: View {
    @Bindable var viewModel: ChatViewModel
    @State private var showingNewChat = false
    @State private var newChatTitle = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.conversations) { conversation in
                    NavigationLink(destination: ChatDetailView(viewModel: viewModel, conversation: conversation)) {
                        VStack(alignment: .leading) {
                            Text(conversation.title)
                                .font(.headline)
                            if let lastMessage = conversation.messages.last {
                                Text(lastMessage.text)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteConversation) // New
            }
            .navigationTitle("Conversations")
            .toolbar {
                Button(action: { showingNewChat = true }) {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewChat) {
                VStack(spacing: 20) {
                    Text("New Conversation")
                        .font(.headline)

                    TextField("Enter title", text: $newChatTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Create") {
                        guard !newChatTitle.isEmpty else { return }
                        viewModel.addConversation(title: newChatTitle)
                        newChatTitle = ""
                        showingNewChat = false
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Cancel") {
                        showingNewChat = false
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ChatListView(viewModel: ChatViewModel())
}
