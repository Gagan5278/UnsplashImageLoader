//
//  ContentView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
                PhotosView()
            .navigationTitle("Unsplash Image")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink("Search") {
                        SearchPhotoView(viewModel: SearchPhotoViewModel(service: ApiManager()))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
