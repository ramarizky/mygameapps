//
//  FavouriteRepository.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation
import CoreData

protocol FavouriteRepositoryProtocol {
    func getAllFavourites() -> [Favourite]
    func addNew(favourite: Favourite)
    func delete(favourite: Favourite)
    func searchFavourites(withKeyword keyword: String) -> [Favourite]
    func getFavouriteById(_ id: Int32) -> Favourite?
}

public class FavouriteRepository: FavouriteRepositoryProtocol {
    let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
    }

    public func getAllFavourites() -> [Favourite] {
        let request: NSFetchRequest<FavouriteEntity> = FavouriteEntity.fetchRequest()

        do {
            let results = try container.viewContext.fetch(request)
            return results.map { $0.toFavourite() }
        } catch {
            print("Error fetching favourites: \(error)")
            return []
        }
    }

    public func addNew(favourite: Favourite) {
        let context = container.viewContext
        let favouriteEntity = FavouriteEntity(context: context)
        favouriteEntity.id = favourite.id
        favouriteEntity.title = favourite.title
        favouriteEntity.image = favourite.image
        favouriteEntity.releaseDate = favourite.releaseDate
        favouriteEntity.rating = favourite.rating

        do {
            try context.save()
        } catch {
            print("Error saving favourite: \(error)")
        }
    }

    public func delete(favourite: Favourite) {
        let context = container.viewContext

        let request: NSFetchRequest<FavouriteEntity> = FavouriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", favourite.id)

        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            try context.save()
        } catch {
            print("Error deleting favourite: \(error)")
        }
    }

    public func searchFavourites(withKeyword keyword: String) -> [Favourite] {
        let request: NSFetchRequest<FavouriteEntity> = FavouriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "title contains[c] %@", keyword)

        do {
            let results = try container.viewContext.fetch(request)
            return results.map { $0.toFavourite() }
        } catch {
            print("Error searching for favourites: \(error)")
            return []
        }
    }

    public func getFavouriteById(_ id: Int32) -> Favourite? {
        let request: NSFetchRequest<FavouriteEntity> = FavouriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)

        do {
            let results = try container.viewContext.fetch(request)
            return results.first?.toFavourite()
        } catch {
            print("Error fetching favourite by id: \(error)")
            return nil
        }
    }
}

extension FavouriteEntity {
    public func toFavourite() -> Favourite {
        return Favourite(id: self.id, title: self.title ?? "", image: self.image ?? "", releaseDate: self.releaseDate ?? "", rating: self.rating)
    }
}
