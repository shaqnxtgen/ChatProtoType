//
//  LoginView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/20/25.
//

import SwiftUI
import Foundation

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("ChatProtoType")
                    .font(.largeTitle)
                    .bold()

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button("Login") {
                    handleLogin()
                }
                .buttonStyle(.borderedProminent)
                .disabled(username.isEmpty || password.isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
        }
    }

    private func handleLogin() {
        // Simple hardcoded validation (replace later with backend)
        if username == "test" && password == "password" {
            isLoggedIn = true
        } else {
            errorMessage = "Invalid credentials"
        }
    }
}
