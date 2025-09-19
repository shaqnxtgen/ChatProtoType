//
//  SettingsView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var username: String = "User"

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()

            TextField("Enter username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
