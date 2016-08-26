import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var launchMenu: Menu {
        return Menu(sections: [currentLocation, fixedLocations])
    }
    
    fileprivate var fixedLocations: MenuSection {
        let phillyTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.PHILADELPHIA_PA.TITLE", comment: "Philadelphia, PA as a fixed location menu choice")
        let philly = MenuItem(title: phillyTitle, details: nil, runAction: nil)
        
        let atlantaTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.ATLANTA_GA.TITLE", comment: "Altlanta, GA as a fixed location menu choice")
        let atlanta = MenuItem(title: atlantaTitle, details: nil, runAction: nil)
        
        let herndonTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.HERNDON_VA.TITLE", comment: "Herndon, VA as a fixed location menu choice")
        let herndon = MenuItem(title: herndonTitle, details: nil, runAction: nil)
        
        let sectionTitle = NSLocalizedString("LAUNCH_MENU.FIXED_LOCATION.TITLE", comment: "Fixed Locations as a menu section title")
        
        return MenuSection(title: sectionTitle, items: [philly, atlanta, herndon])
    }
    
    fileprivate var currentLocation: MenuSection {
        let item1Title = NSLocalizedString("LAUNCH_MENU.CURRENT_LOCATION.TITLE", comment: "Current Location as a menu choice")
        let item1 = MenuItem(title: item1Title, details: nil, runAction: nil)
        return MenuSection(title: nil, items: [item1])
    }
    
    fileprivate var menuDataSource: MenuTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("LAUNCH_MENU.TITLE", comment: "Ranch Weather as the name of the app, presented in the main launch menu")
        setupTableView()
    }
    
}

extension MenuViewController {
    fileprivate func setupTableView() {
        menuDataSource = MenuTableViewDataSource(menu: launchMenu)
        tableView.dataSource = menuDataSource
        menuDataSource?.registerCellsForTableView(tableView: tableView)
    }
}
