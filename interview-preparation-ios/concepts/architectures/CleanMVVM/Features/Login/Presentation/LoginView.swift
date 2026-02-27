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
    
    @State private var path = NavigationPath()
    @State private var loginViewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                LinearGradient(colors: [.orange,.yellow, .pink], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        TextField("Emial", text: $loginViewModel.email)
                            .keyboardType(.emailAddress)
                        SecureField("Password", text: $loginViewModel.password)
                            .keyboardType(.asciiCapable)
                    }
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    if let error = loginViewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    
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
                    
                    Spacer()
                    
                    NavigationLink("Basic Explorations", value: AppPath.basic)
                        .padding()
                        .glassEffect()
                }
                .padding()
            }
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
                loginViewModel.trackScreenView()
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: AppPath.self) {
                switch $0 {
                    case .basic:
                        BasicExplorations()
                    default:
                        ContentUnavailable()
                }
            }
        }
    }
}

//#Preview {
//    LoginView(loginViewModel: .init(loginUseCase: .mock))
//}
