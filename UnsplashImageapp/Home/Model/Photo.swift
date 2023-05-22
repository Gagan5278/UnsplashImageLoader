//
//  Photo.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/17.
//

import Foundation

struct Photo: Codable, Identifiable {
    let id: String
    let urls: Urls
    let description: String?
    let altDescription: String?
    let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case description
        case altDescription = "alt_description"
        case links
    }
}

// MARK: - WelcomeLinks
struct Links: Codable {
    let linksSelf, html, download, downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
