//
//  ViewState.swift
//  Rijksmuseum
//
//  Created by Filipe Donadio on 14/05/2023.
//

import Foundation

/// Enum representing the view state.
public enum ViewState<T> {
    /// There are no elements in the view.
    case empty
    
    /// The view is loading.
    case loading
    
    /// An error has occurred.
    case error
    
    /// The elements are loaded and ready for use.
    case success(elements: T)
}
