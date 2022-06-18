//
//  Result.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

struct Results<Item: Model>: Model {
    let articles: [Item]
}

extension Results {
    static var decoder: JSONDecoder {
        Item.decoder
    }
}
