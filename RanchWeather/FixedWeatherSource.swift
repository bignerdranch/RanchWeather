import Foundation

struct FixedWeatherSource: WeatherServiceDataSource {
    
    var report: WeatherReport?
    var error: WeatherService.Error?
    
    func fetchWeatherReport(latitude: Double, longitude: Double, completion: @escaping ((WeatherService.Result) -> Void)) {
        
        DispatchQueue.main.async {
            
            // honor the prepared error if present
            if let error = self.error {
                completion(WeatherService.Result.failure(error))
                return
            }
            
            // honor the prepared report if present
            if let report = self.report {
                completion(WeatherService.Result.success(report))
                return
            }
            
            assertionFailure("Using FixedWeatherSource we expect you to prepare a response.")
        }
        
    }
    
}
