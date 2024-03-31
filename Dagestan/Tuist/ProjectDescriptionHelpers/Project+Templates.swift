import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, destinations: Destinations, additionalTargets: [String]) -> Project {
        var targets = makeAppTargets(
            name: name,
            destinations: destinations,
            dependencies: additionalTargets.map { TargetDependency.target(name: $0) }
        )
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, destinations: destinations) })

        return Project(
            name: name,
            organizationName: "\(orgName).com",
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
            resources: [],
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
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
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
            scripts: [
                .pre(script: swiftlintScript, name: "swiftlint")
            ],
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
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
}

private let orgName = "WayFlare"
