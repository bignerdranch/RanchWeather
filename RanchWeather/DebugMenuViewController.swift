import UIKit

protocol DebugMenuViewControllerDelegate {
    func debugMenuViewControllerDidFinsih(controller: DebugMenuViewController)
}

class DebugMenuViewController: UIViewController {
    
    fileprivate var userDefaults: UserDefaults!
    fileprivate var delegate: DebugMenuViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        setupViewControllerTitles()
    }
    
    @IBAction private func closeMenu(sender: AnyObject) {
        delegate?.debugMenuViewControllerDidFinsih(controller: self)
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
    
}
