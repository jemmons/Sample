import UIKit



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
