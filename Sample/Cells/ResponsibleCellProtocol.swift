import UIKit



public protocol ResponsibleCell {
  associatedtype ValueObject
  static var identifier: String {get}
  static func register(with table: UITableView)
  func fill(with value: ValueObject)
}
