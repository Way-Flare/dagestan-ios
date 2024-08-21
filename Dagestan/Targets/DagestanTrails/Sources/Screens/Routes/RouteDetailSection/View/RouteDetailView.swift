//
//  RouteDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI
import MapboxMaps

struct RouteDetailView<ViewModel: IRouteDetailViewModel>: View {
    @StateObject var viewModel: ViewModel

    let placeService: IPlacesService
    let onFavoriteAction: (() -> Void)?

    private let routeLayer = "route"
    private let routeFeature = "route-feature"

    var body: some View {
        getContentView()
            .font(.manropeRegular(size: Grid.pt14))
            .onViewDidLoad {
                viewModel.loadRouteDetail()
                viewModel.loadRouteFeedbacks()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.isBackdropVisible ? viewModel.state.data?.title ?? "" : "")
            .setCustomBackButton()
    }

    @ViewBuilder private var routeInfoContainerView: some View {
        if let route = viewModel.state.data {
            VStack(alignment: .leading, spacing: Grid.pt12) {
                Text(route.title)
                    .foregroundStyle(WFColor.iconPrimary)
                    .font(.manropeExtrabold(size: 22))
                RouteCellView(
                    rating: route.rating,
                    distance: route.distance,
                    time: route.travelTime
                )
            }
        }
    }

    @ViewBuilder private var expandableTextContainerView: some View {
        if let route = viewModel.state.data, let description = route.description {
            ExpandableTextView(text: description, lineLimit: 8) { isExpanded in
                Text(isExpanded ? "свернуть" : "раскрыть")
                    .underline()
            }
            .foregroundStyle(WFColor.foregroundPrimary)
        }
    }

    @ViewBuilder
    func getContentView() -> some View {
        if let route = viewModel.state.data {
            StretchableHeaderScrollView(showsBackdrop: $viewModel.isBackdropVisible) {
                if let images = viewModel.state.data?.images {
                    SliderView(images: images)
                }
            } content: {
               VStack(alignment: .leading, spacing: Grid.pt16) {
                    routeInfoContainerView
                    expandableTextContainerView

                    PlaceRouteInfoView(
                        type: .route(
                            title: "Места в маршруте",
                            count: route.places.count
                        ),
                        items: route.places.map { $0.asDomain() },
                        routeService: viewModel.service,
                        placeService: placeService,
                        onFavoriteAction: onFavoriteAction
                    )
                    mapContainerView
                    SendErrorButton()
                    if let route = viewModel.state.data {
                        PlaceReviewAndRatingView(
                            review: route.asDomain(),
                            feedback: viewModel.routeFeedbacks.data?.results.first,
                            isPlaces: false
                        ) {
                            viewModel.loadRouteDetail()
                            viewModel.loadRouteFeedbacks()
                        }
                    }

                    reviewContainerView
                }
                .padding(.horizontal, Grid.pt12)
                .padding(.bottom, Grid.pt82)
            }
            .overlay(alignment: .bottom) {
                if let isFavorite = viewModel.state.data?.isFavorite {
                    PlaceMakeRouteBottomView(
                        isFavorite: isFavorite,
                        onFavoriteAction: onFavoriteAction,
                        shareUrl: viewModel.shareUrl
                    ).isHidden(viewModel.state.isLoading)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .scrollIndicators(.hidden)
        } else if viewModel.state.isError {
            FailedLoadingView {
                viewModel.loadRouteDetail()
            }
        } else {
            ShimmerRouteDetailView()
        }
    }

    @ViewBuilder private var reviewContainerView: some View {
        if !viewModel.userFeedbacks.isEmpty {
            VStack(alignment: .leading, spacing: Grid.pt24) {
                ForEach(viewModel.userFeedbacks, id: \.id) { feedback in
                    UserReviewView(feedback: feedback)
                }
            }
        }
    }
    private var mapContainerView: some View {
        let camera = viewModel.calculateCenterAndApproximateZoom()

        return Map(initialViewport: .camera(center: camera.center, zoom: camera.zoom)) {
            MapViewAnnotation(layerId: routeLayer, featureId: routeFeature) {
                Text("Dsadsa")
            }
            .allowOverlap(true)
            .variableAnchors(.all)
            .selected(true)

            PolylineAnnotationGroup {
                PolylineAnnotation(id: routeFeature, lineCoordinates: viewModel.routeCoordinates)
                    .lineColor("#57A9FB")
                    .lineBorderColor("#327AC2")
                    .lineWidth(10)
                    .lineBorderWidth(2)
            }
            .layerId(routeLayer)
            .lineCap(.round)
            .slot("middle")
        }
        .mapStyle(.streets)
        .frame(maxWidth: .infinity)
        .frame(height: Grid.pt253)
        .cornerStyle(.constant(Grid.pt12))
        .disabled(true)
    }
}
