import Foundation

extension UserDefaults {
    
    struct Notifications {
        static let themeDidChange = Notification.Name("com.ranchweather.notification.themeDidChange")
    }
    
    struct Key {
        static let themeIdentifier = "com.ranchweather.user-defaults.theme"

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
