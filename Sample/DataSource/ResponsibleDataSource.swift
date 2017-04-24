import UIKit
import BagOfTricks



public class CompositeDataSource: NSObject, UITableViewDataSource {
    private let sections: [UITableViewSectionDataSource]
    
    
    public init(_ section: UITableViewSectionDataSource) {
        sections = [section]
        super.init()
    }
    
    
    public init(sections: [UITableViewSectionDataSource]) {
        self.sections = sections
        super.init()
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows(in: tableView)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
}



public protocol UITableViewSectionDataSource {
    var title: String? {get}
    func numberOfRows(in tableView: UITableView) -> Int
    //We need the IndexPath here to pass to `dequeueReusableCell`. Otherwise we get the optional cell version.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}



public class CellIdentifierMemo<T: ResponsibleCell> {
    private var identifier: CellIdentifier?
    func value(_ tableView: UITableView) -> String {
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
        return given(tableView.dequeueReusableCell(withIdentifier: identifierMemo.value(tableView), for: indexPath)) {
            if let cell = $0 as? CellType {
                cell.fill(with: values[indexPath.row])
            }
        }
    }
}
