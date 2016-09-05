import Foundation

struct FixedWeatherSource: WeatherServiceDataSource {
    
    var report: WeatherReport?
    
    // The delay in seconds for when a response will be provided
    var delayTime = 3.0
    
    func fetchWeatherReport(latitude: Double, longitude: Double, completion: ((WeatherService.Result) -> Void)) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            if let report = self.report {
                completion(WeatherService.Result.success(report))
            } else {
                let error = WeatherService.Error.noDataError
                completion(WeatherService.Result.failure(error))
            }
        }
        
    }
    
}
