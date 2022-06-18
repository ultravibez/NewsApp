//
//  ArticleListCell.swift
//  NewsApp
//
//  Created by Matan Dahan on 18/06/2022.
//

import SwiftUI

struct ArticleListCell: View {
    let article: Article
    
    var body: some View {
        VStack {
            if let url = URL(string: article.url) {
                Link(destination: url, label: {
                    Text(article.title)
                        .foregroundColor(.black)
                })
            }
        }
        .padding()
    }
}
