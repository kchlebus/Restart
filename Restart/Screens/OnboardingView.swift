//
//  OnboardingView.swift
//  Restart
//
//  Created by Kamil Chlebuś on 01/09/2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isAnimating: Bool = false
    @State private var textTitle: String = "Share."

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            VStack(spacing: 20) {
                Spacer()
                HeaderView(isAnimating: $isAnimating, textTitle: $textTitle)
                CenterView(isAnimating: $isAnimating, textTitle: $textTitle)
                Spacer()
                FooterView(isAnimating: $isAnimating)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            isAnimating = true
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

fileprivate struct HeaderView: View {
    @Binding var isAnimating: Bool
    @Binding var textTitle: String

    var body: some View {
        VStack(spacing: 0) {
            Text(textTitle)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .transition(.opacity)
                .id(textTitle) // optional, was a bug in previous version of the SDK
            Text("""
                It's not how much we give but
                how much love we put into giving.
                """)
                .font(.title3)
                .fontWeight(.light)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : -40)
        .animation(.easeOut(duration: 1), value: isAnimating)
    }
}

fileprivate struct CenterView: View {
    @Binding var isAnimating: Bool
    @Binding var textTitle: String
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0

    var body: some View {
        ZStack {
            CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                .offset(x: imageOffset.width * -1)
                .blur(radius: abs(imageOffset.width / 5))
                .animation(.easeOut(duration: 1), value: imageOffset)

            Image("character-1")
                .resizable()
                .scaledToFit()
                .opacity(isAnimating ? 1 : 0)
                .animation(.easeOut(duration: 0.5), value: isAnimating)
                .offset(x: imageOffset.width * 1.2, y: 0)
                .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if abs(imageOffset.width) <= 150 {
                                imageOffset = gesture.translation
                            }
                            withAnimation(.linear(duration: 0.25)) {
                                indicatorOpacity = 0
                                textTitle = "Give."
                            }
                        }
                        .onEnded { _ in
                            imageOffset = .zero
                            withAnimation(.linear(duration: 0.25)) {
                                indicatorOpacity = 1
                                textTitle = "Share."
                            }
                        }
                )
                .animation(.easeOut(duration: 1), value: imageOffset)
        }
        .overlay(alignment: .bottom) {
            Image(systemName: "arrow.left.and.right.circle")
                .font(.system(size: 44, weight: .ultraLight))
                .foregroundColor(.white)
                .offset(y: 20)
                .opacity(isAnimating ? 1 : 0)
                .animation(
                    .easeOut(duration: 1)
                    .delay(2),
                    value: isAnimating
                )
                .opacity(indicatorOpacity)
        }
    }
}

fileprivate struct FooterView: View {
    @AppStorage("onboarding") private var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @Binding var isAnimating: Bool

    var body: some View {
        ZStack {
            // 1. BACKGROUND (STATIC)
            Capsule()
                .fill(Color.white.opacity(0.2))
            Capsule()
                .fill(Color.white.opacity(0.2))
                .padding(8)
            // 2. CALL-TO-ACTION (STATIC)
            Text("Get Started")
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(.white)
                .offset(x: 20)
            // 3. CAPSULE (DYNAMIC WIDTH)
            HStack {
                Capsule()
                    .fill(Color("ColorRed"))
                    .frame(width: 80 + buttonOffset)
                Spacer(minLength: 0)
            }
            // 4. CIRCLE (DRAGGABLE)
            HStack {
                ZStack {
                    Circle()
                        .fill(Color("ColorRed"))
                    Circle()
                        .fill(.black.opacity(0.15))
                        .padding(8)
                    Image(systemName: "chevron.right.2")
                        .font(.system(size: 24, weight: .bold))
                }
                .foregroundStyle(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .offset(x: buttonOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
                                buttonOffset = gesture.translation.width
                            }
                        }
                        .onEnded { gesture in
                            if buttonOffset > buttonWidth / 2 {
                                play(sound: "chimeup", type: "mp3")
                                buttonOffset = buttonWidth - 80
                                isOnboardingViewActive = false
                            } else {
                                buttonOffset = 0
                            }
                        }
                )
                Spacer()
            }
        }
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
        .opacity(isAnimating ? 1 : 0)
        .offset(y: isAnimating ? 0 : 40)
        .animation(.easeOut(duration: 1), value: isAnimating)
    }
}
