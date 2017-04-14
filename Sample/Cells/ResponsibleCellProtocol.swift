import UIKit



protocol ResponsibleCell {
  static func register(with table: UITableView) -> CellIdentifier
  func fill(with valueObject: Any)
}
