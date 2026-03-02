//
//  ViewModel.swift
//  interview-preparation-ios
//
//  Created on 25/02/26.
//

import Foundation

protocol ViewModel {
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    func trackScreenView()
}
