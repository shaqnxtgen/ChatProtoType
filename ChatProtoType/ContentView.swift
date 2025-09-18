//
//  ContentView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 25) {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            Text("Knock, knock!")
                .padding()
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
            Text("Who's there?")
                .padding()
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
            Text("Mew")
                .padding()
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
            Text("Mew Who?")
                .padding()
                .background(Color.teal, in: RoundedRectangle(cornerRadius: 8))
            Text("Mew-Two!!")
                .padding()
                .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
