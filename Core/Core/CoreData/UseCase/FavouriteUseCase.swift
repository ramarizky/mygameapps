//
//  FavouriteUseCase.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation

public protocol FavouriteUseCaseProtocol {
    func getAllFavourites() -> [Favourite]
    func addNew(favourite: Favourite)
    func delete(favourite: Favourite)
    func searchFavourites(withKeyword keyword: String) -> [Favourite]
    func getFavouriteById(_ id: Int32) -> Favourite?
}

public class FavouriteUseCase: FavouriteUseCaseProtocol {
    private let repository: FavouriteRepositoryProtocol

    init(repository: FavouriteRepositoryProtocol) {
        self.repository = repository
    }

    public func getAllFavourites() -> [Favourite] {
        return repository.getAllFavourites()
    }

    public func addNew(favourite: Favourite) {
        repository.addNew(favourite: favourite)
    }

    public func delete(favourite: Favourite) {
        repository.delete(favourite: favourite)
    }

    public func searchFavourites(withKeyword keyword: String) -> [Favourite] {
        return repository.searchFavourites(withKeyword: keyword)
    }

    public func getFavouriteById(_ id: Int32) -> Favourite? {
        return repository.getFavouriteById(id)
    }
}
