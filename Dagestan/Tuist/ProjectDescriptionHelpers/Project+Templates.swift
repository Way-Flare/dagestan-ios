import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, destinations: Destinations, additionalTargets: [String]) -> Project {
        let packages: [ProjectDescription.Package] = [
            .remote(
                url: "https://github.com/mapbox/mapbox-maps-ios.git",
                requirement: .upToNextMinor(from: "11.6.0")
            ),
            .remote(
                url: "https://github.com/mapbox/mapbox-directions-swift.git",
                requirement: .upToNextMinor(from: "2.14.0")
            ),
            .remote(
                url: "https://github.com/kean/Nuke.git",
                requirement: .upToNextMajor(from: "12.7")
            ),
            .remote(
                    url: "https://github.com/appmetrica/appmetrica-sdk-ios",
                    requirement: .exact("5.7.0")
            ),

            .local(path: "../DesignSystem")
        ]
        let packageDependencies: [TargetDependency] = [
            .package(product: "MapboxMaps"),
            .package(product: "MapboxDirections"),
            .package(product: "Nuke"),
            .package(product: "NukeUI"),
            .package(product: "AppMetricaCore"),
            .package(product: "AppMetricaCrashes"),
            .package(product: "DesignSystem")
        ]

        var targets = makeAppTargets(
            name: name,
            destinations: destinations,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) } + packageDependencies
        )
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, destinations: destinations) })

        return Project(
            name: name,
            organizationName: "\(orgName).com",
            packages: packages,
            targets: targets
        )
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, destinations: Destinations) -> [Target] {
        let sources = Target.target(
            name: name,
            destinations: destinations,
            product: .framework,
            bundleId: "com.\(orgName).\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: []
        )

        return [sources]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, destinations: Destinations, dependencies: [TargetDependency]) -> [Target] {
        let swiftlintScript = """
                                   if [[ "$(uname -m)" == "arm64" ]]; then
                                       export PATH="/opt/homebrew/bin:$PATH"
                                   fi

                                   if which swiftlint >/dev/null; then
                                   swiftlint --config ".swiftlint.yml"
                                   else
                                       echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
                                   fi
                                   """

        let infoPlist: [String: Plist.Value] = [
            "CFBundleShortVersionString": .string("0.2.3"),
            "CFBundleDisplayName": .string("Dag Trails"),
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": .string("LaunchScreen"),
            "MBXAccessToken": .string("pk.eyJ1IjoidHhtaSIsImEiOiJjbG9vcHp5Z3IwMmlxMmtsOTJ5aWp5dW15In0.WLi2T_JmR50g3dTOJdPaGw"),
            "NSAppTransportSecurity": .dictionary(["NSAllowsArbitraryLoads": .boolean(true)]),
            "NSLocationAlwaysUsageDescription": .string("Access to location services will allow you to view your position on the map and make route to places"),
            "NSLocationWhenInUseUsageDescription": .string("Access to location services will allow you to view your position on the map and make route to places"),
            "NSPhotoLibraryUsageDescription": .string("We use your photos so that you can upload images and share them in the app, in reviews of places and routes."),
            "ITSAppUsesNonExemptEncryption": .boolean(false)
        ]

        let mainTarget = Target.target(
            name: name,
            destinations: destinations,
            product: .app,
            bundleId: "com.\(orgName).\(name)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            scripts: [.pre(script: swiftlintScript, name: "SwiftLint")],
            dependencies: dependencies
        )

        let testTarget = Target.target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "com.\(orgName).\(name)Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [.target(name: name)]
        )
        return [mainTarget, testTarget]
    }
}

private let orgName = "WayFlare"
