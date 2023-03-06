//
//  FavouriteView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 06/02/23.
//

import SwiftUI
import Core

public struct FavouriteMainView: View {
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    public var favourites: [Favourite]
    public init(favourites: [Favourite]){
        self.favourites = favourites
    }
    public var body: some View {
        VStack {
            ZStack {
                Color("GrayDark")
                if !favourites.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favourites, id: \.id) { item in
                                GameCardView(image: item.image , name: item.title, released: item.releaseDate, rating: item.rating )
                            }
                        }
                    }
                    .padding(.top, 8)
                } else {
                    Text("Data not found")
                        .font(.title)
                        .foregroundColor(Color.white)
                }
            }
            Spacer()
        }
    }
}
