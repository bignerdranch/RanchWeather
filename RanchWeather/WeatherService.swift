import Foundation

protocol WeatherServiceDataSource {
    func fetchWeatherReport(latitude: Double, longitude: Double, completion: ((WeatherService.Result) -> Void))
}

struct WeatherService {
    
    enum Result {
        case success(WeatherReport)
        case failure(WeatherService.Error)
    }
    
    enum Error {
        case invalidLatitude
        case invalidLongittude
        case parseError
        case noPreparedResponse
        case networkError(NSError)
        case noDataError
    }

    
    let dataSource: WeatherServiceDataSource
    
    init(dataSource: WeatherServiceDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchWeatherReport(latitude: Double, longitude: Double, completion: @escaping (_ result: WeatherService.Result) -> Void) {
        self.dataSource.fetchWeatherReport(latitude: latitude, longitude: longitude, completion: completion)
    }
    
}
