//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import DesignSystem
import NukeUI
import SwiftUI

struct PlaceView: View {
    @Binding var isPlaceViewVisible: Bool
    @StateObject private var viewModel: PlaceViewModel
    @State private var isActive = false

    init(place: Place, isVisible: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: PlaceViewModel(place: place))
        self._isPlaceViewVisible = isVisible
    }

    var body: some View {
        NavigationView {
            NavigationLink(destination: PlaceDetailView(placeId: 3, service: MockPlaceService()), isActive: $isActive) {
                contentView
                    .cornerStyle(.constant(Grid.pt16))
                    .padding(.horizontal, Grid.pt12)
                    .shadow(radius: Grid.pt4)
                    .onTapGesture {
                        isActive = true
                    }
            }
        }
        .frame(height: 302)
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: Grid.pt8) {
            imageView
            descriptionView
        }
        .padding(.bottom, Grid.pt12)
        .background(WFColor.surfacePrimary)
    }

    @ViewBuilder private var imageView: some View {
        ZStack(alignment: .topTrailing) {
            SliderView(images: viewModel.place.images)
            buttonsView
        }
        .cornerStyle(.constant(Grid.pt4, .bottomCorners))
        .frame(height: 174)

    }
}

// MARK: - UI Elements

extension PlaceView {
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: Grid.pt6) {
            titleAndRatingView
            operatingHoursView
            routeDescriptionView
        }
        .padding(.horizontal, Grid.pt8)
    }

    private var titleAndRatingView: some View {
        HStack {
            Text(viewModel.place.name)
                .foregroundColor(WFColor.foregroundPrimary)
                .font(.manropeSemibold(size: Grid.pt18))
                .lineLimit(1)
            Spacer()
            starRatingView
        }
        .skeleton(show: viewModel.isLoading, cornerStyle: .constant(Grid.pt4))
    }

    private var starRatingView: some View {
        HStack(spacing: Grid.pt4) {
            StarsView(amount: 1, size: .s, type: .review)
            Text(String(viewModel.place.rating ?? 0.0))
                .font(.manropeRegular(size: Grid.pt14))
                .foregroundStyle(WFColor.foregroundSoft)
        }
    }

    @ViewBuilder private var operatingHoursView: some View {
        Group {
            Text(viewModel.formatter.operatingStatus)
                .foregroundColor(viewModel.formatter.operatingStatusColor)
            +
            Text(viewModel.formatter.operatingStatusSuffix)
                .foregroundColor(WFColor.foregroundSoft)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .skeleton(show: viewModel.isLoading, cornerStyle: .constant(Grid.pt4))
    }

    @ViewBuilder private var routeDescriptionView: some View {
        if let shortDescription = viewModel.place.shortDescription {
            HStack {
                Text(shortDescription)
                    .font(.manropeRegular(size: Grid.pt14))
                    .lineLimit(3)
                    .skeleton(show: viewModel.isLoading, cornerStyle: .constant(Grid.pt4))
                Spacer()
            }
        }
    }

    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            WFButtonIcon(
                icon: viewModel.currentFavoriteImage,
                size: .l,
                type: .favorite,
                action: viewModel.onFavorite
            )
            .foregroundColor(viewModel.currentFavoriteColor)
            WFButtonIcon(
                icon: DagestanTrailsAsset.close.swiftUIImage,
                size: .l,
                type: .favorite
            ) {
                isPlaceViewVisible = false
            }
        }
        .padding([.top, .trailing], Grid.pt12)
    }
}

#Preview {
    PlaceView(place: Place.mock, isVisible: .constant(false))
}
