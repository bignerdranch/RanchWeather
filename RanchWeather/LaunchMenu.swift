import UIKit

struct LaunchMenu: Menu {
    
    var sections: [MenuSection] {
        return [currentLocation, fixedLocations, submitFeedback]
    }
    
    fileprivate var currentLocation: MenuSection {
        let item1Title = NSLocalizedString("LAUNCH_MENU.CURRENT_LOCATION.TITLE", comment: "Current Location as a menu choice")
        let item1 = MenuItem(title: item1Title, details: nil, runAction: { (navigationController) in
            
            if let navigationController = navigationController {
                let storyboard = UIStoryboard(name: "WeatherDisplay", bundle: nil)
                let vc = storyboard.instantiateInitialViewController() as! WeatherDisplayViewController
                
                let weatherService = WeatherService(dataSource: FixedWeatherSource())
                vc.inject(weatherService: weatherService, locationService: LocationService())
                
                navigationController.show(vc, sender: self)
            }
            
            
            
            
            
        })
        return MenuSection(title: nil, items: [item1])
    }
    
    fileprivate var fixedLocations: MenuSection {
        let phillyTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.PHILADELPHIA_PA.TITLE", comment: "Philadelphia, PA as a fixed location menu choice")
        let philly = MenuItem(title: phillyTitle, details: nil, runAction: nil)
        
        let atlantaTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.ATLANTA_GA.TITLE", comment: "Altlanta, GA as a fixed location menu choice")
        let atlanta = MenuItem(title: atlantaTitle, details: nil, runAction: nil)
        
        let herndonTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.HERNDON_VA.TITLE", comment: "Herndon, VA as a fixed location menu choice")
        let herndon = MenuItem(title: herndonTitle, details: nil, runAction: nil)
        
        let sectionTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.TITLE", comment: "Fixed Locations as a menu section title")
        
        return MenuSection(title: sectionTitle, items: [philly, atlanta, herndon])
    }
    
    fileprivate var submitFeedback: MenuSection {
        let item1Title = NSLocalizedString("LAUNCH_MENU.SEND_FEEDBACK.TITLE", comment: "Send Feedback as a menu choice")
        let item1 = MenuItem(title: item1Title, details: nil, runAction: { (navigationController) in
            
            if let navigationController = navigationController {
                let storyboard = UIStoryboard(name: "Feedback", bundle: nil)
                let vc = storyboard.instantiateInitialViewController() as! FeedbackFormViewController
                navigationController.show(vc, sender: self)
            }
            
        })
        return MenuSection(title: nil, items: [item1])
    }

}
