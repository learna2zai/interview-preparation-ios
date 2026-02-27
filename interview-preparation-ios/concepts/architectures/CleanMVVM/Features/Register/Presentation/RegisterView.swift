//
//  RegisterView.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var registerViewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.registerViewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange,.yellow, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    TextField("Name", text: $registerViewModel.name)
                    TextField("Email", text: $registerViewModel.email)
                    SecureField("Password", text: $registerViewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                HStack {
                    Button("Register") {
                        Task {
                            await registerViewModel.register()
                        }
                    }
                    
                    Button("Login") {
                        registerViewModel.goToLogin()
                    }
                }
                .padding(.top, 20)
                .buttonStyle(.borderedProminent)
                
                if registerViewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
                if let error = registerViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .onAppear {
            registerViewModel.trackScreenView()
        }
        .navigationBarBackButtonHidden()
    }
        
}

//#Preview {
//    RegisterView()
//}
