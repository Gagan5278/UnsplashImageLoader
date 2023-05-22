//
//  PhotoDetailViewModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import Foundation

class PhotoDetailViewModel: ObservableObject {
    
    private let photo: Photo
    private let service: ApiManagerProtocol
    private let imageSaver = ImageSaverInAlbum()
    
    @Published public private(set) var downloadState: DownloadImageState = .initialized
    
    // MARK: - init
    init(photo: Photo, service: ApiManagerProtocol) {
        self.photo = photo
        self.service = service
    }
    
    var description: String {
        (photo.description ?? photo.altDescription) ?? ""
    }
    
    var fullURLString: String {
        photo.urls.full
    }
    
    var navTitle: String {
        if let description = photo.description?.components(separatedBy: " "), description.count >= 2 {
            return description[..<2].joined(separator: " ").capitalized
        }
        return "Back"
    }
    
    func downloadPhoto() {
        downloadState = .loading
        let endPoint = EndPoint.downloadImage(urlString: photo.urls.full)
        Task { @MainActor in
            do {
                if let image = try await service.fetchImage(from: endPoint) {
                    imageSaver.addInPhotoAlbum(image: image)
                    downloadState = .downloaded
                } else {
                    downloadState = .failed
                }
            } catch {
                downloadState = .failed
            }
        }
    }
}

// MARK: - DownloadImageState in extension
extension PhotoDetailViewModel {
    enum DownloadImageState {
        case initialized
        case loading
        case downloaded
        case failed
    }
}
