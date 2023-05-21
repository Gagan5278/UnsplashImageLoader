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
    let links: Links
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
