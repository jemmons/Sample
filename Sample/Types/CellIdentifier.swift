import Foundation



public struct CellIdentifier {
    let identifier: String

    
    init(_ identifier: String) {
        self.identifier = identifier
    }
    
    
    init(type: Any.Type) {
        self.init(String(describing: type))
    }

    
    init(instance: Any) {
        self.init(type: type(of: instance))
    }
}
