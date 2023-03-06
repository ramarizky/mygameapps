//
//  HomeViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import Foundation
import Combine
import Core

class HomeViewModel: ObservableObject {

    @Published var dataGames: [DataGames] = []
    @Published var homeState: HomeState = .loading
    @Published var selectedId: Int = 0

    private var cancellable = Set<AnyCancellable>()
    private var homeServices: HomeProtocol
    init(homeServices: HomeProtocol) {
        self.homeServices = homeServices
    }
    func loadData() {
        homeServices.getListGames(endPoint: .getListGames)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    switch error as! NetworkError {
                    case .middlewareError:
                        self?.homeState = .loaded
                    }
                case .finished:
                    self?.homeState = .loaded
                }
            } receiveValue: { [weak self] result in
                self?.dataGames = result.results ?? []
            }
            .store(in: &cancellable)
    }
}

extension HomeViewModel {
    enum HomeState {
        case loading
        case loaded
        case failed
    }
}
