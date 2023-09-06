//
//  HomeView.swift
//  Restart
//
//  Created by Kamil Chlebuś on 01/09/2023.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") private var isOnboardingViewActive: Bool = true
    @State private var isAnimating: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            ZStack {
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .delay(0.5)
                            .repeatForever(),
                        value: isAnimating
                    )
            }

            Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            Button {
                play(sound: "success", type: "m4a")
                isOnboardingViewActive = true
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded, weight: .bold))
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
