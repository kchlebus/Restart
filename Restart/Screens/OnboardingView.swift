//
//  OnboardingView.swift
//  Restart
//
//  Created by Kamil Chlebuś on 01/09/2023.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Onboarding")
                .font(.largeTitle)
            Button {
                isOnboardingViewActive = false
            } label: {
                Text("Start")
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
