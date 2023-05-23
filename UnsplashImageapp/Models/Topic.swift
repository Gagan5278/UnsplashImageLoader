//
//  TopicModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import Foundation

struct Topic: Codable, Identifiable {
    let id: String
    let title: String
    let totalPhotos: Int
    let coverPhoto: CoverPhoto
    enum CodingKeys: String, CodingKey {
        case id, title
        case totalPhotos = "total_photos"
        case coverPhoto = "cover_photo"
    }
}

struct CoverPhoto: Codable {
    let id: String
    let urls: Urls
}

