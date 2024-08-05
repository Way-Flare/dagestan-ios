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
    @State private var scrollViewOffset: CGFloat = 0

    let routeService: IRouteService
    let onFavoriteAction: (() -> Void)?

    var body: some View {
        getContentView()
            .font(.manropeRegular(size: Grid.pt14))
            .overlay(alignment: .bottom) {
                if  viewModel.state.data != nil {
                    bottomContentContainerView.isHidden(viewModel.state.isLoading)
                }
            }
            .onViewDidLoad {
                viewModel.loadPlaceDetail()
                viewModel.loadPlaceFeedbacks()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(WFColor.surfaceTertiary, ignoresSafeAreaEdges: .all)
            .navigationBarBackButtonHidden(true)
            .navigationTitle(viewModel.isBackdropVisible ? viewModel.state.data?.name ?? "" : "")
            .setCustomBackButton()
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

    @ViewBuilder private var reviewContainerView: some View {
        if let feedbacks = viewModel.placeFeedbacks.data?.results {
            VStack(alignment: .leading, spacing: Grid.pt24) {
                ForEach(feedbacks, id: \.id) { feedback in
                    UserReviewView(feedback: feedback)
                }
            }
        }
    }

    @ViewBuilder private var bottomContentContainerView: some View {
        if let isFavorite = viewModel.state.data?.isFavorite {
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
                    isFavorite: isFavorite,
                    onFavoriteAction: onFavoriteAction,
                    shareUrl: viewModel.sharedUrl
                )
            }
        }
    }

    @ViewBuilder 
    func getContentView() -> some View {
        if let place = viewModel.state.data {
            ScrollViewReader { proxy in
                StretchableHeaderScrollView(
                    showsBackdrop: $viewModel.isBackdropVisible,
                    scrollViewOffset: $scrollViewOffset
                ) {
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
                                items: viewModel.state.data?.routes.map { $0.asDomain() }
                            )
                        }
                        mapContainerView
                        Link(destination: URL(string: "https://wa.me/message/R5ZOYUTGMW4BH1")!) {
                            PlaceSendErrorView()
                        }
                        if let place = viewModel.state.data {
                            PlaceReviewAndRatingView(review: place.asDomain(), isPlaces: true) {
                                viewModel.loadPlaceDetail()
                                viewModel.loadPlaceFeedbacks()
                            }
                        }
                        reviewContainerView
                    }
                    .padding(.horizontal, Grid.pt12)
                    .padding(.bottom, Grid.pt82)
                }
                .onAppear {
                    proxy.scrollTo(scrollViewOffset, anchor: .center)
                }
                .font(.manropeRegular(size: Grid.pt14))
                .overlay(alignment: .bottom) { bottomContentContainerView }
                .edgesIgnoringSafeArea(.top)
                .scrollIndicators(.hidden)
            }
        } else if viewModel.state.isError {
            FailedLoadingView {
                viewModel.loadPlaceDetail()
            }
        } else {
            ShimmerPlaceDetailView()
        }
    }
}
