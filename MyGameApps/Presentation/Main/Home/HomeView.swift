//
//  HomeView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI

struct HomeView: View {

    @StateObject var homeVM: HomeViewModel
    @Environment(\.scenePhase) var scenePhase
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var diContainer: DIContainer

    init(homeVM: HomeViewModel) {
        _homeVM = StateObject(wrappedValue: homeVM)
    }

    var body: some View {
        ZStack {
            Color("GrayDark")
            if homeVM.homeState == .loaded {
                VStack {
                    HStack {
                        Text("MyGameList")
                            .font(.title)
                            .foregroundColor(Color.white)
                        Spacer()
                        NavigationLink(destination: FavouriteView(favVM: diContainer.provideFavourite())) {
                            Image(systemName: "heart.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 8)
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(16)

                    Divider()
                        .overlay(.white)

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {

                            ForEach(homeVM.dataGames, id: \.id) { item in
                                NavigationLink(
                                    destination:
                                        DetailView(detailVM: diContainer.provideDetail(), gameId: item.id ?? 0)
                                        .environment(\.managedObjectContext, viewContext)
                                ) {
                                    GameCardView(image: item.backgroundImage ?? "", name: item.name ?? "", released: item.released ?? "", rating: item.rating ?? 0.0)
                                }
                            }

                        }
                    }
                    .padding(.top, 8)
                    Spacer()
                }
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
