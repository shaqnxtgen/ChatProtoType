//
//  ChatViewModel.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI
import Foundation

@Observable
class ChatViewModel {
    // MARK: - Properties
    var conversations: [Conversation] = []
    var selectedConversation: Conversation?   // active chat
    var newMessage: String = ""
    var username: String = "Me"
    
    
    // MARK: - Init
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
    
    // MARK: - Conversation CRUD
    func addConversation(title: String) {
        let conversation = Conversation(title: title)
        conversations.append(conversation)
        saveConversations()
    }
    
    func deleteConversation(at offsets: IndexSet) {
        conversations.remove(atOffsets: offsets)
        saveConversations()
    }
    
    /// UPDATE: change title of a conversation (called from sheet Save)
    func updateConversationTitle(id: UUID, newTitle: String) {
        // Trim and guard against empty title
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              let idx = conversations.firstIndex(where: { $0.id == id })
        else { return }
        
        conversations[idx].title = trimmed
        saveConversations()
    }
    
    // Delete individual messages

    func deleteMessage(in conversationID: UUID, at offsets: IndexSet) {
        if let convIndex = conversations.firstIndex(where: { $0.id == conversationID }) {
            conversations[convIndex].messages.remove(atOffsets: offsets)
            saveConversations()
        }
    }
    
    // MARK: - Persistence
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
        }  else {
            // Optional: bootstrap one sample conversation if none exist
            conversations = [Conversation(title: "Welcome", messages: [Message(text: "Hi there!", isUser: false)])]
            saveConversations()
        }
    }
}
