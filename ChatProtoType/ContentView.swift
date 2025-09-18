//
//  ContentView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI  // Swift gives us UI components

struct ContentView: View {
    // MARK: - State
    @State private var messages: [String] = ["Knock, knock!"]
    // Holds a list of messages (like a chat log)
    // starts with one message already
    
    @State private var newMessage: String = ""
    // Holds the text the user is typing in the TextField
    
    
    var body: some View {
        VStack{
            // MARK: - Messages List
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(messages, id: \.self) {msg in
                        Text(msg)
                            .padding()
                            .background(Color.blue.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                            .frame(maxWidth: .infinity, alignment: .leading) // left align
                    }
                }
                .padding()
            }
            
            Divider() // thin line above input box
            
            // MARK: - Input Area
            HStack {
                TextField("Type a message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 8)
                
                Button("Send") {
                    if !newMessage.isEmpty {
                        messages.append(newMessage) // add to messages array
                        newMessage = ""             // clear input
                    }
                }
                .padding(.horizontal)
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                .foregroundColor(.white)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
