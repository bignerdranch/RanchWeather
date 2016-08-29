import Foundation

// Injectable is a simple protocol to help enforce Dependancy Injection.
// It is typically used on View Controllers where you don't have early 
// life cycle access and need to inject or configure required properites.
protocol Injectable {
    
    // When honoring this protocol we expect you to make a method called
    // inject() that has the needed paramaters.
    
    // assertDependencies is usually called in an life cycle method where the 
    // required depenacies should have already been set. For View Controllers,
    // viewDidLoad() is a common choice.
    func assertDependencies()
}
