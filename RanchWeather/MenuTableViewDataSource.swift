import UIKit

class MenuTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let menu: Menu
    let navigationController: UINavigationController
    let themer: Themer?
    
    init(menu: Menu, navigationController: UINavigationController, themer: Themer?) {
        self.menu = menu
        self.navigationController = navigationController
        self.themer = themer
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
        themer?.theme(tableViewCell: cell)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menu.sections[indexPath.section].items[indexPath.row]
        if let runAction = item.runAction {
            runAction(navigationController)
        } else {
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}
