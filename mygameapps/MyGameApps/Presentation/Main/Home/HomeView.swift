//
//  HomeView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI
import ProfilePackage
import Home

struct HomeView: View {

    @StateObject var homeVM: HomeViewModel
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var diContainer: DIContainer

    init(homeVM: HomeViewModel) {
        _homeVM = StateObject(wrappedValue: homeVM)
    }

    var body: some View {
        ZStack {
            Color("GrayDark")
            if homeVM.homeState == .loaded {
                HomeMainView(
                    destinationFavouriteView: FavouriteView(favVM: diContainer.provideFavourite()),
                    destinationProfileView: ProfileView(),
                    destinationDetailView: DetailView(detailVM: diContainer.provideDetail(), gameId: homeVM.selectedId)
                        .environment(\.managedObjectContext, viewContext),
                    dataGames: $homeVM.dataGames,
                    selectedId: $homeVM.selectedId
                )
            }

            if homeVM.homeState == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }

            if homeVM.homeState == .failed {
                Text("Data not found")
                    .font(.title)
                    .foregroundColor(Color.white)
            }
        }
        .onAppear {
            homeVM.loadData()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                homeVM.loadData()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(homeVM: HomeViewModel(homeServices: HomeServices()))
    }
}
