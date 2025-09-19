//
//  MessageBubble.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct MessageBubble: View {
    let message: Message

    var body: some View {
        VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
            Text(message.text)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(message.isUser ? .white : .black)
                .cornerRadius(16)
                .frame(maxWidth: 250, alignment: message.isUser ? .trailing : .leading)

            Text(message.timestamp, style: .time) // shows "10:32 AM"
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
        .padding(message.isUser ? .leading : .trailing, 60)
    }
}

#Preview {
    MessageBubble(message: Message(text: "Hello!", isUser: true))
}
