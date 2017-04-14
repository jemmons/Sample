import UIKit
import BagOfTricks



public class StatusTableViewController: EmbeddedTabViewController {
  fileprivate enum Status: Int {
    case loading = 0, loaded, empty, error
  }

  
  fileprivate var status: Status {
    get {
      guard
        let _index = tabController.selectedIndex,
        let status = Status(rawValue: _index) else {
          fatalError("Selected index out of range of table tabs.")
      }
      return status
    }
    set {
      tabController.selectedIndex = newValue.rawValue
    }
  }
  
  
  var dataSource: NetworkDataSource<Library>!

  
  weak var tabController: EmbeddedTabViewController!
  weak var tableController: UITableViewController!
}



public extension StatusTableViewController {
  override func viewDidLoad() {
    tabController = Helper.embedTabController(in: self)
    tableController = Helper.addTableControllerTabs(to: tabController)
    let cellIdentifier = MyCell.register(with: tableController.tableView)
    dataSource = NetworkDataSource<Library>(cellIdentifier: cellIdentifier)
    dataSource.delegate.whenEmpty = { [unowned self] in
      self.status = .empty
    }
    dataSource.delegate.whenLoaded = { [unowned self] in
      self.status = .loaded
    }
    dataSource.delegate.whenLoading = { [unowned self] in
      self.status = .loading
    }
    dataSource.delegate.withError = { [unowned self] error in
      self.status = .error
    }
    tableController.tableView.dataSource = dataSource
    
    dataSource.load()
  }
}



private extension StatusTableViewController {
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
