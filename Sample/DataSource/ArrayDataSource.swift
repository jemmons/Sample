import UIKit
import BagOfTricks



public struct DataSourceDelegate {
  var whenEmpty: ()->Void = {}
  var whenLoaded: ()->Void = {}
}



public class JSONDataSource: NSObject, UITableViewDataSource {
  public var delegate = DataSourceDelegate()
  fileprivate let cellIdentifier: CellIdentifier
  
  
  public var source: [JSONObject] = [] {
    didSet{
      dispatchDelegates()
    }
  }
  
  
  public init(cellIdentifier: CellIdentifier) {
    self.cellIdentifier = cellIdentifier
  }
  
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return source.count
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return given(tableView.dequeueReusableCell(withIdentifier: cellIdentifier.id, for: indexPath)) {
      if let responsibleCell = $0 as? ResponsibleJSONCell {
        let json = source[indexPath.row]
        responsibleCell.fill(with: json)
      }
    }
  }
}



private extension JSONDataSource {
  func dispatchDelegates() {
    switch source.isEmpty {
    case true:
      delegate.whenEmpty()
    case false:
      delegate.whenLoaded()
    }
  }
}
