import UIKit

struct MenuItem {
    let title: String
    let details: String?
    let runAction: ((UINavigationController?) -> ())?
}

struct MenuSection {
    let title: String?
    let items: [MenuItem]
}

protocol Menu {
    var sections: [MenuSection] {get}
}

class MenuTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: MenuTableViewCell.self)
}
