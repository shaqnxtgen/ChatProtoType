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
    
    // Local UI state for the edit-sheet
    @State private var showingEditSheet = false
    @State private var editTitle: String = ""

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    if let index = viewModel.conversations.firstIndex(where: { $0.id == conversation.id }) {
                        let messages = viewModel.conversations[index].messages
                        ForEach(viewModel.conversations[index].messages) { message in
                            MessageBubble(message: message)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        if let msgIndex = messages.firstIndex(where: { $0.id == message.id }) {
                                            viewModel.conversations[index].messages.remove(at: msgIndex)
                                            viewModel.saveConversations()
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }  else {
                        // Fallback if conversation not found
                        Text("Conversation not found")
                            .foregroundColor(.secondary)
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
        .navigationTitle(currentTitle) // show the current (possibly updated) title
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    // Pre-fill the sheet TextField with the current title
                    editTitle = currentTitle
                    showingEditSheet = true
                }
            }
        }
        .sheet(isPresented: $showingEditSheet) {
                    // Sheet content: TextField + Save/Cancel buttons
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
                                    // Call view model to update the conversation title
                                    viewModel.updateConversationTitle(id: conversation.id, newTitle: editTitle)
                                    showingEditSheet = false
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(editTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) // validation here for save diabled
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

            // Computed property to always read the latest title from the view model.
            private var currentTitle: String {
                viewModel.conversations.first(where: { $0.id == conversation.id })?.title ?? conversation.title
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
