import UIKit

struct MenuItem {
    let title: String
    let details: String?
    let runAction: (() -> ())?
}

struct MenuSection {
    let title: String?
    let items: [MenuItem]
}

struct Menu {
    let sections: [MenuSection]
}

class MenuTableViewCell: UITableViewCell {
    static let cellIdentifier = String(describing: MenuTableViewCell.self)
}
