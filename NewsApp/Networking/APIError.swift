//
//  APIError.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case invalidRequestURL
    case apiError
    case decodingFailed(type: Decodable.Type, message: String)
    
    var description: String {
        switch self {
        case .invalidRequestURL:
            return "Failed constructing URL from path"
        case .apiError:
            return "News API Error"
        case .decodingFailed(let type, let message):
            return "Failed decoding \(type): \(message)"
        }
    }
}
