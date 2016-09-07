import UIKit

protocol DebugMenuViewControllerDelegate {
    func debugMenuViewControllerDidFinish(_ controller: DebugMenuViewController)
}

class DebugMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var themeSelectionSegmentControl: UISegmentedControl!
    
    fileprivate var userDefaults: UserDefaults!
    fileprivate var delegate: DebugMenuViewControllerDelegate?
    fileprivate var themer: Themer!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkDependencies()
        setupViewControllerTitles()
        setupThemeSegmentSelection()
        themeView()
        subscribeForThemeChanges()
    }
    
    deinit {
        unsubscribeForThemeChanges()
    }
    
    @IBAction private func closeMenu(sender: AnyObject) {
        delegate?.debugMenuViewControllerDidFinish(self)
    }
    
    @IBAction func themeButtonValueDidChange(_ sender: UISegmentedControl) {
        switch themeSelectionSegmentControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.theme = .day
        case 1:
            UserDefaults.standard.theme = .night
        default:
            assertionFailure("Unexpected Segment Index")
        }
    }
    
}

//MARK: - Injectable
extension DebugMenuViewController: Injectable {
    func inject(userDefaults: UserDefaults, delegate: DebugMenuViewControllerDelegate?, themer: Themer?) {
        self.userDefaults = userDefaults
        self.delegate = delegate
        self.themer = themer
    }
    
    func checkDependencies() {
        precondition(userDefaults != nil)
        precondition(themer != nil)
    }
}

//MARK: - Setup
private extension DebugMenuViewController {
    
    func setupViewControllerTitles() {
        title = NSLocalizedString("DEBUG_MENU.TITLE", comment: "Debug Menu as the name of the debug tools view")
    }
    
    func setupThemeSegmentSelection() {
        switch UserDefaults.standard.theme {
            case .day:
                themeSelectionSegmentControl.selectedSegmentIndex = 0
            case .night:
                themeSelectionSegmentControl.selectedSegmentIndex = 1
        }
    }
    
}

//MARK: - Theme Stuff
fileprivate extension DebugMenuViewController {
    
    func themeView() {
        themer.theme(view)
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
        themeView()
    }
}
