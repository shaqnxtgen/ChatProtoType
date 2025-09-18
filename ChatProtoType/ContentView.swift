//
//  ContentView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI  // Swift gives us UI components

struct ContentView: View {
    // MARK: - State
    @State private var message = "Knock, knock!"
    // @State = special SwiftUI property wrapper
    // "message" will be watched for changes
    // If it changes, SwiftUI will re-render the body
    
    
    var body: some View {
        VStack(spacing: 16) {   // spacing = space between elements
                // MARK: - Display current message
                Text(message)   // Show the current value of "message"
                    .padding()
                    .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(.white)   // text color
            // MARK: - Button
                Button("Tap me") {
                         message = "Who's there?"  // Updates the state
                     }
                     .padding()
                     .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
                     .foregroundColor(.white)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
