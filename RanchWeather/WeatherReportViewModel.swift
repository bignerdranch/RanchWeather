import UIKit

struct WeatherReportViewModel {
    
    let report: WeatherReport
    
    let temperatureFormatter = MeasurementFormatter()
    
    let dateFormatter: DateFormatter =  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    init(weatherReport: WeatherReport) {
        report = weatherReport
    }
    
    var temperatureDescription: String {
        let temp = Measurement(value: report.temperature, unit: UnitTemperature.fahrenheit)
        return temperatureFormatter.string(from: temp)
    }
    
    var dateDescription: String {
        return dateFormatter.string(from: Date())
    }
    
    var icon: UIImage? {
        if let assetName = UIImage.Asset(rawValue: report.iconName), let icon = UIImage(asset: assetName) {
            return icon
        } else {
            return nil
        }
    }
    
}
