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
        ZStack {
            LinearGradient(colors: [.orange,.yellow, .pink], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 20) {
                    TextField("Emial", text: $loginViewModel.email)
                    SecureField("Password", text: $loginViewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                HStack {
                    Button("Login") {
                        Task {
                            await loginViewModel.login()
                        }
                    }
                    Button("Register") {
                        loginViewModel.goToRegister()
                    }
                }
                .padding(.top, 20)
                .buttonStyle(.borderedProminent)
                
                if loginViewModel.isLoading {
                    ProgressView()
                }
                if let error = loginViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .onAppear {
            loginViewModel.trackScreenView()
        }
        .navigationTitle(Text("Login"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    LoginView(loginViewModel: .init(loginUseCase: .mock))
//}
