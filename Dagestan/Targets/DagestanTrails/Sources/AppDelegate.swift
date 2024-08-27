import UIKit
import DesignSystem
import AppMetricaCore

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FontManager.registerFonts()
        let configuration = AppMetricaConfiguration(apiKey: "ca041ea3-c21d-4c43-84df-0ac1ab745f81")
        AppMetrica.activate(with: configuration!)
        window = UIWindow(frame: UIScreen.main.bounds)


        let viewController = VCClass()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }

}

final class VCClass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}
