import UIKit
import BagOfTricks



public class MyCell: UITableViewCell, ResponsibleJSONCell {
  static public func register(with table: UITableView) -> CellIdentifier {
    return given(CellIdentifier(id: "MyCell")) {
      table.register(self, forCellReuseIdentifier: $0.id)
    }
  }
  
  
  public func fill(with json: JSONObject) {
    textLabel?.text = json["name_"] as? String
  }
}
