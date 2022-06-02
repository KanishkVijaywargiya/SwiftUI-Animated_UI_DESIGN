//
//  ContentView.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 28/05/22.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab: Tab = .chat
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var isOpen = false
    @State var show = false
    let button = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false, animationName: "open")
    
    var body: some View {
        ZStack {
            Color("Background 2").ignoresSafeArea()
            
            sideMenuSection
            tabSelection
            
            personIconSection
            
            buttonSection
            
            tabBar
            
            if show {showOnboardView}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

extension ContentView {
    private var sideMenuSection: some View {
        SideMenu().opacity(isOpen ? 1 : 0)
            .offset(x: isOpen ? 0 : -300)
            .rotation3DEffect(.degrees(isOpen ? 0 : 30), axis: (x: 0, y: 1, z: 0))
    }
    
    private var tabSelection: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .chat: HomeView()
                case .search: Text("Search")
                case .timer: Text("Timer")
                case .bell: Text("Bell")
                case .user: Text("User")
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80)
        }
        .safeAreaInset(edge: .top) {
            Color.clear.frame(height: 104)
        }
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .rotation3DEffect(.degrees(isOpen ? 30 : 0), axis: (x: 0, y: -1, z: 0))
        .offset(x: isOpen ? 265 : 0)
        .scaleEffect(isOpen ? 0.9 : 1)
        .scaleEffect(show ? 0.92 : 1)
        .ignoresSafeArea()
    }
    
    private var personIconSection: some View {
        Image(systemName: "person")
            .frame(width: 36, height: 36)
            .foregroundColor(.black)
            .background(.white)
            .mask(Circle())
            .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
            .onTapGesture {
                HapticManager.instance.notification(type: .success)
                HapticManager.instance.impact(style: .soft)
                withAnimation(.spring()) {
                    show = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
            .offset(y: 4)
            .offset(x: isOpen ? 100 : 0)
    }
    
    private var buttonSection: some View {
        button.view()
            .frame(width: 44, height: 44)
            .mask(Circle())
            .shadow(color: Color("Shadow").opacity(0.2), radius: 5, x: 0, y: 5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .offset(x: isOpen ? 216 : 0)
            .onTapGesture {
                HapticManager.instance.notification(type: .success)
                HapticManager.instance.impact(style: .soft)
                try? button.setInput("isOpen", value: isOpen)
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    isOpen.toggle()
                }
            }
            .onChange(of: isOpen) { newValue in
                newValue ?
                UIApplication.shared.setStatusBarStyle(.lightContent, animated: true) :
                UIApplication.shared.setStatusBarStyle(.darkContent, animated: true)
            }
    }
    
    private var tabBar: some View {
        TabBar()
            .offset(y: isOpen ? 300 : 0)
            .offset(y: show ? 200 : 0)
            .offset(y: -24)
            .background(
                LinearGradient(
                    colors: [Color("Background").opacity(0), Color("Background")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height:
                        withAnimation {
                            isOpen ? 0 : 150
                        }
                      )
                .frame(maxHeight: .infinity, alignment: .bottom)
                .allowsHitTesting(false)
            )
            .ignoresSafeArea()
    }
    
    private var showOnboardView: some View {
        OnboardingView(show: $show).background(colorScheme == .dark ? .black : .white)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
            .ignoresSafeArea(.all, edges: .top)
            .transition(.move(edge: .top))
            .offset(y: show ? -10 : 0)
            .zIndex(1)
    }
}
