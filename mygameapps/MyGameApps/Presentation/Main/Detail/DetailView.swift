//
//  DetailView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI
import Detail

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
                DetailMainView(dataDetail: $detailVM.dataDetail, addFavourite: detailVM.addDataFavourite, deleteFavourite: detailVM.deleteFavourite)
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
