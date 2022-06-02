//
//  VCard.swift
//  Animated
//
//  Created by Kanishk Vijaywargiya on 29/05/22.
//

import SwiftUI

struct VCard: View {
    var course: Course
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
            subTitle
            caption
            Spacer()
            avatarSection
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(
            .linearGradient(
                colors: [course.color, course.color.opacity(0.5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .overlay(courseImage)
    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCard(course: courses[0]).previewLayout(.sizeThatFits)
    }
}

extension VCard {
    private var title: some View {
        Text(course.title)
            .customFont(.title2)
            .frame(maxWidth: 170, alignment: .leading)
            .layoutPriority(1)
    }
    private var subTitle: some View {
        Text(course.subtitle)
            .customFont(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(0.7)
    }
    private var caption: some View {
        Text(course.caption.uppercased())
            .customFont(.footnote2)
    }
    private var avatarSection: some View {
        HStack {
            ForEach(Array([4, 5, 6].shuffled().enumerated()), id: \.offset) { index, number in
                Image("Avatar \(number)")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .mask(Circle())
                    .offset(x: CGFloat(index * -20))
            }
        }
    }
    private var courseImage: some View {
        course.image
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
    }
}
