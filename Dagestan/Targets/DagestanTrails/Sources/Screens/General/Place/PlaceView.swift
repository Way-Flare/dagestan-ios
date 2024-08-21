//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import DesignSystem
import NukeUI
import SwiftUI

@MainActor
struct PlaceView: View {
    @Binding private var place: Place?
    @State var showAlert = false
    @AppStorage("isAuthorized") var isAuthorized = false
    private let isLoading: Bool
    private let needClose: Bool
    private let placeDetailViewModel: PlaceDetailViewModel
    private let routeService: IRouteService

    private var formatter: TimeSuffixFormatter {
        TimeSuffixFormatter(workTime: place?.workTime)
    }

    private let onFavoriteAction: (() -> Void)?

    init(
        place: Binding<Place?>,
        isLoading: Bool,
        placeService: IPlacesService,
        routeService: IRouteService,
        needClose: Bool = true,
        favoriteAction: (() -> Void)?
    ) {
        self._place = place
        self.routeService = routeService
        self.placeDetailViewModel = PlaceDetailViewModel(
            service: placeService,
            placeId: place.wrappedValue?.id ?? .zero,
            isFavorite: place.wrappedValue?.isFavorite ?? false
        )
        self.needClose = needClose
        self.isLoading = isLoading
        self.onFavoriteAction = favoriteAction
    }

    var body: some View {
        if place != nil {
            NavigationLink(
                destination: PlaceDetailView(viewModel: placeDetailViewModel, routeService: routeService, onFavoriteAction: onFavoriteAction)
            ) {
                contentView
                    .cornerStyle(.constant(Grid.pt16))
                    .padding(.horizontal, Grid.pt12)
                    .shadow(radius: Grid.pt4)
            }
            .buttonStyle(.plain)
            .frame(height: 292)
            .notAuthorizedAlert(isPresented: $showAlert)
        }
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
        if let place {
            ZStack(alignment: .topTrailing) {
                ImageSliderView(images: place.images)
                buttonsView
            }
            .cornerStyle(.constant(Grid.pt4, .bottomCorners))
        }
    }

    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            WFButtonIcon(
                icon: place?.isFavorite == true ? DagestanTrailsAsset.heartFilled.swiftUIImage : DagestanTrailsAsset.tabHeart.swiftUIImage,
                size: .l,
                state: isLoading ? .loading : .default,
                type: .favorite
            ) {
                guard isAuthorized else {
                    showAlert = true
                    return
                }
                onFavoriteAction?()
            }
            .foregroundColor(place?.isFavorite == true ? WFColor.errorSoft : WFColor.iconInverted)
            if needClose {
                WFButtonIcon(
                    icon: DagestanTrailsAsset.close.swiftUIImage,
                    size: .l,
                    type: .favorite
                ) {
                    place = nil
                }
            }
        }
        .padding([.top, .trailing], Grid.pt12)
    }
}

// MARK: - UI Elements

extension PlaceView {
    private var descriptionView: some View {
        VStack(alignment: .leading, spacing: Grid.pt2) {
            titleAndRatingView
            operatingHoursView
            routeDescriptionView
        }
        .padding(.horizontal, Grid.pt8)
    }

    @ViewBuilder private var titleAndRatingView: some View {
        if let place {
            HStack {
                Text(place.name)
                    .foregroundColor(WFColor.foregroundPrimary)
                    .font(.manropeSemibold(size: Grid.pt18))
                    .lineLimit(1)
                Spacer()
                starRatingView
            }
        }
    }

    @ViewBuilder private var starRatingView: some View {
        if let place {
            HStack(spacing: Grid.pt4) {
                StarsView(amount: Int(place.rating ?? .zero), size: .s, type: .review)
                Text(String(place.rating ?? .zero))
                    .font(.manropeRegular(size: Grid.pt14))
                    .foregroundStyle(WFColor.foregroundSoft)
            }
        }
    }

    private var operatingHoursView: some View {
        Group {
            Text(formatter.operatingStatus.description)
                .foregroundColor(formatter.operatingStatus.descriptionColor)
            +
            Text(formatter.operatingStatus.suffix)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .foregroundStyle(WFColor.foregroundSoft)
    }

    @ViewBuilder private var routeDescriptionView: some View {
        if let shortDescription = place?.shortDescription {
            Text(shortDescription)
                .font(.manropeRegular(size: Grid.pt14))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(WFColor.foregroundPrimary)
        }
    }
}
