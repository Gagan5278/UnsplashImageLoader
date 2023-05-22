//
//  PhotoTile.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/17.
//

import SwiftUI

struct PhotoTile: View {
    let photo: Photo

    var body: some View {
        AsyncImage(url: URL(string: photo.urls.small)) { status in
            switch status {
            case .empty:
                LoadingView()
            case .success(let image):
                NavigationLink {
                    PhotoDetailView(
                        viewModel: PhotoDetailViewModel(
                            photo: photo,
                            service: ApiManager()
                        )
                    )
                } label: {
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                }
                .buttonStyle(BouncyStyle())
            case .failure:
                ErrorImageView()
            @unknown default:
                fatalError()
            }
        }
    }
}

struct PhotoTile_Previews: PreviewProvider {
    static var previews: some View {
        PhotoTile(photo: Photo(id: "1",  urls: Urls(raw: "2", full: "2", regular: "2", small: "2", thumb: "2", smallS3: "2"), description: nil, altDescription: nil, links: Links(linksSelf: "2", html: "2", download: "2", downloadLocation: "2")))
    }
}
