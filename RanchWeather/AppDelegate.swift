import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentThemer = Themer(theme: UserDefaults.standard.theme)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        listenForThemeChange()
        return true
    }

}

private extension AppDelegate {
    
    func listenForThemeChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(respondToThemeChange), name: UserDefaults.Notifications.themeDidChange, object: nil)
    }
    
    @objc func respondToThemeChange(note: Notification) {
        // Update themer
        currentThemer = Themer(theme: UserDefaults.standard.theme)
    }
    
}
