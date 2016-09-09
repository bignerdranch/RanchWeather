import Foundation

extension UserDefaults {
    
    enum Key {
        static let themeIdentifier = "com.ranchweather.userdefaults.theme"
    }
    
    enum Notifications {
        static let themeDidChange = Notification.Name("com.ranchweather.notification.themeDidChange")
    }
    
    var theme: Theme {
        get {
            if let themeIdentifier = string(forKey: Key.themeIdentifier), let foundTheme = Theme(rawValue: themeIdentifier) {
                return foundTheme
            } else {
                return Theme.day
            }
        }
        set {
            set(newValue.rawValue, forKey: Key.themeIdentifier)
            NotificationCenter.default.post(name: Notifications.themeDidChange, object: self)
        }
    }
    
}
