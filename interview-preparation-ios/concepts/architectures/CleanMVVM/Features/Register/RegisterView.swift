//
//  RegisterView.swift
//  interview-preparation-ios
//
//  Created by Ganesh on 23/02/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var registerViewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.registerViewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Register")
                .font(Font.largeTitle)
                .padding()
            
            Form {
                VStack(alignment: .leading) {
                    
                    VStack {
                        TextField("Name", text: $registerViewModel.name)
                        TextField("Email", text: $registerViewModel.email)
                        SecureField("Password", text: $registerViewModel.password)
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    HStack {
                        Button("Register") {
                            Task {
                                await registerViewModel.register()
                            }
                        }
                        .padding()
                        
                        Button("Login") {
                            
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }
}

//#Preview {
//    RegisterView()
//}
