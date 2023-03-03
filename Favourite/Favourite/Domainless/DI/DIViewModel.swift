//
//  DIViewModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 03/03/23.
//

import Foundation
import Core
import Detail

public class DIViewModel: ObservableObject {
    public init(){}
    var diFavourite = DIFavourite()
    public func provideDetail() -> DetailViewModel {
        return DetailViewModel(detailServices: DetailServices(), useCase: diFavourite.favouriteUseCase)
    }
    public func provideFavourite() -> FavouriteViewModel {
        return FavouriteViewModel(useCase: diFavourite.favouriteUseCase)
    }
}
