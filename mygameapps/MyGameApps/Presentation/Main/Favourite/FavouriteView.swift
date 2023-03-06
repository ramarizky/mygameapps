//
//  FavouriteView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 06/02/23.
//

import SwiftUI
import Favourite

public struct FavouriteView: View {
    @StateObject var favVM: FavouriteViewModel
    @EnvironmentObject var diContainer: DIContainer
    init(favVM: FavouriteViewModel) {
        _favVM = StateObject(wrappedValue: favVM)
    }
    public var body: some View {
        VStack {
            FavouriteMainView(favourites: favVM.favourites)
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
