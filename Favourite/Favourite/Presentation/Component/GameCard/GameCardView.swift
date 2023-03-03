//
//  GameCardView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI

struct GameCardView: View {
    var image = "default"
    var name = ""
    var released = ""
    var rating = 0.0
    func changeDateFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let resultString = dateFormatter.string(from: showDate!)
        return resultString
    }

    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("Gray"))
                .frame(width: 175, height: 200)
                .overlay(
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()

                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        }
                        .frame(width: 175, height: 100)
                        .cornerRadius(8)

                        Text(name)
                            .padding(.horizontal, 8)
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        HStack {
                            Text(changeDateFormat(released))
                                .foregroundColor(Color.white)
                                .font(.footnote)
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(rating))
                                .foregroundColor(Color.white)
                                .font(.footnote)
                        }
                        .padding(8)
                    }
                )
        }
    }
}

// struct GameCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameCardView(data: )
//            .previewLayout(.sizeThatFits)
//    }
// }
