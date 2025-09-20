//
//  ContentView.swift renamed to ChatDetailView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ChatDetailView: View {
    @ObservedObject var viewModel: ChatViewModel
    let conversation: Conversation
    
    @State private var showingEditSheet = false
    @State private var editTitle: String = ""
    
    var body: some View {
        VStack {
            if let index = viewModel.conversations.firstIndex(where: { $0.id == conversation.id }) {
                let messages = viewModel.conversations[index].messages
                
                List {
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                    }
                    .onDelete { offsets in
                        viewModel.deleteMessage(in: conversation.id, at: offsets)
                    }
                }
                .listStyle(.plain)
            } else {
                Text("Conversation not found")
                    .foregroundColor(.secondary)
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
        .navigationTitle(currentTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    editTitle = currentTitle
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            EditConversationTitleSheet(
                viewModel: viewModel,
                conversation: conversation,
                showingEditSheet: $showingEditSheet,
                editTitle: $editTitle
            )
        }
    }
    
    private var currentTitle: String {
        viewModel.conversations.first(where: { $0.id == conversation.id })?.title ?? conversation.title
    }
}

struct EditConversationTitleSheet: View {
    @ObservedObject var viewModel: ChatViewModel
    let conversation: Conversation
    @Binding var showingEditSheet: Bool
    @Binding var editTitle: String
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Edit Conversation Title")
                    .font(.headline)

                TextField("Conversation title", text: $editTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Button("Cancel") {
                        showingEditSheet = false
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button("Save") {
                        viewModel.updateConversationTitle(id: conversation.id, newTitle: editTitle)
                        showingEditSheet = false
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(editTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
               
                Spacer()
            }
            .padding()
            .navigationTitle("Edit Title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    let vm: ChatViewModel = {
        let vm = ChatViewModel()
        let sample = Conversation(title: "Sample Chat", messages: [
            Message(text: "Hello!", isUser: true),
            Message(text: "Hi there!", isUser: false)
        ])
        vm.conversations = [sample]
        return vm
    }()

    ChatDetailView(viewModel: vm, conversation: vm.conversations[0])
}
