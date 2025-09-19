//
//  Message.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import Foundation


// MARK: - Model
struct Message: Identifiable, Codable, Hashable {
    let id: UUID          // unique ID for Identifiable
    let text: String      // the content of the message
    let isUser: Bool      // who sent it: true = user, false = bot
    let timestamp: Date // NEW

    // Custom initializer with default UUID
    init(id: UUID = UUID(), text: String, isUser: Bool, timestamp: Date = Date()) {
        self.id = id
        self.text = text
        self.isUser = isUser
        self.timestamp = timestamp
    }
}
