import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentThemer = Themer(theme: UserDefaults.standard.theme)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        listenForThemeChange()
        updateStatusBar(forTheme: UserDefaults.standard.theme)
        return true
    }

}

fileprivate extension AppDelegate {
    
    func listenForThemeChange() {
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
