import UIKit



public protocol ResponsibleCell {
    associatedtype ValueObject
    static func register(with table: UITableView) -> CellIdentifier
    func fill(with value: ValueObject)
}
