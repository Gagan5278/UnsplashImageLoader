//
//  StaggeredPhotosView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/17.
//

import SwiftUI

struct StaggeredPhotosView: View {
    let photos: [Photo]
    let onAppearCompletionHandler: ((Photo) -> Void)?
    
    
    private let paddingConstant: CGFloat = 10.0
    
    private var splittedArray: [[Photo]] {
        var splitArray: [[Photo]] = []
        
        var firstArray: [Photo] = []
        var secondArray: [Photo] = []
        
        photos.forEach { photo in
            if let index = photos.firstIndex(where: {$0.id == photo.id}) {
                if index % 2 == 0 {
                    firstArray.append(photo)
                } else {
                    secondArray.append(photo)
                }
            }Ç
        }
        splitArray.append(firstArray)
        splitArray.append(secondArray)
        return splitArray
    }
    
    var body: some View {
        HStack(alignment: .top) {
            LazyVStack(spacing: paddingConstant) {
                ForEach(splittedArray.first!) { photo in
                    PhotoTile(photo: photo)
                        .onAppear(perform: {onAppearClosure(photo)})
                }
            }
            LazyVStack(spacing: paddingConstant) {
                ForEach(splittedArray.last!) { photo in
                    PhotoTile(photo: photo)
                        .onAppear(perform: {onAppearClosure(photo)})
                }
            }
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
    
    private func onAppearClosure(_ photo: Photo) {
        guard let onAppearCompletionHandler = onAppearCompletionHandler else {
            return
        }
        onAppearCompletionHandler(photo)
    }
}

struct StaggeredPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        StaggeredPhotosView(photos: [], onAppearCompletionHandler: { _ in })
    }
}
