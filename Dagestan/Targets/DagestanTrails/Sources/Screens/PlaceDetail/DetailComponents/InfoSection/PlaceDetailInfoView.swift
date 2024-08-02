//
//  PlaceDetailInfoView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 18.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI

struct PlaceDetailInfoView: View {
    let place: PlaceDetail?
    let formatter: TimeSuffixFormatter
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            tagsContainerView
            ratingContainerView
            operatingHoursView
            expandableTextContainerView
        }
    }
    
    @ViewBuilder private var tagsContainerView: some View {
        if let tags = place?.tags {
            ForEach(tags, id: \.self) { tag in
                HStack(spacing: Grid.pt8) {
                    tag.icon
                        .resizable()
                        .frame(width: Grid.pt16, height: Grid.pt16)
                    Text(tag.name)
                }
                .foregroundStyle(WFColor.foregroundSoft)
            }
        }
    }
    
    @ViewBuilder private var ratingContainerView: some View {
        if let place {
            HStack {
                Text(place.name)
                    .font(.manropeExtrabold(size: Grid.pt22))
                Spacer()
                HStack(spacing: Grid.pt4) {
                    StarsView(amount: Int(place.rating), size: .s, type: .review)
                    Text(String(Double(place.rating)))
                        .foregroundStyle(WFColor.foregroundSoft)
                }
            }
        }
    }
    
    @ViewBuilder private var operatingHoursView: some View {
        Group {
            Text(formatter.operatingStatus)
                .foregroundColor(formatter.operatingStatusColor)
            +
            Text(formatter.operatingStatusSuffix)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .foregroundStyle(WFColor.foregroundSoft)
    }
    
    @ViewBuilder private var expandableTextContainerView: some View {
        if let description = place?.description {
            ExpandableTextView(text: description, lineLimit: 8) { isExpanded in
                Text(isExpanded ? "свернуть" : "раскрыть")
                    .underline()
            }
            .foregroundStyle(WFColor.foregroundPrimary)
        }
    }
}
