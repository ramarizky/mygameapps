//
//  DIContainer.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 26/02/23.
//

import Foundation
import CoreData

public class DIFavourite: ObservableObject {
    public init() {}
    public lazy var coreDataContainer: PersistenceController = {
        PersistenceController.shared
    }()
    public lazy var favouriteRepository: FavouriteRepository = {
        FavouriteRepository(container: coreDataContainer.container)
    }()
    public lazy var favouriteUseCase: FavouriteUseCase = {
        FavouriteUseCase(repository: favouriteRepository)
    }()
}
