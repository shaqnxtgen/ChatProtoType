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

    init(id: UUID = UUID(), title: String, messages: [Message] = []) {
        self.id = id
        self.title = title
        self.messages = messages
    }
}
