//
//  FavouriteListModel.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 22/02/23.
//

import Foundation
import CoreData

public struct Favourite {
    public init(id: Int32, title: String, image: String, releaseDate: String, rating: Double){
        self.id = id
        self.title = title
        self.image = image
        self.releaseDate = releaseDate
        self.rating = rating
    }
    public let id: Int32
    public let title: String
    public let image: String
    public let releaseDate: String
    public let rating: Double
}
