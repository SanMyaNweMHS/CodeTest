//
//  ApiServiceError.swift
//  CodeTest
//
//  Created by SanMyaNwe on 7/5/21.
//

import Foundation

enum ApiServiceError: Error {
    
    case decodingFail
    case serverDown
    case clientFail
    case unknown
    
    var description: String {
        switch self {
        case .decodingFail:
            return "DecodingFail!"
        case .serverDown:
            return "ServerDown!"
        case .clientFail:
            return "ClientError!"
        case .unknown:
            return "UnknownError!"
        }
    }
    
}
