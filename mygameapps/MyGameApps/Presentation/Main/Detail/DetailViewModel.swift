//
//  DetailViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import Foundation
import Combine
import CoreData
import Core

class DetailViewModel: ObservableObject {

    @Published var dataDetail: DetailGamesModel?
    @Published var detailState: DetailState = .loading
    @Published var favouriteData: Favourite?
    @Published var indexFavourite: Int = 0
    private var cancellable = Set<AnyCancellable>()
    private var detailServices: DetailProtocol
    private let useCase: FavouriteUseCaseProtocol
    init(detailServices: DetailProtocol, useCase: FavouriteUseCase) {
        self.detailServices = detailServices
        self.useCase = useCase
    }

    func loadData(_ gameId: Int) async {
        detailServices.getDetailGames(endPoint: .getDetailGames(id: String(gameId)))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    switch error as! NetworkError {
                    case .middlewareError:
                        self?.detailState = .loaded
                    }
                case .finished:
                    self?.detailState = .loaded
                }
            } receiveValue: { [weak self] result in
                self?.dataDetail = result
                self?.searchFavourite()
            }
            .store(in: &cancellable)
    }
    func addDataFavourite() {
        if let data = dataDetail {
            let favourite = Favourite(id: Int32(data.id ?? 0), title: data.name ?? "", image: data.backgroundImage ?? "", releaseDate: data.released ?? "", rating: data.rating ?? 0.0)
            useCase.addNew(favourite: favourite)
        }
    }

    func deleteFavourite() {
        if let data = favouriteData {
            useCase.delete(favourite: data)
        }
    }

    func searchFavourite() {
        favouriteData = useCase.getFavouriteById(Int32(dataDetail?.id ?? 0))
        if favouriteData != nil {
            dataDetail?.status = true
        } else {
            dataDetail?.status = false
        }
    }
}

extension DetailViewModel {
    enum DetailState {
        case loading
        case loaded
        case failed
    }
}
