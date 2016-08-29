import UIKit

extension UIImage {
    enum Asset: String {
        case clearDay          = "clear-day"
        case clearNight        = "clear-night"
        case rain              = "rain"
        case snow              = "snow"
        case sleet             = "sleet"
        case wind              = "wind"
        case fog               = "fog"
        case cloudy            = "cloudy"
        case partlyCloudyDay   = "partly-cloudy-day"
        case partlyCloudyNight = "partly-cloudy-night"
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
    
}
