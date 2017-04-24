import UIKit
import BagOfTricks



class NetworkDataSource<CellType: ResponsibleCell, ValueSourceType: ValueSource>: NSObject, UITableViewDataSource where CellType.ValueObject == ValueSourceType.ValueObject {
  let dataSource = ResponsibleDataSource<CellType, ValueSourceType>()

  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections(in: tableView)
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return dataSource.tableView(tableView, cellForRowAt: indexPath)
  }
}
