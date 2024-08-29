//
//  NavigationExample.swift
//  DagestanTrails
//
//  Created by Ramazan Abdulaev on 29.08.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation
import MapboxDirections

final class DirectionsViewModel: ObservableObject {
    private let distanceFormatter: LengthFormatter = .init()
    private let travelTimeFormatter: DateComponentsFormatter = .init()

    @Published
    var routes: [MapboxDirections.Route] = []

    init() {
        travelTimeFormatter.unitsStyle = .short
    }

    func loadRoutes() {
        let startPoint = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 46.584861, longitude: 42.604504),
                                  name: "Каменная чаша")
        let stopPoint = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 46.711811, longitude: 42.569796),
                                 name: "Белые Журавли")
        let endPoint = Waypoint(coordinate: CLLocationCoordinate2D(latitude: 46.719536, longitude: 42.554626),
                                name: "Водопад Тобот")
        let options = RouteOptions(waypoints: [startPoint, stopPoint, endPoint])
        options.includesSteps = true
        options.routeShapeResolution = .full
        options.attributeOptions = [.congestionLevel, .maximumSpeedLimit]
        options.locale = .init(identifier: "ru_RU")

        Directions.shared.calculate(options) { (session, result) in
            switch result {
                case let .failure(error):
                    print("Error calculating directions: \(error)")
                case let .success(response):
                    self.routes = response.routes ?? []
            }
        }
    }

    func formattedDistance(for route: MapboxDirections.Route) -> String {
        return distanceFormatter.string(fromMeters: route.distance)
    }

    func formattedTravelTime(for route: MapboxDirections.Route) -> String {
        return travelTimeFormatter.string(from: route.expectedTravelTime)!
    }

    func formattedTypicalTravelTime(for route: MapboxDirections.Route) -> String {
        if let typicalTravelTime = route.typicalTravelTime,
           let formattedTypicalTravelTime = travelTimeFormatter.string(from: typicalTravelTime) {
            return formattedTypicalTravelTime
        }
        else {
            return "Not available"
        }
    }

    func stepDescriptions(for step: RouteStep) -> String {
        var description: String = ""
        let direction = step.maneuverDirection?.rawValue ?? "none"
        description.append("\(step.instructions) [\(step.maneuverType) \(direction)]")
        if step.distance > 0 {
            let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
            description.append(" (\(step.transportType) for \(formattedDistance))")
        }
        return description
    }
}

struct DirectionsContentView: View {
    @ObservedObject
    var vm: DirectionsViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10, content: {
                ForEach(vm.routes, id: \.distance) { route in
                    VStack(alignment: .leading, spacing: 3) {
                        headerView(for: route)
                        ForEach(0..<route.legs.count, id: \.self) { legIdx in
                            if let source = route.legs[legIdx].source?.name,
                               let destination = route.legs[legIdx].destination?.name {
                                Text("From '\(source)' to '\(destination)'").font(.title2)
                            }
                            else {
                                Text("Steps:").font(.title2)
                            }
                            stepsView(for: route.legs[legIdx])
                        }
                    }
                }
            })
        }
        .padding(5)
        .onAppear { vm.loadRoutes() }
    }

    @ViewBuilder
    private func headerView(for route: MapboxDirections.Route) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Route: ").fontWeight(.bold)
                Text(route.description)
                    .fixedSize(horizontal: false, vertical: true)
            }
            HStack {
                Text("Distance: ").fontWeight(.bold)
                Text(vm.formattedDistance(for:route))
            }
            HStack {
                Text("ETA: ").fontWeight(.bold)
                Text(vm.formattedTravelTime(for: route))
            }
            HStack {
                Text("Typical travel time: ").fontWeight(.bold)
                Text(vm.formattedTypicalTravelTime(for: route))
            }
            Divider()
        }
    }

    @ViewBuilder
    private func stepsView(for leg: RouteLeg) -> some View {
        LazyVStack(alignment: .leading, spacing: 5, content: {
            ForEach(0..<leg.steps.count, id: \.self) { stepIdx in
                HStack {
                    Text("\(stepIdx + 1). ").fontWeight(.bold)
                    Text(vm.stepDescriptions(for: leg.steps[stepIdx]))
                }
                .padding([.top, .bottom], 3)

                Divider()
            }
        })
    }
}

#Preview {
    DirectionsContentView(vm: DirectionsViewModel())
}
