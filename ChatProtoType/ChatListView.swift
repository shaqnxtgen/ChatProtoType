//
//  ChatListView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ChatListView: View {
    @ObservedObject var viewModel: ChatViewModel
    @State private var showingNewChat = false
    @State private var newChatTitle = ""
    @State private var searchText = ""
    
    var filteredConversations: [Conversation] {
        if searchText.isEmpty {
            return viewModel.conversations
        } else {
            return viewModel.conversations.filter { convo in
                convo.title.localizedCaseInsensitiveContains(searchText) ||
                convo.messages.contains { $0.text.localizedCaseInsensitiveContains(searchText) }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredConversations) { conversation in
                    NavigationLink(destination: ChatDetailView(viewModel: viewModel, conversation: conversation)) {
                        HStack {
                            Text(conversation.avatar) // emoji avatar
                                .font(.largeTitle)
                                .frame(width: 44, height: 44)
                            
                            VStack(alignment: .leading) {
                                Text(conversation.title)
                                    .font(.headline)
                                if let lastMessage = conversation.messages.last {
                                    Text(lastMessage.text)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .lineLimit(1)
                                } else {
                                    Text("\(conversation.messages.count) messages")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteConversation)
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingNewChat = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search chats")
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
    let vm = ChatViewModel()
    vm.conversations = [
        Conversation(title: "Work", messages: [Message(text: "Hey team!", isUser: true)], avatar: "👩‍💻"),
        Conversation(title: "Fun", messages: [Message(text: "Party time 🎉", isUser: false)], avatar: "🎨")
    ]
    return ChatListView(viewModel: vm)
}
