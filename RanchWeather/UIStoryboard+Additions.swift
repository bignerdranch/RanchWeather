import UIKit

extension UIStoryboard {
    private enum Identifier: String {
        case Main
        case WeatherDisplay
        case Feedback
        case DebugMenu
    }
    
    private convenience init(_ identifier: Identifier) {
        self.init(name: identifier.rawValue, bundle: nil)
    }
    
    static func weatherDisplayViewController() -> WeatherDisplayViewController {
        return UIStoryboard(.WeatherDisplay).instantiateInitialViewController() as! WeatherDisplayViewController
    }
    
    static func feedbackViewController() -> FeedbackFormViewController {
        return UIStoryboard(.Feedback).instantiateInitialViewController() as! FeedbackFormViewController
    }
    
    static func debugViewControllerStack(configure: (DebugMenuViewController) -> Void) -> UINavigationController {
        let navigationController = UIStoryboard(.DebugMenu).instantiateInitialViewController() as! UINavigationController
        let debugMenu = navigationController.viewControllers[0] as! DebugMenuViewController
        configure(debugMenu)
        return navigationController
    }
    
}
