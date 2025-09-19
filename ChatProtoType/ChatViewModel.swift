//
//  ChatViewModel.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

@Observable class ChatViewModel {
    // MARK: - Properties
    var messages: [Message] = [
        Message(text: "Knock, knock!", isUser: false)
    ]
    var newMessage: String = ""

    // MARK: - Methods
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        // Add user's message
        let userMsg = Message(text: newMessage, isUser: true)
        messages.append(userMsg)

        // Reset input
        newMessage = ""

        // Add a fake "bot" reply for demo
        let botMsg = Message(text: "👋 Hi, I'm your bot!", isUser: false)
        messages.append(botMsg)
    }
}
