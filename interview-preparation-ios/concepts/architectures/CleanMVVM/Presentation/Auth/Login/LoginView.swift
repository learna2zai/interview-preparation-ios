//
//  LoginView.swift
//  interview-preparation-ios
//
//  Created on 23/02/26.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("environment")
    private var environment: AppEnvironment = .development
    
    @Environment(AppCoordinator.self) var appCoordinator
    
    let coordinator: AuthCoordinator
    @State private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel,
         coordinator: AuthCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange,.yellow, .pink], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                VStack(spacing: 20) {
                    TextField("Emial", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                        .keyboardType(.asciiCapable)
                }
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                HStack {
                    Button("Login") {
                        appCoordinator.show(.main)
//                        Task {
//                            if await viewModel.login() {
//                                appCoordinator.show(.main)
//                            }
//                        }
                    }
                    Button("Register") {
                        coordinator.push(.register)
                    }
                }
                .padding(.top, 16)
                .buttonStyle(.borderedProminent)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                Spacer()
                
                NavigationLink("Basic Explorations", value: AuthCoordinator.Route.basicExploration)
                    .padding()
                    .glassEffect()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("", systemImage: "ellipsis") {
                        Picker("Environment", selection: $environment) {
                            ForEach(AppEnvironment.allCases, id: \.self) { env in
                                Text(env.rawValue.capitalized).tag(env.rawValue)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.trackScreenView()
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

//#Preview {
//    LoginView(loginViewModel: .init(loginUseCase: .mock))
//}
