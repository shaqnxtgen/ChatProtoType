//
//  ChatViewModel.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

@Observable
class ChatViewModel {
    var conversations: [Conversation] = []
    var selectedConversation: Conversation?   // active chat
    var newMessage: String = ""
    var username: String = "Me"

    init() {
        loadConversations()
    }

    // Send a message to the selected conversation
    func sendMessage() {
        guard let index = conversations.firstIndex(where: { $0.id == selectedConversation?.id }),
              !newMessage.trimmingCharacters(in: .whitespaces).isEmpty
        else { return }

        let message = Message(text: newMessage, isUser: true)
        conversations[index].messages.append(message)
        newMessage = ""
        saveConversations()
    }

    // Add a new conversation
    func addConversation(title: String) {
        let conversation = Conversation(title: title)
        conversations.append(conversation)
        saveConversations()
    }
    
    // New Method
    func deleteConversation(at offsets: IndexSet) {
        conversations.remove(atOffsets: offsets)
        saveConversations()
    }
    
    // Persistence
    private let saveKey = "conversations"

    func saveConversations() {
        if let data = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }

    func loadConversations() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let saved = try? JSONDecoder().decode([Conversation].self, from: data) {
            conversations = saved
        }
    }
}
