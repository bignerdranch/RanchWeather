import UIKit

// Sample: https://api.forecast.io/forecast/d40ec55206d45f90b1bfe8b40e4c7520/39.950869,-75.145728

struct ForcastIOWeatherSource: WeatherServiceDataSource {
    
    let APIKey: String
    
    init(APIKey: String) {
        self.APIKey = APIKey
    }
    
    func fetchWeatherReport(latitude: Double, longitude: Double, completion: @escaping (_ result: WeatherService.Result) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "https://api.forecast.io/forecast/\(APIKey.urlEscape())/\(latitude),\(longitude)")
        let request = URLRequest(url: url!)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let parseResponse = ForcastIOWeatherSource.ResponseParser.parse(responseData: data)
                switch parseResponse {
                case .success(let report):
                    completion(WeatherService.Result.success(report))
                case .failure(_):
                    // TODO: It's a real shame we don't bubble up a meaninful parse error
                    completion(WeatherService.Result.failure(WeatherService.Error.parseError))
                }
            } else {
                let error = WeatherService.Error.noDataError
                completion(WeatherService.Result.failure(error))
            }
        }
        dataTask.resume()
    }
    
}

extension ForcastIOWeatherSource {

    class ResponseParser {
        
        enum Result {
            case success(WeatherReport)
            case failure(ResponseParser.Error)
        }
        
        enum Error {
            case unknown
        }
        
        static func parse(responseData data: Data) -> ResponseParser.Result {
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] {
                
                if let jsonObject = jsonObject, let currentInfo = jsonObject["currently"] as? [String:AnyObject] {
                    // TODO: This style of JSON parsing is error prone, would use BNR's Freddy in production
                    let date = Date(timeIntervalSince1970: currentInfo["time"] as! TimeInterval)
                    let summary = currentInfo["summary"] as! String
                    let temperature = currentInfo["temperature"] as! Double
                    let iconName = currentInfo["icon"] as! String
                    let newReport = WeatherReport(date: date, summary: summary, temperature: temperature, iconName: iconName)
                    return ResponseParser.Result.success(newReport)
                }
                
            }
            let error = Error.unknown
            return ResponseParser.Result.failure(error)
        }
        
    }
    
}
