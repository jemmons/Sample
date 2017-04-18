import UIKit
import BagOfTricks



public class MyTableViewController: StatefulTableViewController {
  private let dataSource = ResponsibleDataSource<MyCell, ArrayValueSource<JSONObject>>()
  
  @IBAction func foo(sender: Any) {
    dataSource.append(["name_": "Foo"], in: 0)
    tableView.reloadData()
  }
  
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource.delegate.whenLoaded = { [unowned self] in
      self.state = .table
    }
    dataSource.delegate.whenEmpty = { [unowned self] in
      self.state = .empty
    }
    
    MyCell.register(with: tableView)
    tableView.dataSource = dataSource
    
    dataSource.append(["name_": "Hello"], in: 0)
    

  }
}
