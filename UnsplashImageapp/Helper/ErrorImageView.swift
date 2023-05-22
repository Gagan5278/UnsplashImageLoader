//
//  ErrorImageView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/22.
//

import SwiftUI

struct ErrorImageView: View {
    var body: some View {
        Image(systemName: "exclamationmark.triangle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.red)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
    }
}

struct ErrorImageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorImageView()
    }
}
