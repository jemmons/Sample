import UIKit
import BagOfTricks



public class MyTableViewController: NetworkTableViewController {
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    cellType = MyCell.self
    load()
  }
}
