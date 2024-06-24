//
//  PlaceDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import CoreKit
import CoreLocation
import DesignSystem
import SwiftUI
@_spi(Experimental)
import MapboxMaps

struct PlaceDetailView: View {
    @StateObject private var viewModel: PlaceDetailViewModel
    @State private var isBackdropVisible = false

    init(placeId: Int, service: IPlacesService) {
        _viewModel = StateObject(wrappedValue: PlaceDetailViewModel(service: service, placeId: placeId))
    }

    var body: some View {
        StretchableHeaderScrollView(showsBackdrop: $isBackdropVisible) {
            if let images = viewModel.state.data?.images {
                SliderView(images: images)
            }
        } content: {
            VStack(alignment: .leading, spacing: Grid.pt16) {
                PlaceDetailInfoView(place: viewModel.state.data, formatter: viewModel.formatter)
                PlaceContactInformationView(
                    isVisible: $viewModel.isVisibleSnackbar,
                    place: viewModel.state.data
                )
                PlaceRouteInfoView(
                    type: .place(title: "Это место в маршрутах"),
                    items: viewModel.state.data?.routes.map { $0.asDomain() }
                )
                mapContainerView
                PlaceSendErrorView()
                if let route = viewModel.state.data {
                    PlaceReviewAndRatingView(
                        rating: route.rating,
                        reviewsCount: route.placeFeedbacks.count
                    )
                }
                reviewContainerView
            }
            .padding(.horizontal, Grid.pt12)
            .padding(.bottom, Grid.pt82)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .overlay(alignment: .bottom) { bottomContentContainerView }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.loadPlaceDetail()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(isBackdropVisible ? viewModel.state.data?.name ?? "" : "")
        .navigationBarItems(leading: BackButton())
    }

    @ViewBuilder private var mapContainerView: some View {
        if let place = viewModel.state.data {
            Map(initialViewport: .camera(center: place.coordinate, zoom: 15.0)) {
                MapViewAnnotation(coordinate: place.coordinate) {
                    AnnotationView(name: place.name, workingTime: place.workTime, tagPlace: place.tags.first)
                }
            }
            .mapStyle(.streets)
            .frame(maxWidth: .infinity)
            .frame(height: Grid.pt253)
            .cornerStyle(.constant(Grid.pt12))
        }
    }

    @ViewBuilder private var reviewContainerView: some View {
        if let feedbacks = viewModel.state.data?.placeFeedbacks {
            VStack(spacing: Grid.pt24) {
                ForEach(feedbacks, id: \.id) { feedback in
                    UserReviewView(feedback: feedback)
                }
            }
        }
    }

    private var bottomContentContainerView: some View {
        VStack(spacing: .zero) {
            if viewModel.isVisibleSnackbar {
                WFSnackbar(status: .success(text: "Скопировано!"))
                    .onTapGesture {
                        withAnimation(.interactiveSpring) {
                            viewModel.isVisibleSnackbar = false
                        }
                    }
                    .padding(Grid.pt8)
            }
            PlaceMakeRouteBottomView()
        }
    }
}

#Preview {
    PlaceDetailView(placeId: 1, service: MockPlaceService())
}
