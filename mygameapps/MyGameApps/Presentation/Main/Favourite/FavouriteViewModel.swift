//
//  FavouriteViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation
import Core

class FavouriteViewModel: ObservableObject {
    @Published var favourites: [Favourite] = []
    private let useCase: FavouriteUseCaseProtocol

    init(useCase: FavouriteUseCaseProtocol) {
        self.useCase = useCase
    }

    func getAllFavourites() {
        favourites = useCase.getAllFavourites()
    }
}
