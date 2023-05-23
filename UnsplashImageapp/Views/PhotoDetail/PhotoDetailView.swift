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
    private let deviceSize = UIScreen.main.bounds
    private let downloadButtonWidthHeight: CGFloat = 60.0
    
    // MARK: - init
    init(viewModel: PhotoDetailViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }
    
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
                            downloadImageButton
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
        .navigationBarItems(leading: navigationBarBackButton)
    }
    
    private var navigationBarBackButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "chevron.backward")
                Text(viewModel.navTitle)
                Spacer()
            }
            .font(.headline)
            .foregroundColor(.white)
        }
    }
    
    private var downloadImageButton: some View {
        Button {
            viewModel.downloadPhoto()
        } label: {
            getImageIcon(for: viewModel.downloadState)
        }
        .font(.headline)
        .frame(width: downloadButtonWidthHeight, height: downloadButtonWidthHeight)
        .background(getColor(for: viewModel.downloadState))
        .cornerRadius(downloadButtonWidthHeight/2)
        .padding()
    }
    
    @ViewBuilder
    private func getImageIcon(for state: PhotoDetailViewModel.DownloadImageState) -> some View {
        switch state {
        case .initialized:
            Image(systemName:"arrow.down")
                .font(.title)
        case .loading:
            ProgressView()
                .tint(.white)
                .frame(
                    width: downloadButtonWidthHeight/2,
                    height: downloadButtonWidthHeight/2
                )
        case .downloaded:
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
        case .failed:
            Image(systemName: "exclamationmark.triangle")
                .font(.title)
        }
    }
    
    private func getColor(for state: PhotoDetailViewModel.DownloadImageState) -> Color {
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
        PhotoDetailView(viewModel: PhotoDetailViewModel(photo: SearchPhoto.dummySearchPhoto.results.first!, service: ApiManager()))
    }
}
