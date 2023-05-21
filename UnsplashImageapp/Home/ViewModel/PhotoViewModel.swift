//
//  PhotoViewModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/17.
//

import Foundation

class PhotoViewModel: ObservableObject {
    
    enum PhotoState {
        case loading
        case loaded([Photo])
        case failed
    }
    
    @Published var loadingState: PhotoState = .loading
    
    private let service: ApiManagerProtocol
    
    private var currentPage: Int = 1
    private let maxPageLimit = 50
    private var photosArray: [Photo] = []
    
    // MARK: - init
    init(service: ApiManagerProtocol) {
        self.service = service
        loadPhotos()
    }
    
    func loadPhotos() {
        guard !isMaxPageLimitReached else { return }
        let endPoint = EndPoint.photos(page: currentPage, contentFilter: "high")
        
        Task { @MainActor in
            do {
                if let photos = try await service.callService(endPoint: endPoint, model: [Photo].self) {
                    photosArray.append(contentsOf: photos)
                    loadingState = .loaded(photosArray)
                    currentPage += 1
                } else {
                    loadingState = .failed
                }
            } catch {
                loadingState = .failed
            }
        }
    }
    
    private var isMaxPageLimitReached: Bool  {
        currentPage == maxPageLimit
    }
}
