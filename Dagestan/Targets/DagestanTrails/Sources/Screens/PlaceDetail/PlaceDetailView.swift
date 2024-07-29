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

struct PlaceDetailView<ViewModel: IPlaceDetailViewModel>: View {
    @StateObject var viewModel: ViewModel
    let routeService: IRouteService

    var body: some View {
        StretchableHeaderScrollView(showsBackdrop: $viewModel.isBackdropVisible) {
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
                if viewModel.state.data?.routes.count ?? 0 > 0 {
                    PlaceRouteInfoView(
                        type: .place(title: "Это место в маршрутах"),
                        items: viewModel.state.data?.routes.map { $0.asDomain() },
                        routeService: routeService,
                        placeService: viewModel.service
                    )
                }
                mapContainerView
                PlaceSendErrorView()
                if let place = viewModel.state.data {
                    PlaceReviewAndRatingView(
                        rating: place.rating,
                        reviewsCount: place.feedbackCount
                    )
                }
            }
            .padding(.horizontal, Grid.pt12)
            .padding(.bottom, Grid.pt82)
        }
        .font(.manropeRegular(size: Grid.pt14))
        .overlay(alignment: .bottom) { bottomContentContainerView }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        .onViewDidLoad {
            viewModel.loadPlaceDetail()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewModel.isBackdropVisible ? viewModel.state.data?.name ?? "" : "")
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
            .disabled(true)
        }
    }
    
    // TODO: Вернуть в рамках DT-191
//    @ViewBuilder private var reviewContainerView: some View {
//        if let feedbacks = viewModel.state.data?.placeFeedbacks {
//            VStack(spacing: Grid.pt24) {
//                ForEach(feedbacks, id: \.id) { feedback in
//                    UserReviewView(feedback: feedback)
//                }
//            }
//        }
//    }

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
