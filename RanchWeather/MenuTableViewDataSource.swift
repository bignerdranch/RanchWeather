import UIKit

class MenuTableViewDataSource: NSObject, UITableViewDataSource {
    
    let menu: Menu
    
    init(menu: Menu) {
        self.menu = menu
    }
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.cellIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.sections[section].items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.cellIdentifier, for: indexPath)
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, indexPath: IndexPath) {
        let item = menu.sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.details
        cell.accessoryType = .disclosureIndicator
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu.sections[section].title
    }
    
}
