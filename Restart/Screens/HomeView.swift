//
//  HomeView.swift
//  Restart
//
//  Created by Kamil Chlebuś on 01/09/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Home")
                .font(.largeTitle)
            Button {
                isOnboardingViewActive = true
            } label: {
                Text("Restart")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
