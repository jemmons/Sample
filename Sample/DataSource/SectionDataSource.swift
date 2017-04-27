import UIKit
import BagOfTricks



public class CellIdentifierMemo<T: ResponsibleCell> {
    private var identifier: CellIdentifier?
    func value(_ tableView: UITableView) -> CellIdentifier {
        if identifier == nil {
            identifier = T.register(with: tableView)
        }
        return identifier!
    }
}



public class SectionDataSource<CellType: ResponsibleCell>: NSObject, UITableViewSectionDataSource {
    private let identifierMemo = CellIdentifierMemo<CellType>()
    public let title: String?
    public let values: [CellType.ValueObject]

    
    public init(title: String? = nil, values: [CellType.ValueObject] = []) {
        self.title = title
        self.values = values
        super.init()
    }
    
    
    public func numberOfRows(in tableView: UITableView) -> Int {
        return values.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return given(tableView.dequeueReusableCell(withIdentifier: identifierMemo.value(tableView).identifier, for: indexPath)) {
            if let cell = $0 as? CellType {
                cell.fill(with: values[indexPath.row])
            }
        }
    }
}
