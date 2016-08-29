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
        
        // Use shared-code to render menu
        menuDataSource = MenuTableViewDataSource(menu: LaunchMenu())
        tableView.dataSource = menuDataSource
        menuDataSource?.registerCellsForTableView(tableView: tableView)
        
        // Use custom code to react to menu
        
        tableView.delegate = self
        
    }
}

extension LaunchMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "WeatherDisplay", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! WeatherDisplayViewController
        
        let weatherService = WeatherService(dataSource: FixedWeatherSource())
        vc.inject(weatherService: weatherService, locationService: LocationService())

        navigationController?.show(vc, sender: self)
    }
    
}
