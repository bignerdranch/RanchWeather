import UIKit

// Code here was used in the slides but is not being used by this app.
// Otherwise we used this as a scratch pad to get the code we wanted on
// a slide to be syntax colored and type checked.

class Driver { }

class Car {
    
    let driver: Driver
    
    init(driver: Driver) {
        self.driver = driver
    }
    // Return from initializer without initializing all stored properties.
}

class WeatherService {}

class LocationViewController: UIViewController {
    
    var weatherService: WeatherService?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        assertionFailure("Not implimented")
    }
    
}

extension UITableView {
    
    func dequeue<V: UITableViewCell>(cellOfType type: V.Type,
                 indexPath: IndexPath, reuseIdentifier: String? = nil) -> V {
        let identifier = reuseIdentifier ?? String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? V else {
            preconditionFailure("Could not dequeue expect cell, cell type")
        }
        return cell
    }
    
}