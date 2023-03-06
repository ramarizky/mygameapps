//
//  HomeMainView.swift
//  Home
//
//  Created by Rizky Ramadhan on 06/03/23.
//

import SwiftUI
import Core

public struct HomeMainView<Favourite: View, Profile: View, Detail: View>: View {
    var destinationFavouriteView: Favourite
    var destinationProfileView: Profile
    var destinationDetailView: Detail
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    @Binding public var dataGames: [DataGames]
    @Binding public var selectedId: Int
    @State var isDetail: Bool = false
    public init(
        destinationFavouriteView: Favourite,
        destinationProfileView: Profile,
        destinationDetailView: Detail,
        dataGames: Binding<[DataGames]>,
        selectedId: Binding<Int>
    )
    {
        self.destinationFavouriteView = destinationFavouriteView
        self.destinationProfileView = destinationProfileView
        self.destinationDetailView = destinationDetailView
        self._dataGames = dataGames
        self._selectedId = selectedId
    }
    public var body: some View {
        VStack {
            HStack {
                Text("MyGameList")
                    .font(.title)
                    .foregroundColor(Color.white)
                Spacer()
                NavigationLink(destination: destinationFavouriteView) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.white)
                }
                .padding(.trailing, 8)
                NavigationLink(destination: destinationProfileView) {
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

                    ForEach(dataGames, id: \.id) { item in
                        NavigationLink(
                            destination: destinationDetailView,
                            isActive: $isDetail
                        ) {
                            Button(action: {
                                selectedId = item.id ?? 0
                                isDetail = true
                            }, label: {
                                GameCardView(image: item.backgroundImage ?? "", name: item.name ?? "", released: item.released ?? "", rating: item.rating ?? 0.0)
                            })
                        }
                    }

                }
            }
            .padding(.top, 8)
            Spacer()
        }
    }
}
