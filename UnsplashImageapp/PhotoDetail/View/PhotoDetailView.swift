//
//  PhotoDetailView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import SwiftUI

struct PhotoDetailView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel: PhotoDetailViewModel
    
    // MARK: - init
    init(viewModel: PhotoDetailViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
    private let deviceSize = UIScreen.main.bounds
    var body: some View {
        AsyncImage(url: URL(string: viewModel.fullURLString)) { status in
            switch status {
            case .empty:
                ZStack {
                    Color.white
                        .ignoresSafeArea()
                    LoadingView()
                }
            case .success(let image):
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    ScrollView {
                        VStack  {
                            image
                                .resizable()
                                .scaledToFill()
                            Text(viewModel.description)
                                .foregroundColor(.white)
                            Spacer()
                            Button {
                                viewModel.downloadPhoto()
                            } label: {
                                getImageIcon(for: viewModel.downloadState)
                            }
                            .font(.headline)
                            .frame(width: 56, height: 56)
                            .background(getColor(for: viewModel.downloadState))
                            .cornerRadius(28)
                            .padding()
                        }
                        .foregroundColor(.white)
                    }
                }
            case .failure:
                ErrorImageView()
            @unknown default:
                fatalError()
            }
        }
        .navigationBarTitle("",displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                Text(viewModel.navTitle)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    @ViewBuilder func getImageIcon(for state: PhotoDetailViewModel.DownloadImageState) -> some View {
        switch state {
        case .initialized:
            Image(systemName:"arrow.down")
                .font(.title)
        case .loading:
            ProgressView()
                .tint(.white)
                .frame(width: 30, height: 30)
        case .downloaded:
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
        case .failed:
            Image(systemName: "exclamationmark.triangle")
                .font(.title)
        }
    }
    
    func getColor(for state: PhotoDetailViewModel.DownloadImageState) -> Color {
        switch state {
        case .initialized:
            return Color.gray
        case .loading:
            return Color.blue
        case .downloaded:
            return Color.green
        case .failed:
            return Color.red
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(viewModel: PhotoDetailViewModel(photo: Photo(id: "1",  urls: Urls(raw: "2", full: "2", regular: "2", small: "2", thumb: "2", smallS3: "2"), description: nil, altDescription: nil, links: Links(linksSelf: "2", html: "2", download: "2", downloadLocation: "2")), service: ApiManager()))
    }
}
