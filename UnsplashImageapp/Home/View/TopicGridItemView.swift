//
//  TopicGridItemView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import SwiftUI

struct TopicGridItemView: View {
    let topic: TopicModel
    var body: some View {
        ZStack {
            imageViewAsync
            topicInfoView
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private var imageViewAsync: some View {
        AsyncImage(url: URL(string: topic.coverPhoto.urls.small)!) { imagePhase in
            switch imagePhase {
            case .empty:
                LoadingView()
            case .failure:
                ErrorImageView()
            case .success(let image):
                image
            @unknown default:
                fatalError()
            }
        }
        .overlay(Color.gray.opacity(0.4))
        .frame(maxHeight: 100)
        .frame(maxWidth: 200)
    }
    
    private var topicInfoView: some View {
        VStack(alignment: .center, spacing: 4) {
            Text("\(topic.title)")
                .lineLimit(2)
                .foregroundColor(.white)
                .font(.system(size: 20,weight: .bold))
                .padding(10)
            Text("\(topic.totalPhotos) photos")
                .foregroundColor(.white)
                .font(.system(size: 14,weight: .medium))
       }
    }
}

struct TopicGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopicGridItemView(topic: TopicModel(id: "!", title: "12", totalPhotos: 2, coverPhoto: CoverPhoto(id: "12", urls: Urls(raw: "", full: "", regular: "", small: "", thumb: "", smallS3: ""))))
    }
}
