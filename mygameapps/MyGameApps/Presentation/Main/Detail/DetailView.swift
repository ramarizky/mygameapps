//
//  DetailView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI

struct DetailView: View {

    var gameId: Int
    @StateObject var detailVM: DetailViewModel
    @State var indexDataFavourite = 0
    @Environment(\.managedObjectContext) private var viewContext
    init(detailVM: DetailViewModel, gameId: Int) {
        _detailVM = StateObject(wrappedValue: detailVM)
        self.gameId = gameId
    }

    var body: some View {
        ZStack {
            Color("Gray")
            if detailVM.detailState == .loaded {
                VStack(alignment: .leading) {
                    ScrollView {
                        AsyncImage(url: URL(string: detailVM.dataDetail?.backgroundImage ?? "")) { image in
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
                                    Text(detailVM.dataDetail?.name ?? "")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Release date: \(detailVM.changeDateFormat(detailVM.dataDetail?.released ?? ""))")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    Text("Rating: \(detailVM.dataDetail?.rating ?? 0)")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                                Spacer()
                                HStack {
                                    Button {
                                        detailVM.dataDetail?.status.toggle()
                                        if detailVM.dataDetail?.status == true {
                                            detailVM.addDataFavourite()
                                        } else {
                                            detailVM.deleteFavourite()
                                        }
                                    } label: {
                                        Image(systemName: detailVM.dataDetail?.status ?? false ? "heart.fill" : "heart")
                                            .foregroundColor(.white)
                                    }
                                    Text(!(detailVM.dataDetail?.status ?? false) ? "Add to Favourite" : "Remove from Favourite")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }

                            }
                            .padding(.top, 16)
                            Text(detailVM.dataDetail?.descriptionRaw ?? "")
                                .padding(.top, 16)
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 1)
                }
            }

            if detailVM.detailState == .loading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }

            if detailVM.detailState == .failed {
                Text("Data not found")
                    .font(.title)
                    .foregroundColor(Color.white)
            }
        }
        .onAppear {
            Task.init {
                await detailVM.loadData(gameId)
            }
        }
        .navigationTitle(detailVM.dataDetail?.name ?? "")
    }
}

// struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(detailVM: DetailViewModel(), gameId: 3328)
//    }
// }
