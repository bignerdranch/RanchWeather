import UIKit

class LaunchMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var menuDataSource: MenuTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDebugGesture()
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

//MARK: - Debug
private extension LaunchMenuViewController {
    func setupDebugGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDebugMenu))
        tapRecognizer.numberOfTapsRequired = 4
        tapRecognizer.numberOfTouchesRequired = 2
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func showDebugMenu(gestureRecognizer: UIGestureRecognizer) {
        let debugNavigationController = UIStoryboard.debugViewControllerStack { (debugVC) in
            debugVC.inject(userDefaults: UserDefaults.standard, delegate: self)
        }
        present(debugNavigationController, animated: true, completion: nil)
    }
}

//MARK: - DebugMenuViewControllerDelegate
extension LaunchMenuViewController: DebugMenuViewControllerDelegate {
    func debugMenuViewControllerDidFinsih(controller: DebugMenuViewController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Setup
private extension LaunchMenuViewController {
    
    func setupViewControllerTitles() {
        title = NSLocalizedString("LAUNCH_MENU.TITLE", comment: "Ranch Weather as the name of the app, presented in the main launch menu")
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
