//
//  DetailView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI
import Core

public struct DetailMainView: View {
    
    @Binding public var dataDetail: DetailGamesModel?
    public var addFavourite: () -> Void = {}
    public var deleteFavourite: () -> Void = {}
    public init(dataDetail: Binding<DetailGamesModel?>, addFavourite: @escaping () -> Void, deleteFavourite: @escaping () -> Void) {
        self._dataDetail = dataDetail
        self.addFavourite = addFavourite
        self.deleteFavourite = deleteFavourite
    }
    
    func changeDateFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let resultString = dateFormatter.string(from: showDate)
        return resultString
    }

    public var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                AsyncImage(url: URL(string: dataDetail?.backgroundImage ?? "")) { image in
                    image
                        .resizable()

                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
                .frame(height: 300)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(dataDetail?.name ?? "")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Release date: \(changeDateFormat(dataDetail?.released ?? ""))")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("Rating: \(dataDetail?.rating ?? 0)")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        HStack {
                            Button {
                                dataDetail?.status.toggle()
                                if dataDetail?.status == true {
                                    addFavourite()
                                } else {
                                    deleteFavourite()
                                }
                            } label: {
                                Image(systemName: dataDetail?.status ?? false ? "heart.fill" : "heart")
                                    .foregroundColor(.white)
                            }
                            Text(!(dataDetail?.status ?? false) ? "Add to Favourite" : "Remove from Favourite")
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }

                    }
                    .padding(.top, 16)
                    Text(dataDetail?.descriptionRaw ?? "")
                        .padding(.top, 16)
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 1)
        }
    }
}
