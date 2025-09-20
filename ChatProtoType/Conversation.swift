//
//  Conversation.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import Foundation

struct Conversation: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var messages: [Message]
    var avatar: String  // 👈 new field (emoji or SF Symbol name)

    init(id: UUID = UUID(), title: String, messages: [Message] = [], avatar: String? = nil) {
        self.id = id
        self.title = title
        self.messages = messages
        self.avatar = avatar ?? Conversation.randomAvatar()
    }
    
    // Pick a random emoji as default avatar
    static func randomAvatar() -> String {
        let options = ["💬", "👩‍💻", "🧑‍🚀", "🤖", "🐱", "🐶", "🌎", "🎨", "⚡️"]
        return options.randomElement() ?? "💬"
    }
}
