import UIKit
import BagOfTricks



public class MyCell: UITableViewCell, ResponsibleCell {
    private static let identifier: CellIdentifier = "MyCell"

    
    public static func register(with table: UITableView) -> CellIdentifier {
        return given(MyCell.identifier) {
            table.register(self, forCellReuseIdentifier: $0)
        }
    }
    
    
    public func fill(with json: JSONObject) {
        textLabel?.text = json["name_"] as? String
    }
}
