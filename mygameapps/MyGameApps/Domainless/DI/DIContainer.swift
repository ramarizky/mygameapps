//
//  DIContainer.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 26/02/23.
//

import Foundation
import CoreData

class DIContainer: ObservableObject {
    lazy var coreDataContainer: PersistenceController = {
        PersistenceController.shared
    }()
    lazy var favouriteRepository: FavouriteRepository = {
        FavouriteRepository(container: coreDataContainer.container)
    }()
    lazy var favouriteUseCase: FavouriteUseCase = {
        FavouriteUseCase(repository: favouriteRepository)
    }()
    func provideHome() -> HomeViewModel {
        return HomeViewModel(homeServices: HomeServices())
    }
    func provideDetail() -> DetailViewModel {
        return DetailViewModel(detailServices: DetailServices(), useCase: favouriteUseCase)
    }
    func provideFavourite() -> FavouriteViewModel {
        return FavouriteViewModel(useCase: favouriteUseCase)
    }
}
