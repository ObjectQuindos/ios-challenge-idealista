//
//  ContentStateViewModel.swift
//  IdealistaChallenge
//

import SwiftUI

protocol ContentStateViewModel {
    var contentState: ContentState { get }
}

extension ContentStateViewModel {
    
    /// Calc content state based in isLoading, error and isEmpty
    func determineContentState(
        isLoading: Bool,
        error: Error?,
        isEmpty: Bool,
        retryAction: Action?,
        retryAsyncAction: AsyncAction?,
        emptyMessage: String = "No data available"
    ) -> ContentState {
        
        if isLoading {
            return .loading
            
        } else if let error = error {
            return .error(error, retryAction, retryAsyncAction)
            
        } else if isEmpty {
            return .empty(emptyMessage)
            
        } else {
            return .contentView
        }
    }
}
