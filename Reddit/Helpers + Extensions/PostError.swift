//
//  PostError.swift
//  Reddit
//
//  Created by Mackenzie Wacker on 12/23/22.
//

import Foundation


enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error) // taking in Type error aka E not e
    case noData
    case unableToDecode
    
    var errorDescription: String? {
//        for me or user
        // self is posterror - gotta account for all cases.
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .thrownError(let error):
            return "ERROR: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "Unable to decode the data."
        }
    
    }
    
    
} // End of Enum
