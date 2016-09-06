import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentThemer = Themer(theme: UserDefaults.standard.theme)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Inject the themer into the launch menu
        let nav = window?.rootViewController as! UINavigationController
        let menuVC = nav.topViewController as! LaunchMenuViewController
        menuVC.inject(themer: currentThemer)
        
        // setup global theme change subscriptions
        subscribeForThemeChanges()
        updateStatusBar(forTheme: UserDefaults.standard.theme)
        
        return true
    }

}

fileprivate extension AppDelegate {
    
    func subscribeForThemeChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(respondToThemeChange), name: UserDefaults.Notifications.themeDidChange, object: nil)
    }
    
    @objc func respondToThemeChange(note: Notification) {
        // Update themer
        let newTheme = UserDefaults.standard.theme
        currentThemer = Themer(theme: newTheme)
        updateStatusBar(forTheme: newTheme)
    }
    
    func updateStatusBar(forTheme theme: Theme) {
        switch theme {
        case .day:
            UIApplication.shared.statusBarStyle = .default
        case .night:
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
}
