//
//  LoginView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginViewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TextField("Emial", text: $loginViewModel.email)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $loginViewModel.password)
                .textFieldStyle(.roundedBorder)
            Button {
                loginViewModel.login()
            } label: {
                Text("Login")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
            if loginViewModel.isLoding {
                ProgressView()
            }
            if let error = loginViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle(Text("Login"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    LoginView(loginViewModel: .init(loginUseCase: .mock))
//}
