import UIKit

extension UIStoryboard {
    private enum Identifier: String {
        case Main
        case WeatherDisplay
        case Feedback
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
    
//    static func termsConditionsController() -> TermsConditionsViewController {
//        let navigationController = UIStoryboard(.FirstTimeUser).instantiateInitialViewController() as! UINavigationController
//        let termsConditionsViewController = navigationController.viewControllers[0] as! TermsConditionsViewController
//        return termsConditionsViewController
//    }
    

}
