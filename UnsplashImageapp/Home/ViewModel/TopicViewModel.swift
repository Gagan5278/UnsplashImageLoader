//
//  TopicViewModel.swift
//  UnsplashImageapp
//
//  Created by Gagan Vishal  on 2023/05/16.
//

import Foundation

class TopicViewModel: ObservableObject {
    enum TopicState {
        case loading
        case loaded([TopicModel])
        case failed
    }
    
    @Published var state: TopicState = .loading
    
    private let service:  any ApiManagerProtocol
    private let endPoint: EndPointProtocol
    // MARK: - init
    init(service: any ApiManagerProtocol, endPoint: EndPointProtocol) {
        self.service = service
        self.endPoint = endPoint
        loadTopics()
    }
    
    func loadTopics() {
        Task { @MainActor in
            do {
                if let topics = try await self.service.callService(endPoint: self.endPoint, model: [TopicModel].self) {
                    state = .loaded(topics)
                } else {
                    state = .failed
                }
            } catch {
                state = .failed
            }
        }
    }
}
