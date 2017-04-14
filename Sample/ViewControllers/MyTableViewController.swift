import UIKit
import BagOfTricks



public class MyTableViewController: UITableViewController {
  var dataSource: ArrayDataSource<String>!
  
  public override func viewDidLoad() {
    dataSource = ArrayDataSource(cellIdentifier: MyCell.register(with: tableView))
    tableView.dataSource = dataSource
    
  }
}
