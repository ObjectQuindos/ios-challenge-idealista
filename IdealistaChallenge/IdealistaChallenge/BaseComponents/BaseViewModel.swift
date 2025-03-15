//
//  BaseViewModel.swift
//  IdealistaChallenge
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: Error?
    var isEmptySourceData = false
}
