//
//  RouteDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 23.06.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import DesignSystem
import SwiftUI
@_spi(Experimental)
import MapboxMaps

struct RouteDetailView<ViewModel: IRouteDetailViewModel>: View {
    @StateObject var viewModel: ViewModel

    private let routeLayer = "route"
    private let routeFeature = "route-feature"

    var body: some View {
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
                        count: viewModel.state.data?.places.count ?? 0
                    ),
                    items: viewModel.state.data?.places.map {
                        $0.asDomain()
                    }
                )
                mapContainerView
                PlaceSendErrorView()
                if let route = viewModel.state.data {
                    PlaceReviewAndRatingView(
                        rating: route.rating,
                        reviewsCount: route.feedbackCount
                    )
                }
            }
            .padding(.horizontal, Grid.pt12)
            .padding(.bottom, Grid.pt82)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .overlay(alignment: .bottom) { PlaceMakeRouteBottomView() }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.loadRouteDetail()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.isBackdropVisible ? viewModel.state.data?.title ?? "" : "")
        .navigationBarItems(leading: BackButton())
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

#Preview {
    RouteDetailView(viewModel: RouteDetailViewModel(service: MockRouteService(), id: 1))
}
