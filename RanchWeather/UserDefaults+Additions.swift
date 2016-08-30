import Foundation

extension UserDefaults {
    
    struct Notifications {
        static let themeDidChange = Notification.Name("com.ranchweather.notification.themeDidChange")
    }
    
    struct Key {
        static let theme = "com.ranchweather.user-defaults.theme"

    }
    
    var theme: Theme {
        get {
            if let themeName = string(forKey: Key.theme) {
                return Theme(rawValue: themeName)!
            } else {
                return Theme.ranch
            }
        }
        set {
            set(newValue.rawValue, forKey: Key.theme)
            synchronize()
            NotificationCenter.default.post(name: Notifications.themeDidChange, object: self)
        }
    }
    
}
