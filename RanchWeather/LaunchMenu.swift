import UIKit

struct LaunchMenu: Menu {
    
    var sections: [MenuSection] {
        return [currentLocation, scenarios]
    }
    
    fileprivate var currentLocation: MenuSection {
        let item1Title = NSLocalizedString("LAUNCH_MENU.CURRENT_LOCATION.TITLE", comment: "Current Location as a menu choice")
        let item1 = MenuItem(title: item1Title, details: nil, runAction: { (navigationController) in
            
            if let navigationController = navigationController {
                let vc = UIStoryboard.weatherDisplayViewController()
                let dataSource = ForcastIOWeatherSource(APIKey: ConfigurationSettings.focastIOAPIKey)
                let weatherService = WeatherService(dataSource: dataSource)
                // TODO: Would be nice to control this in defaults like theme
                let location = Locations.cocoaConfDC
                vc.inject(weatherService: weatherService, location: location)
                navigationController.show(vc, sender: self)
            }
            
        })
        return MenuSection(title: nil, items: [item1])
    }
    
    private func weatherDetailViewController(forIconName: String) -> WeatherDisplayViewController {
        let vc = UIStoryboard.weatherDisplayViewController()
        var dataSource = FixedWeatherSource()
        dataSource.report = WeatherReport(date: Date(), summary: forIconName, temperature: 123.4, iconName: forIconName)
        let weatherService = WeatherService(dataSource: dataSource)
        let location = Locations.nowhere // when using a fake data source it doesn't matter where you are
        vc.inject(weatherService: weatherService, location: location)
        return vc
    }
    
    fileprivate var scenarios: MenuSection {
        
        let scenarios = [
            [
                "title" : "LAUNCH_MENU.SCENARIOS.CLEAR_DAY.TITLE",
                "iconName" : "clear-day"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.CLEAR_NIGHT.TITLE",
                "iconName" : "clear-night"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.RAIN.TITLE",
                "iconName" : "rain"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.SNOW.TITLE",
                "iconName" : "snow"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.SLEET.TITLE",
                "iconName" : "sleet"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.WIND.TITLE",
                "iconName" : "wind"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.FOG.TITLE",
                "iconName" : "fog"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.CLOUDY.TITLE",
                "iconName" : "cloudy"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.PARTLY_CLOUDY_DAY.TITLE",
                "iconName" : "partly-cloudy-day"
            ],
            [
                "title" : "LAUNCH_MENU.SCENARIOS.PARTLY_CLOUDY_NIGHT.TITLE",
                "iconName" : "partly-cloudy-night"
            ],
        ]
        
        var items = [MenuItem]()
        for info in scenarios {
            let title = NSLocalizedString(info["title"]!, comment: "")
            let menuItem = MenuItem(title: title, details: nil) { (navigationController) in
                if let navigationController = navigationController {
                    let vc = self.weatherDetailViewController(forIconName: info["iconName"]!)
                    navigationController.show(vc, sender: self)
                }
            }
            items.append(menuItem)
        }
        
        let sectionTitle = NSLocalizedString("LAUNCH_MENU.SCENARIOS.TITLE", comment: "Scenarios as a menu section title")
        return MenuSection(title: sectionTitle, items: items)
    }
    
    // Removing feedback form for this release
//    fileprivate var submitFeedback: MenuSection {
//        let item1Title = NSLocalizedString("LAUNCH_MENU.SEND_FEEDBACK.TITLE", comment: "Send Feedback as a menu choice")
//        let item1 = MenuItem(title: item1Title, details: nil, runAction: { (navigationController) in
//            
//            if let navigationController = navigationController {
//                let vc = UIStoryboard.feedbackViewController()
//                navigationController.show(vc, sender: self)
//            }
//            
//        })
//        return MenuSection(title: nil, items: [item1])
//    }

}
