//
//  SettingsView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var viewModel: ChatViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()

            TextField("Enter username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView(viewModel: ChatViewModel())
}
