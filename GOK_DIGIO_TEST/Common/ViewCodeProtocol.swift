import Foundation

protocol ViewCodeProtocol: AnyObject {
    func viewCodeSetup()
    func viewCodeHierarchySetup()
    func viewCodeConstraintSetup()
    func viewCodeAditionalSetup()
}

extension ViewCodeProtocol {
    func viewCodeSetup() {
        viewCodeHierarchySetup()
        viewCodeConstraintSetup()
        viewCodeAditionalSetup()
    }
    
    func viewCodeHierarchySetup() {}
    
    func viewCodeConstraintSetup() {}
    
    func viewCodeAditionalSetup() {}
}
