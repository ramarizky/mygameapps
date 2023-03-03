//
//  ContentView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 26/01/23.
//

import Foundation
import SwiftUI
import Core
import Home

struct ContentView: View {
    @StateObject var diViewModel = DIViewModel()
    @StateObject var diFavourite = DIFavourite()
    var body: some View {
        ZStack {
            NavigationView {
                HomeView(homeVM: diViewModel.provideHome())
            }
            .environmentObject(diViewModel)
            .environmentObject(diFavourite)
        }
        .onAppear {
            UserDefaults.standard.set("Profile", forKey: "PROFILE_IMAGE")
            UserDefaults.standard.set("Rizky Ramadhan Subagio", forKey: "PROFILE_NAME")
            UserDefaults.standard.set("iOS Developer", forKey: "PROFILE_JOB")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
