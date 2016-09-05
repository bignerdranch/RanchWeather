import UIKit

protocol DebugMenuViewControllerDelegate {
    func debugMenuViewControllerDidFinsih(controller: DebugMenuViewController)
}

class DebugMenuViewController: UIViewController {
    
    @IBOutlet fileprivate var themeSelectionSegmentControl: UISegmentedControl!
    
    
    fileprivate var userDefaults: UserDefaults!
    fileprivate var delegate: DebugMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        setupViewControllerTitles()
        setupThemeSegmentSelection()
    }
    
    @IBAction private func closeMenu(sender: AnyObject) {
        delegate?.debugMenuViewControllerDidFinsih(controller: self)
    }
    
    @IBAction func themeButtonValueDidChange(_ sender: UISegmentedControl) {
        switch themeSelectionSegmentControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.theme = .ranch
        case 1:
            UserDefaults.standard.theme = .metro
        default:
            assertionFailure("Unexpected Segment Index")
        }
    
    }
    
}

//MARK: - Injectable
extension DebugMenuViewController: Injectable {
    func inject(userDefaults: UserDefaults, delegate: DebugMenuViewControllerDelegate?) {
        self.userDefaults = userDefaults
        self.delegate = delegate
    }
    
    func assertDependencies() {
        assert(userDefaults != nil)
    }
}

//MARK: - Setup
private extension DebugMenuViewController {
    
    func setupViewControllerTitles() {
        title = NSLocalizedString("DEBUG_MENU.TITLE", comment: "Debug Menu as the name of the debug tools view")
    }
    
    func setupThemeSegmentSelection() {
        switch UserDefaults.standard.theme {
            case .ranch:
                themeSelectionSegmentControl.selectedSegmentIndex = 0
            case .metro:
                themeSelectionSegmentControl.selectedSegmentIndex = 1
        }
    }
    
}
