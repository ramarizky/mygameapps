//
//  FavouriteView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 06/02/23.
//

import SwiftUI
import Core
import Detail

public struct FavouriteView: View {
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @StateObject public var favVM: FavouriteViewModel
    @StateObject public var diViewModel: DIViewModel = DIViewModel()
    public init(favVM: FavouriteViewModel) {
        _favVM = StateObject(wrappedValue: favVM)
    }
    public var body: some View {
        ZStack {
            Color("GrayDark")
            VStack {
                ZStack {
                    if !favVM.favourites.isEmpty {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(favVM.favourites, id: \.id) { item in
                                    NavigationLink(destination: DetailView(detailVM: diViewModel.provideDetail(), gameId: Int(item.id))) {
                                        GameCardView(image: item.image , name: item.title, released: item.releaseDate, rating: item.rating )
                                    }
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
        .onAppear {
            favVM.getAllFavourites()
        }
        .navigationTitle("Favourite")
    }
}

// struct FavouriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavouriteView()
//    }
// }
