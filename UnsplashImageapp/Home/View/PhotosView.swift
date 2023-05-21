//
//  PhotosView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/17.
//

import SwiftUI

struct PhotosView: View {
    let topicViewModel = TopicViewModel(service: ApiManager(), endPoint: EndPoint.allTopics)
   @ObservedObject var photosViewModel = PhotoViewModel(service: ApiManager())
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
                switch photosViewModel.loadingState {
                case .loading:
                    VStack {
                        EmptyView()
                        ProgressView()
                            .frame(maxWidth: 300)
                    }
                case .loaded(let photos):
                    ScrollView {
                        createHeader("All Topics")
                        TopicView(topicViewModel: topicViewModel)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                        createHeader("All Photos")
                        StaggeredPhotosView(photos: photos) {  photo in
                            guard let lastPhoto = photos.last else {
                                return
                            }
                            if photo.id == lastPhoto.id {
                                self.photosViewModel.loadPhotos()
                            }
                        }
                    }
                case .failed:
                    Text("An error occured while loading photos")
            }
        }
    }
    
    private func createHeader(_ from: String) -> some View {
        Text(from)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .font(.system(size: 20,weight: .bold))
            .foregroundColor(.black.opacity(0.8))
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
