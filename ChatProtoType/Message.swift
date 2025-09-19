//
//  Message.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import Foundation

// Represents a single chat message
struct Message: Identifiable, Hashable {
    let id = UUID()       // Unique ID so SwiftUI can track each message
    let text: String      // The message text
    let isUser: Bool      // Who sent it (true = user, false = system/bot)
}
