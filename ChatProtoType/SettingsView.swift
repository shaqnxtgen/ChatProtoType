//
//  SettingsView.swift
//  ChatProtoType
//
//  Created by Shaquille Nelson on 9/18/25.
//

//import SwiftUI
//
//struct SettingsView: View {
//    @Bindable var viewModel: ChatViewModel
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Settings")
//                .font(.largeTitle)
//                .bold()
//
//            TextField("Enter username", text: $viewModel.username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    SettingsView(viewModel: ChatViewModel())
//}

import SwiftUI

struct SettingsView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @Bindable var viewModel: ChatViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Profile")) {
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(.roundedBorder)
                }
                
                Section(header: Text("User")) {
                    Button("Logout", role: .destructive) {
                        isLoggedIn = false
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    let vm = ChatViewModel()
    return SettingsView(viewModel: vm)
}
