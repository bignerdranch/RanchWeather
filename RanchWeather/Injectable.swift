import Foundation

// Injectable is a simple protocol to helps enforce Dependency Injection.
// It is typically used on View Controllers where you don't have early 
// life-cycle access and need to inject or configure required properties
// after the object has been initialized.
protocol Injectable {
    
    // When honoring this protocol we expect you to make a method called
    // inject() that has the needed properties for this object.
    
    // checkDependencies is a method intended to verify that our
    // implicitly unwrapped optionals preconditions have been populated.
    // It should called in an early life-cycle method where the
    // required dependancies should have already been set. 
    // For View Controllers, viewDidLoad() is a common choice.
    func checkDependencies()
}
