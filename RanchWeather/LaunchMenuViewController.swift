import UIKit

class LaunchMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var tableView: UITableView!
    
    fileprivate var menuDataSource: MenuTableViewDataSource?
    fileprivate var themer: Themer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDependencies()
        setupDebugGesture()
        setupViewControllerTitles()
        setupTableView()
        themeView()
        subscribeForThemeChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectTableViewRowsIfNeeded()
    }
    
    deinit {
        unsubscribeForThemeChanges()
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
        tapRecognizer.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func showDebugMenu(gestureRecognizer: UIGestureRecognizer) {
        let debugNavigationController = UIStoryboard.debugViewControllerStack { (debugVC) in
            debugVC.inject(userDefaults: UserDefaults.standard, delegate: self, themer: themer)
        }
        present(debugNavigationController, animated: true, completion: nil)
    }
}

//MARK: - DebugMenuViewControllerDelegate
extension LaunchMenuViewController: DebugMenuViewControllerDelegate {
    func debugMenuViewControllerDidFinish(_ controller: DebugMenuViewController) {
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
        menuDataSource = MenuTableViewDataSource(menu: LaunchMenu(), navigationController: navigationController, themer: themer)
        tableView.dataSource = menuDataSource
        tableView.delegate = menuDataSource
        menuDataSource?.registerCellsFor(tableView)
        tableView.reloadData()
        
    }
}

//MARK: - Injectable
extension LaunchMenuViewController: Injectable {
    func inject(themer: Themer) {
        self.themer = themer
    }
    
    func checkDependencies() {
        precondition(themer != nil)
    }
}

//MARK: - Theme Stuff
fileprivate extension LaunchMenuViewController {
    
    func themeView() {
        themer.theme(tableView)
        tableView.reloadData()
    }
    
    func subscribeForThemeChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(respondToThemeChange), name: UserDefaults.Notifications.themeDidChange, object: nil)
    }
    
    func unsubscribeForThemeChanges() {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.Notifications.themeDidChange, object: nil)
    }
    
    @objc func respondToThemeChange(note: Notification) {
        // Update themer
        let newTheme = UserDefaults.standard.theme
        themer = Themer(theme: newTheme)
        setupTableView() // so it picks up new themer as well
        themeView()
    }
}
