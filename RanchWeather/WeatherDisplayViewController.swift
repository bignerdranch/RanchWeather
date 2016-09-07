import UIKit

class WeatherDisplayViewController: UIViewController {
    
    private enum DisplayMode {
        case loading
        case info(WeatherReportViewModel)
    }
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    fileprivate var weatherService: WeatherService!
    fileprivate var location: Location!

    private var displayMode = DisplayMode.loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDependencies()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        weatherService.fetchWeatherReport(latitude: location.lat, longitude: location.lon) { [weak self] (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.handle(weatherServiceError: error)
                case .success(let report):
                    let viewModel = WeatherReportViewModel(weatherReport: report)
                    self?.displayMode = DisplayMode.info(viewModel)
                    self?.updateUI()
                }
            }
            
        }
        
    }
    
    private func handle(weatherServiceError error: WeatherService.Error) {
        switch error {
        case .invalidLatitude:
            print("invalidLatitude")
        case .invalidLongitude:
            print("invalidLongitude")
        case .parseError:
            print("parseError")
        case .noPreparedResponse:
            print("noPreparedResponse")
        case .networkError(_):
            print("networkError")
        case .noDataError:
            print("noDataError")
        }
    }

    private func updateUI() {
        
        UIView.animate(withDuration: 0.3) { 
            switch self.displayMode {
            case .loading:
                self.title = NSLocalizedString("WEATHER_DISPLAY.TITLE.LOADING", comment: "Weather Display View Controller title as the info is loading")
                self.updateAlphaForText(newAlpha: 0.3)
                self.temperatureLabel.text = nil
                self.summaryLabel.text = nil
                self.dateLabel.text = nil
            case .info(let viewModel):
                self.title = NSLocalizedString("WEATHER_DISPLAY.TITLE", comment: "Weather Display View Controller title with info loaded")
                self.updateAlphaForText(newAlpha: 1.0)
                self.temperatureLabel.text = viewModel.temperatureDescription
                self.summaryLabel.text = viewModel.report.summary
                self.dateLabel.text = viewModel.dateDescription
            }
        }
        
        // TODO: DRY up animation timings
        // Fade the image view
        UIView.transition(with: imageView, duration: 0.3, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            switch self.displayMode {
            case .loading:
                self.imageView.image = UIImage(asset: .loading)
            case .info(let viewModel):
                self.imageView.image = viewModel.icon != nil ? viewModel.icon : UIImage(asset: .loading)
            }
        }, completion: nil)
        
    }
    
    private func updateAlphaForText(newAlpha: CGFloat) {
        temperatureLabel.alpha = newAlpha
        summaryLabel.alpha = newAlpha
        dateLabel.alpha = newAlpha
    }
    
}

//MARK: - Injectable
extension WeatherDisplayViewController: Injectable {
    func inject(weatherService: WeatherService, location: Location) {
        self.weatherService = weatherService
        self.location = location
    }
    
    func checkDependencies() {
        precondition(weatherService != nil)
        precondition(location != nil)
    }
}
