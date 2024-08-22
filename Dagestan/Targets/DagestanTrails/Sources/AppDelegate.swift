import UIKit
import DesignSystem

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FontManager.registerFonts()
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
