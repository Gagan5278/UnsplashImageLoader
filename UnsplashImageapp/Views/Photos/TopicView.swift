//
//  TopicView.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import SwiftUI

struct TopicView: View {
    
    @ObservedObject var topicViewModel: TopicViewModel
    
    // MARK: -  init
    init(topicViewModel: TopicViewModel) {
        _topicViewModel = ObservedObject(wrappedValue: topicViewModel)
    }
    
    var body: some View {
        switch topicViewModel.state {
        case .failed:
            Text("Error in loading topics")
        case .loaded(let topics):
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(topics) { topic in
                        TopicGridItemView(topic: topic)
                    }
                }
            }
        case .loading:
            ProgressView()
        }
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView(topicViewModel: TopicViewModel(service: ApiManager(), endPoint: EndPoint.allTopics))
    }
}
