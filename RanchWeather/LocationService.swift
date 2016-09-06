import Foundation

struct Location {
    let name: String
    let lat: Double
    let lon: Double
}

struct Locations {
    static let bigNerdRanchIGHQ = Location(name: "Big Nerd Ranch", lat: 33.759155, lon: -84.331862)
    static let cocoaConfDC = Location(name: "CocoaConf DC", lat: 38.958671, lon: -77.403905)
    static let indyHall = Location(name: "IndyHall", lat: 39.950557, lon: -75.146865)
    static let cupertino = Location(name: "CocoaConf DC", lat: 37.331695, lon: -122.030091)
    static let nowhere = Location(name: "Nowhere", lat: 0.0, lon: 0.0)
}
