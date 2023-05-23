//
//  SearchView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/21.
//

import SwiftUI

struct SearchPhotoView: View {
    
    @ObservedObject private var searchViewModel: SearchPhotoViewModel
    @Environment(\.isSearching) var isSearching: Bool
    
    // MARK: -  init
    init(viewModel: SearchPhotoViewModel) {
        _searchViewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                switch searchViewModel.searchState {
                case .initial:
                    Image(uiImage: UIImage(named: "inspector")!)
                        .resizable()
                        .scaledToFit()
                case .loading:
                    LoadingView()
                case .loaded(let photosLoaded):
                    ScrollView {
                        StaggeredPhotosView(photos: photosLoaded) {  photo in
                            guard let lastPhoto = photosLoaded.last else {
                                return
                            }
                            if photo.id == lastPhoto.id {
                                self.searchViewModel.searchPhotos()
                            }
                        }
                    }
                case .failed:
                    Text("An error occured while searching photos")
                        .foregroundColor(.red)
                }
            }
        }
        .searchable(
            text: $searchViewModel.searchedText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search favorite photo"
        )
        .navigationTitle("Search photo")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotoView(viewModel: SearchPhotoViewModel(service: ApiManager()))
    }
}
