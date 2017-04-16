import UIKit
import BagOfTricks



public class StatefulTableViewController: EmbeddedTabViewController {
  public var tableView: UITableView! {
    get{
      return tableController!.tableView
    }
  }
  
  public enum State: Int {
    case loading = 0, loaded, empty, error
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
      tabController.selectedIndex = newValue.rawValue
    }
  }
  
  
  weak var tabController: EmbeddedTabViewController!
  weak var tableController: UITableViewController!
}



public extension StatefulTableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tabController = Helper.embedTabController(in: self)
    tableController = Helper.addTableControllerTabs(to: tabController)
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
