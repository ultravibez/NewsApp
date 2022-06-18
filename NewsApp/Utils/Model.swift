//
//  Model.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

protocol Model: Codable {
    static var decoder: JSONDecoder { get }
}

extension Model {
    static var decoder: JSONDecoder {
        JSONDecoder()
    }
}
