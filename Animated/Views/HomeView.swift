//
//  HomeView.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 29/05/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    courseTitle
                    vCards
                    recent
                    hCards
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var courseTitle: some View {
        Text("Courses")
            .customFont(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    private var vCards: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(courses) { course in
                    VCard(course: course)
                }
            }
            .padding(20)
            .padding(.bottom, 10)
        }
    }
    private var recent: some View {
        Text("Recent")
            .customFont(.title3)
            .padding(.horizontal, 20)
    }
    private var hCards: some View {
        VStack(spacing: 20) {
            ForEach(courseSections) { section in
                HCard(section: section)
            }
        }
        .padding(20)
    }
}
