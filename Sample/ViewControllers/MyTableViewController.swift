import UIKit
import BagOfTricks



public class MyTableViewController: StatefulTableViewController {
  private let dataSource = ResponsibleDataSource<MyCell, ArrayValueSource<JSONObject>>()
  
  
  @IBAction func foo(sender: Any) {
    dataSource.values.append(["name_": "Foo"], in: 0)
    tableView.reloadData()
  }
  
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    dataSource.delegate.changedState = { [unowned self] state in
      switch state {
      case .empty:
        self.state = .empty
      case .loaded:
        self.state = .table
      }
    }

    MyCell.register(with: tableView)
    tableView.dataSource = dataSource
    
    dataSource.values.append(["name_": "World"], in: 0)
    

  }
}
