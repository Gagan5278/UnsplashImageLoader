//
//  LoadingVuew.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import SwiftUI

struct LoadingView: View {
    private let deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .frame(width: deviceWidth/2.0, height: 300)
            Spacer()
        }
    }
}

struct LoadingVuew_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
