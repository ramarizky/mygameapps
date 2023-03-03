//
//  FavouriteUseCase.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation

protocol FavouriteUseCaseProtocol {
    func getAllFavourites() -> [Favourite]
    func addNew(favourite: Favourite)
    func delete(favourite: Favourite)
    func searchFavourites(withKeyword keyword: String) -> [Favourite]
    func getFavouriteById(_ id: Int32) -> Favourite?
}

class FavouriteUseCase: FavouriteUseCaseProtocol {
    private let repository: FavouriteRepositoryProtocol

    init(repository: FavouriteRepositoryProtocol) {
        self.repository = repository
    }

    func getAllFavourites() -> [Favourite] {
        return repository.getAllFavourites()
    }

    func addNew(favourite: Favourite) {
        repository.addNew(favourite: favourite)
    }

    func delete(favourite: Favourite) {
        repository.delete(favourite: favourite)
    }

    func searchFavourites(withKeyword keyword: String) -> [Favourite] {
        return repository.searchFavourites(withKeyword: keyword)
    }

    func getFavouriteById(_ id: Int32) -> Favourite? {
        return repository.getFavouriteById(id)
    }
}
