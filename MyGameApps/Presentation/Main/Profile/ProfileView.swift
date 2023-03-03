//
//  ProfileView.swift
//  MyGameApps
//
//  Created by Rizky Ramadhan on 30/01/23.
//

import SwiftUI

struct ProfileView: View {
    var image = UserDefaults.standard.string(forKey: "PROFILE_IMAGE") ?? ""
    var name = UserDefaults.standard.string(forKey: "PROFILE_NAME") ?? ""
    var job = UserDefaults.standard.string(forKey: "PROFILE_JOB") ?? ""
    var body: some View {
        ZStack {
            Color.gray
            VStack {
                Image(image)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(200)
                Text(name)
                    .foregroundColor(.white)
                    .font(.title)
                Text(job)
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
