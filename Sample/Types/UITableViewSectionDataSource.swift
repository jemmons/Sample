import UIKit



public protocol UITableViewSectionDataSource {
    var title: String? {get}
    func numberOfRows(in tableView: UITableView) -> Int
    //We need the IndexPath here to pass to `dequeueReusableCell`. Otherwise we get the optional cell version.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
