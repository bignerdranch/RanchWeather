import UIKit
import CoreText

//private enum Theme {
//    enum Font {
//        static let H1 = UIFont(name: "Gotham-Book", size: 25)!
//        static let H2 = UIFont(name: "Gotham-Book", size: 17)!
//        static let H2Bold = UIFont(name: "Gotham-Bold", size: 17)!
//        static let Subtitle = UIFont(name: "Gotham-Book", size: 12)!
//        static let GothamBoldBig = UIFont(name: "Gotham-Bold", size: 52)!
//        static let BatteryName = UIFont(name: "Gotham-Book", size: 35)!
//    }
//    
//    enum Color {
//        static let DarkGray = UIColor(hex: 0x4d4e53)
//        static let TechBlue = UIColor(hex: 0x00b1eb)
//        static let CoolGray = UIColor(hex: 0xafafaf)
//        static let BDOrange = UIColor(hex: 0xe4531c)
//        static let BDBlack  = UIColor(hex: 0x000000)
//        
//        static let DangerousValue = UIColor(hex: 0xfc0303)
//        static let SafeValue = UIColor(hex: 0x4cd964)
//        
//        static let ButtonLabel = UIColor.whiteColor()
//        
//        static let NavigationBarBackground = UIColor(hex: 0x000000)
//        static let NavigationBarForeground = UIColor.whiteColor()
//    }
//    
//    static let TableViewCellMargin: CGFloat = 16
//    static let TableViewCellLayoutMargins = UIEdgeInsets(top: 8, left: TableViewCellMargin, bottom: 8, right: TableViewCellMargin)
//    static let TableViewFooterViewMargins = UIEdgeInsets(top: TableViewCellMargin, left: TableViewCellMargin, bottom: TableViewCellMargin, right: TableViewCellMargin)
//}

struct Themer {
    let theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        updateGlobalThemeSettings()
    }
    
    func updateGlobalThemeSettings() {
        updateNavigationBar()
        reloadWindow()
    }
    
    // Note: UIAppearance settings are only good for new views created and thus changing the values while the app is running
    // does not cause a visual change. To force this one hacky option is to remove everything from the view hierachy and add it back
    // which will utilize the new appearance settings.
    func reloadWindow() {
        let windows = UIApplication.shared.windows
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
    
    func updateNavigationBar() {
        let apperance = UINavigationBar.appearance()
        apperance.barTintColor = theme.backgroundColor
        apperance.titleTextAttributes = [NSForegroundColorAttributeName: theme.foregroundTextColor]
        apperance.tintColor = theme.tintColor
    }
}

enum Theme: String {
    
    case ranch = "com.ranchweather.theme-name.ranch"
    case metro = "com.ranchweather.theme-name.metro"
    
    var foregroundTextColor: UIColor {
        switch self {
        case .ranch: return UIColor(hex: 0xEE00EE)
        case .metro: return UIColor(hex: 0x33FF33)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .ranch: return UIColor(hex: 0x33FF33)
        case .metro: return UIColor(hex: 0xEE00EE)
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .ranch: return UIColor.blue
        case .metro: return UIColor.orange
        }
    }
    
}

//protocol Theme {
//    var foregroundTextColor: UIColor {get}
//    var backgroundColor: UIColor {get}
//}
//
//struct RanchTheme: Theme {
//    let foregroundTextColor = UIColor(hex: 0xEEEEEE)
//    let backgroundColor = UIColor(hex: 0x333333)
//}
//
//struct MetroTheme: Theme {
//    let foregroundTextColor = UIColor(hex: 0x333333)
//    let backgroundColor = UIColor(hex: 0xEEEEEE)
//}

//extension Themer {
//    static func set(batteryCardCell batteryCardCell: UICollectionViewCell) {
//        batteryCardCell.layer.cornerRadius = 4
//    }
//}


private extension UIColor {
    convenience init(hex: UInt32) {
        let red   = CGFloat((hex >> 16) & 0xff) / 255
        let green = CGFloat((hex >>  8) & 0xff) / 255
        let blue  = CGFloat((hex      ) & 0xff) / 255
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
