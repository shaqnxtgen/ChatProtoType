//
//  ChatViewModel.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

@Observable class ChatViewModel {
    // MARK: - Properties
    var messages: [Message] = [] {
        didSet {
            saveMessages() // save to disk whenever messages change
        }
    }
    var newMessage: String = ""

    private let messagesKey = "chat_messages" // key for UserDefaults

    // MARK: - Init
    init() {
        loadMessages() // load saved messages when app starts
    }

    // MARK: - Methods
    func sendMessage() {
        guard !newMessage.isEmpty else { return }

        // Add user's message
        let userMsg = Message(text: newMessage, isUser: true)
        messages.append(userMsg)
        newMessage = ""

        // Add bot reply
        let botMsg = Message(text: "👋 Hi, I'm your bot!", isUser: false)
        messages.append(botMsg)
    }

    // MARK: - Persistence
    private func saveMessages() {
        do {
            let data = try JSONEncoder().encode(messages)
            UserDefaults.standard.set(data, forKey: messagesKey)
        } catch {
            print("Failed to save messages: \(error)")
        }
    }

    private func loadMessages() {
        guard let data = UserDefaults.standard.data(forKey: messagesKey) else { return }
        do {
            messages = try JSONDecoder().decode([Message].self, from: data)
        } catch {
            print("Failed to load messages: \(error)")
        }
    }
}
