import UIKit
import BagOfTricks



public class MyCell: UITableViewCell, ResponsibleCell {
  static public func register(with table: UITableView) -> CellIdentifier {
    return given(CellIdentifier(id: "MyCell")) {
      table.register(self, forCellReuseIdentifier: $0.id)
    }
  }
  
  
  public func fill(with valueObject: Any) {
    if let value = valueObject as? Library {
      textLabel?.text = value.name
    }
  }
}
