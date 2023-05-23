//
//  SearchPhotoViewModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/21.
//

import Foundation
import Combine

class SearchPhotoViewModel: ObservableObject {
    
    enum SearchPhotoState {
        case initial
        case loading
        case loaded([Photo])
        case failed
    }
    
    @Published var searchedText: String = ""
    @Published var searchState: SearchPhotoState = .initial
    
    private let service: ApiManagerProtocol
    private var cancellable: AnyCancellable?
    private var currentPage: Int = 1
    public private(set) var searchedPhotos: [Photo] = []
    
    var totalNumberOfPages: Int = 0
    // MARK: - init
    init(service: ApiManagerProtocol) {
        self.service = service
        bindTextSearch()
    }
    
    private func bindTextSearch() {
        cancellable = $searchedText
            .dropFirst()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map { [weak self] searchString in
                if searchString.isEmpty {
                    self?.resetToInitialState()
                }
                return searchString
            }
            .filter { !$0.isEmpty }
            .sink { [weak self] searchString in
                self?.searchPhotos()
            }
    }
    
    func searchPhotos() {
        guard let searchQuery = searchedText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !isMaxPageLimitReached else { return }
        let endPoint = EndPoint.searchPhoto(page: currentPage, searchItem: searchQuery)
        Task { @MainActor in
            do {
                if let photos = try await service.callService(endPoint: endPoint, model: SearchPhoto.self) {
                    searchedPhotos.append(contentsOf: photos.results)
                    searchState = .loaded(searchedPhotos)
                    currentPage += 1
                    if totalNumberOfPages == 0 {
                        totalNumberOfPages = photos.totalPages
                    }
                } else {
                    searchState = .failed
                }
            } catch {
                searchState = .failed
            }
        }
    }
    
    private func resetToInitialState() {
        searchedText = ""
        searchedPhotos = []
        currentPage = 1
        totalNumberOfPages = 0
        searchState = .initial
    }
    
    var isMaxPageLimitReached: Bool {
        currentPage > totalNumberOfPages && totalNumberOfPages > 0
    }
}
