//
//  PlaceDetailView.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 27.04.2024.
//

import CoreKit
import CoreLocation
import DesignSystem
import MapboxMaps
import NukeUI
import SwiftUI

struct PlaceDetailView<ViewModel: IPlaceDetailViewModel>: View {
    @StateObject var viewModel: ViewModel
    @State private var scrollViewOffset: CGFloat = 0
    @State private var showingPromocodeSheet = false
    @State private var showingContactsSheet = false

    let routeService: IRouteService
    let onFavoriteAction: (() -> Void)?

    var body: some View {
        getContentView()
            .font(.manropeRegular(size: Grid.pt14))
            .overlay(alignment: .bottom) {
                if viewModel.placeDetail.data != nil {
                    bottomContentContainerView.isHidden(viewModel.placeDetail.isLoading)
                }
            }
            .onViewDidLoad {
                viewModel.loadPlaceDetail()
                viewModel.loadPlaceFeedbacks()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
            .setCustomBackButton()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.isBackdropVisible ? viewModel.placeDetail.data?.name ?? "" : "")
    }

    @ViewBuilder private var mapContainerView: some View {
        if let place = viewModel.placeDetail.data {
            Map(initialViewport: .camera(center: place.coordinate, zoom: 12.0)) {
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

    @ViewBuilder private var reviewContainerView: some View {
        if !viewModel.userFeedbacks.isEmpty {
            VStack(alignment: .leading, spacing: Grid.pt24) {
                ForEach(viewModel.userFeedbacks, id: \.id) { feedback in
                    UserReviewView(feedback: feedback)
                }
            }
        }
    }

    @ViewBuilder private var bottomContentContainerView: some View {
        if let place = viewModel.placeDetail.data {
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

                PlaceMakeRouteBottomView(
                    coordinates: [place.coordinate],
                    isFavorite: place.isFavorite,
                    onFavoriteAction: onFavoriteAction,
                    shareUrl: viewModel.sharedUrl
                )
            }
        }
    }

    @ViewBuilder func getContentView() -> some View {
        if let place = viewModel.placeDetail.data {
            ScrollViewReader { _ in
                StretchableHeaderScrollView(showsBackdrop: $viewModel.isBackdropVisible) {
                    ImageSliderView(images: place.images)
                } content: {
                    VStack(alignment: .leading, spacing: Grid.pt16) {
                        PlaceDetailInfoView(
                            place: viewModel.placeDetail.data,
                            formatter: viewModel.formatter
                        )
                        if let placeWay = place.placeWays.first {
                            PlaceWaysView(placeWay: placeWay, isFood: place.tags.first == .food)
                        }
                        if place.isPromocode && viewModel.isAuthorized {
                            if #available(iOS 16.4, *) {
                                SlideButtonView()
                                    .onSwipeSuccessAction {
                                        showingPromocodeSheet = true
                                    }
                                    .sheet(isPresented: $showingPromocodeSheet) {
                                        PromocodeView(viewModel: viewModel)
                                            .background(WFColor.surfaceQuaternary)
                                            .presentationCornerRadius(Grid.pt32)
                                            .presentationDetents([.height(UIScreen.main.bounds.height / 4)])
                                    }
                            } else {
                                SlideButtonView()
                                    .onSwipeSuccessAction {
                                        showingPromocodeSheet = true
                                    }
                                    .sheet(isPresented: $showingPromocodeSheet) {
                                        PromocodeView(viewModel: viewModel)
                                            .background(WFColor.surfaceQuaternary)
                                            .presentationDetents([.height(UIScreen.main.bounds.height / 4)])
                                    }
                            }
                        }
                        PlaceContactInformationView(
                            viewModel: viewModel, 
                            isVisible: $viewModel.isVisibleSnackbar,
                            place: viewModel.placeDetail.data
                        )
                        if !place.routes.isEmpty {
                            PlaceRouteInfoView(
                                type: .place(title: "Это место в маршрутах"),
                                items: place.routes.map { $0.asDomain() },
                                routeService: routeService,
                                placeService: viewModel.service,
                                onFavoriteAction: onFavoriteAction
                            )
                        }
                        mapContainerView
                        SendErrorButton()
                        if let place = viewModel.placeDetail.data {
                            PlaceReviewAndRatingView(
                                review: place.asDomain(),
                                feedback: viewModel.placeFeedbacks.data?.results.first,
                                isPlaces: true
                            ) {
                                viewModel.loadPlaceDetail()
                                viewModel.loadPlaceFeedbacks()
                            }
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
            }
        } else if viewModel.placeDetail.isError {
            FailedLoadingView {
                viewModel.loadPlaceDetail()
            }
        } else {
            ShimmerPlaceDetailView()
        }
    }
}
