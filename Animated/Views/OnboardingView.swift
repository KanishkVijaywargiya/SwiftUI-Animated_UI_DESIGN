//
//  OnboardingView.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 28/05/22.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let button = RiveViewModel(fileName: "button")
    @State var showModal = false
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            background
            contentView
                .offset(y: showModal ? -50 : 0)
            
            Color("Shadow").opacity(showModal ? 0.4 : 0).ignoresSafeArea()
            
            if showModal { signInView }
            
            closingButton
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(show: .constant(true))
            .preferredColorScheme(.dark)
    }
}

extension OnboardingView {
    private var background: some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 30)
            .background(
                Image("Spline")
                    .blur(radius: 50)
                    .offset(x: 200, y: 100)
            )
    }
    private var titleText: some View {
        Text("Learn design & code")
            .font(.custom("Poppins Bold", size: 60, relativeTo: .largeTitle))
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: 260, alignment:  .leading)
    }
    private var description: some View {
        Text("Don't skip design. Learn design and code, by building real apps with React & Swift. Complete courses about the best tools.")
            .customFont(.body)
            .opacity(0.7)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var buttonAnimation: some View {
        button.view()
            .frame(width: 236, height: 64)
            .overlay(
                Label("Start the course", systemImage: "arrow.forward")
                    .offset(x: 4, y: 4)
                    .font(.headline)
                    .foregroundColor(.black)
            )
            .background(
                Color.black
                    .cornerRadius(30)
                    .blur(radius: 10)
                    .opacity(0.3)
                    .offset(y: 10)
            )
            .onTapGesture {
                HapticManager.instance.notification(type: .success)
                HapticManager.instance.impact(style: .heavy)
                button.play(animationName: "active")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    withAnimation(.spring()) {
                        showModal = true
                    }
                }
            }
    }
    private var footText: some View {
        Text("Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.")
            .customFont(.footnote)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .opacity(0.7)
    }
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleText
            description
            Spacer()
            buttonAnimation
            footText
        }
        .padding(40)
        .padding(.top, 40)
    }
    private var signInView: some View {
        SigninView(showModal: $showModal).transition(.move(edge: .top).combined(with: .opacity))
            .overlay(
                Button {
                    HapticManager.instance.notification(type: .success)
                    HapticManager.instance.impact(style: .medium)
                    withAnimation(.spring()) {
                        showModal = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 36, height: 36)
                        .foregroundColor(.black)
                        .background(.white)
                        .mask(Circle())
                        .shadow(color: Color("Shadow").opacity(0.3), radius: 5, x: 0, y: 3)
                }
                    .frame(maxHeight: .infinity, alignment: .bottom)
            ).zIndex(1)
    }
    private var closingButton: some View {
        Button {
            HapticManager.instance.notification(type: .success)
            HapticManager.instance.impact(style: .soft)
            withAnimation {
                show = false
            }
        } label: {
            Image(systemName: "xmark")
                .frame(width: 36, height: 36)
                .background(colorScheme == .dark ? .white : .black)
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .mask(Circle())
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .offset(y: showModal ? -200 : 80)
    }
}
