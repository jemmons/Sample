import UIKit
import BagOfTricks


public class StatefulTableViewController: EmbeddedTabViewController {
  public enum State: Int {
    case loading = 0, table, empty, error
  }
  
  
  public var state: State {
    get {
      guard
        let _index = tabController.selectedIndex,
        let state = State(rawValue: _index) else {
          fatalError("Selected index out of range of table tabs.")
      }
      return state
    }
    set {
      let newIndex = newValue.rawValue
      assert(newIndex >= 0 && newIndex < tabController.numberOfTabs)
      tabController.selectedIndex = newValue.rawValue
    }
  }
  
  
  public var tableView: UITableView! {
    get{
      return tableController!.tableView
    }
  }
  
  
  weak var tabController: EmbeddedTabViewController!
  weak var tableController: UITableViewController!
  weak var refreshControl: UIRefreshControl!
}



public extension StatefulTableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabController = Helper.embedTabController(in: self)
    tableController = Helper.addTableControllerTabs(to: tabController)
    tableController.refreshControl = makeRefreshControl()
    
  }
}



internal extension StatefulTableViewController {
  @IBAction func changedRefresh(sender: UIRefreshControl) {
    print(sender.isRefreshing)
    sender.endRefreshing()
  }
}



private extension StatefulTableViewController {
  func makeRefreshControl() -> UIRefreshControl {
    return given(UIRefreshControl()) {
      $0.addTarget(self, action: #selector(changedRefresh(sender:)), for: .valueChanged)
    }
  }
}


private enum Helper {
  static func embedTabController(in controller: UIViewController) -> EmbeddedTabViewController {
    return given(EmbeddedTabViewController()) {
      $0.embed(in: controller, constrainedBy: [
        $0.view.topAnchor.constraint(equalTo: controller.topLayoutGuide.bottomAnchor),
        $0.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
        $0.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
        $0.view.bottomAnchor.constraint(equalTo: controller.bottomLayoutGuide.bottomAnchor),
        ])
    }
  }
  
  
  static func addTableControllerTabs(to tabController: EmbeddedTabViewController) -> UITableViewController {
    return given(UITableViewController(style: .plain)) {
      tabController.viewControllers = [
        UIViewController(nibName: "LoadingTableView", bundle: nil),
        $0,
        UIViewController(nibName: "EmptyTableView", bundle: nil),
        UIViewController(nibName: "ErrorTableView", bundle: nil),
      ]
    }
  }
}
