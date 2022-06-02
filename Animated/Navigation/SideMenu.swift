//
//  SideMenu.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 29/05/22.
//

import SwiftUI
import RiveRuntime

struct SideMenu: View {
    @State var selectedMenu: SelectedMenu = .home
    @State var isDarkMode = false
    let icon = RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME")
    
    var body: some View {
        VStack {
            mainLayout
            
            browseLayoutTitle
            browseRowLayout

            historyLayoutTitle
            historyLayout
            
            Spacer()
            darkMode
        }
        .foregroundColor(.white)
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(Color(hex: "17203A"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}

extension SideMenu {
    private var mainLayout: some View {
        HStack {
            Image(systemName: "person")
                .padding(12)
                .background(.white.opacity(0.2))
                .mask(Circle())
            VStack(alignment: .leading, spacing: 2) {
                Text("Kanishk Vijay")
                    .customFont(.body)
                Text("UI Designer")
                    .customFont(.subheadline)
                    .opacity(0.7)
            }
            Spacer()
        }
        .padding()
    }
    
    private var browseLayoutTitle: some View {
        Text("BROWSE").customFont(.subheadline2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .opacity(0.7)
    }
    
    private var browseRowLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems) { item in
                Rectangle().frame(height: 1).opacity(0.1).padding(.horizontal, 16)
                MenuRow(item: item, selectedMenu: $selectedMenu)
            }
        }
        .padding(8)
    }
    
    private var historyLayoutTitle: some View {
        Text("HISTORY").customFont(.subheadline2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 40)
            .opacity(0.7)
    }
    
    private var historyLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems2) { item in
                Rectangle().frame(height: 1).opacity(0.1).padding(.horizontal, 16)
                MenuRow(item: item, selectedMenu: $selectedMenu)
            }
        }
        .padding(8)
    }
    
    private var darkMode: some View {
        HStack(spacing: 14) {
            menuItems3[0].icon.view().frame(width: 32, height: 32).opacity(0.6)
                .onChange(of: isDarkMode) { newValue in
                    newValue ?
                    try? menuItems3[0].icon.setInput("active", value: true) :
                    try? menuItems3[0].icon.setInput("active", value: false)
                }
            Text(menuItems3[0].text).customFont(.headline)
            Toggle("", isOn: $isDarkMode)
        }
        .padding(20)
    }
}

