import UIKit

class LaunchMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var menuDataSource: MenuTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("LAUNCH_MENU.TITLE", comment: "Ranch Weather as the name of the app, presented in the main launch menu")
        setupTableView()
    }
    
}

private extension LaunchMenuViewController {
     func setupTableView() {
        menuDataSource = MenuTableViewDataSource(menu: LaunchMenu())
        tableView.dataSource = menuDataSource
        menuDataSource?.registerCellsForTableView(tableView: tableView)
    }
}
