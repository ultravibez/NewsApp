//
//  News.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import Foundation

struct Article: Model, Identifiable {
    let id: UUID = UUID()
    let author: String
    let title: String
    let description: String
    let content: String
    let url: String
}
