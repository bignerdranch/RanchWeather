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
    
}

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
