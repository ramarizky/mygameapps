//
//  FavouriteViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation
import Core

public class FavouriteViewModel: ObservableObject {
    @Published var favourites: [Favourite] = []
    private let useCase: FavouriteUseCaseProtocol

    public init(useCase: FavouriteUseCaseProtocol) {
        self.useCase = useCase
    }

    func getAllFavourites() {
        favourites = useCase.getAllFavourites()
    }
}
