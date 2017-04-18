import UIKit
import BagOfTricks



public class MyCell: UITableViewCell, ResponsibleCell {
  public static let identifier = "MyCell"


  public static func register(with table: UITableView) {
    table.register(self, forCellReuseIdentifier: identifier)
  }
  
  
  public func fill(with json: JSONObject) {
    textLabel?.text = json["name_"] as? String
  }
}
