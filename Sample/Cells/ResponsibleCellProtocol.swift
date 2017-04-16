import UIKit



public protocol ResponsibleJSONCell {
  static func register(with table: UITableView) -> CellIdentifier
  func fill(with json: JSONObject)
}
