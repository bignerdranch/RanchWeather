import UIKit

class WeatherDisplayViewController: UIViewController, Injectable {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    fileprivate var weatherService: WeatherService!
    fileprivate var locationService: LocationService!

    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        updateUI()
    }
    

    private func updateUI() {
        
        // TODO: Put common formatting of a "report" into a "report view model"
        
        let temp = Measurement(value: 72.0, unit: UnitTemperature.fahrenheit)
        let temperatureFormatter = MeasurementFormatter()
        temperatureLabel.text = temperatureFormatter.string(from: temp)
        
        // TODO: Localize
        summaryLabel.text = "Snowing"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateLabel.text = dateFormatter.string(from: Date())
        
        imageView.image = UIImage(asset: .snow)
        
        
    }
    
}

//MARK: - Injectable
extension WeatherDisplayViewController {
    func inject(weatherService: WeatherService, locationService: LocationService) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    func assertDependencies() {
        assert(weatherService != nil)
        assert(locationService != nil)
    }
}
