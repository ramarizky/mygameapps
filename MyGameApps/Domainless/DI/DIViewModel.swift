//
//  DIViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 03/03/23.
//

import Foundation
import Core
import Detail
import Favourite
import Home

public class DIViewModel: ObservableObject {
    var diFavourite = DIFavourite()
    func provideHome() -> HomeViewModel {
        return HomeViewModel(homeServices: HomeServices())
    }
    func provideFavourite() -> FavouriteViewModel {
        return FavouriteViewModel(useCase: diFavourite.favouriteUseCase)
    }
}
