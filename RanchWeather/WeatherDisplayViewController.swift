import UIKit

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
