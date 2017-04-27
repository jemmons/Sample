import UIKit
import BagOfTricks



public class MyCell: UITableViewCell, ResponsibleCell {
    public static func register(with table: UITableView) -> CellIdentifier {
        return given(CellIdentifier(instance: self)) {
            table.register(self, forCellReuseIdentifier: $0.identifier)
        }
    }
    
    
    public func fill(with json: JSONObject) {
        textLabel?.text = json["name_"] as? String
    }
}
