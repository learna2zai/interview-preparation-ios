//
//  RegisterView.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State private var viewModel: RegisterViewModel
    let coordinator: AuthCoordinator
    
    init(viewModel: RegisterViewModel,
         coordinator: AuthCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange,.yellow, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    TextField("Name", text: $viewModel.name)
                    TextField("Email", text: $viewModel.email)
                    SecureField("Password", text: $viewModel.password)
                }
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                HStack {
                    Button("Register") {
                        Task {
                            if await viewModel.register() {
                                coordinator.pop()
                            }
                        }
                    }
                    
                    Button("Login") {
                        coordinator.pop()
                    }
                }
                .padding(.top, 20)
                .buttonStyle(.borderedProminent)
                
                if viewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.trackScreenView()
        }
        .navigationBarBackButtonHidden()
    }
        
}

//#Preview {
//    RegisterView()
//}
