import UIKit

extension UIStoryboard {
    private enum File: String {
        case main
        case weatherDisplay
        case feedback
        case debugMenu
    }
    
    private convenience init(_ file: File) {
        self.init(name: file.rawValue, bundle: nil)
    }
    
    static func weatherDisplayViewController() -> WeatherDisplayViewController {
        return UIStoryboard(.weatherDisplay).instantiateInitialViewController() as! WeatherDisplayViewController
    }
    
    static func feedbackViewController() -> FeedbackFormViewController {
        return UIStoryboard(.feedback).instantiateInitialViewController() as! FeedbackFormViewController
    }
    
    static func debugViewControllerStack(configure: (DebugMenuViewController) -> Void) -> UINavigationController {
        let navigationController = UIStoryboard(.debugMenu).instantiateInitialViewController() as! UINavigationController
        let debugMenu = navigationController.viewControllers[0] as! DebugMenuViewController
        configure(debugMenu)
        return navigationController
    }
    
}
