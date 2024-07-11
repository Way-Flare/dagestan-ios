//
//  PlaceView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import DesignSystem
import NukeUI
import SwiftUI
import SUINavigation

protocol IPlaceCoordinator: ObservableObject {
    associatedtype PlaceDetailViewModel: IPlaceDetailViewModel

    var navigationStorage: NavigationStorage? { get set }
    var viewModel: PlaceDetailViewModel { get set }
    var isDetailShown: Bool { get set }

    func showPlaceDetail(placeId: Int)
}

final class PlaceCoordinator<PlaceDetailViewModel: IPlaceDetailViewModel>: IPlaceCoordinator {
    @Published var isDetailShown = false
    @Published var viewModel: PlaceDetailViewModel
    
    var navigationStorage: NavigationStorage?
        
    init(viewModel: PlaceDetailViewModel) {
        self.viewModel = viewModel
    }
    
    func showPlaceDetail(placeId: Int) {
        isDetailShown = true
    }
}



@MainActor
struct PlaceView<Coordinator: IPlaceCoordinator>: View {
    @Binding private var place: Place?
    
    @StateObject private var coordinator: Coordinator
    @OptionalEnvironmentObject private var navigationStorage: NavigationStorage?

    private var formatter: TimeSuffixFormatter {
        TimeSuffixFormatter(workTime: place?.workTime)
    }

    init(place: Binding<Place?>) where Coordinator == PlaceCoordinator<PlaceDetailViewModel> {
        _coordinator = StateObject(
            wrappedValue: PlaceCoordinator<PlaceDetailViewModel>(
                viewModel: PlaceDetailViewModel(service: MockPlaceService(), placeId: 1)
            )
        )
        self._place = place
    }

    var body: some View {
        contentView
            .cornerStyle(.constant(Grid.pt16))
            .padding(.horizontal, Grid.pt12)
            .shadow(radius: Grid.pt4)
            .frame(height: 302)
            .onAppear {
                coordinator.navigationStorage = navigationStorage
            }
            .navigation(isActive: $coordinator.isDetailShown) {
                PlaceDetailView(viewModel: coordinator.viewModel)
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
                SliderView(images: place.images)
                    .frame(height: 174)
                
                buttonsView
            }
            .cornerStyle(.constant(Grid.pt4, .bottomCorners))
            .frame(height: 174)
        }
    }

    private var buttonsView: some View {
        HStack(spacing: Grid.pt8) {
            Spacer()
            WFButtonIcon(
                icon: Image(systemName: "heart.fill"),
                size: .l,
                type: .favorite
            ) {}
                .foregroundColor(.red)
            WFButtonIcon(
                icon: DagestanTrailsAsset.close.swiftUIImage,
                size: .l,
                type: .favorite
            ) {
                place = nil
            }
        }
        .padding([.top, .trailing], Grid.pt12)
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

    @ViewBuilder
    private var titleAndRatingView: some View {
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

    @ViewBuilder private var operatingHoursView: some View {
        Group {
            Text(formatter.operatingStatus)
                .foregroundColor(formatter.operatingStatusColor)
                +
                Text(formatter.operatingStatusSuffix)
                .foregroundColor(WFColor.foregroundSoft)
        }
        .font(.manropeRegular(size: Grid.pt14))
    }

    @ViewBuilder private var routeDescriptionView: some View {
        if let shortDescription = place?.shortDescription {
            Text(shortDescription)
                .font(.manropeRegular(size: Grid.pt14))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(WFColor.foregroundPrimary)
        }
    }
}
