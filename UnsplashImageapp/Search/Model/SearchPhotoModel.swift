//
//  SearchPhotoModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import Foundation

struct SearchPhoto: Codable {
    let total, totalPages: Int
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
