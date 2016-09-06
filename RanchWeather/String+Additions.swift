import Foundation

extension String {
    func urlEscape() -> String {
        let set = CharacterSet.urlQueryAllowed
        guard let result = self.addingPercentEncoding(withAllowedCharacters: set) else {
            assertionFailure("Could not escape string for URL")
            return self
        }
        return result
    }
}
