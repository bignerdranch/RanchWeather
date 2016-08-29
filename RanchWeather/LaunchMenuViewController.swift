import UIKit

class LaunchMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var menuDataSource: MenuTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllerTitles()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectTableViewRowsIfNeeded()
    }
}

//MARK: - Appearance
private extension LaunchMenuViewController {
    func deselectTableViewRowsIfNeeded() {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

//MARK: - Setup
private extension LaunchMenuViewController {
    
    func setupViewControllerTitles() {
        self.title = NSLocalizedString("LAUNCH_MENU.TITLE", comment: "Ranch Weather as the name of the app, presented in the main launch menu")
        // TODO: localize "Menu"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: nil, action: nil)
    }
    
    func setupTableView() {
        guard let navigationController = navigationController else {
            assertionFailure("We are assuming this VC is being presented in a navigation controller")
            return
        }
        
        // Use shared-code to render menu
        menuDataSource = MenuTableViewDataSource(menu: LaunchMenu(), navigationController: navigationController)
        tableView.dataSource = menuDataSource
        tableView.delegate = menuDataSource
        menuDataSource?.registerCellsForTableView(tableView: tableView)
        
    }
}
