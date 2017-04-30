import UIKit
import BagOfTricks
import Gauntlet
import SessionArtist




public class MyTableViewController: UIViewController {
  private let section: SectionDataSource<MyCell>
  private var dataSource: CompositeDataSource
  private var networkSource: NetworkSource<JSONObject>
  private weak var tableViewController: StatefulTableViewController!
  
  
  public required init?(coder aDecoder: NSCoder) {
    section = SectionDataSource<MyCell>()
    dataSource = CompositeDataSource(section)
    networkSource = NetworkSource { handleResult in
      API.library.jsonArrayTask(for: .index) { res in
        let result: Result<[JSONObject]> = res.flatMap { code, jsonArray in
          guard 200..<300 ~= code else {
            return .failure(NetworkSourceError.failureCode(code))
          }
          guard let jsonObjects = jsonArray as? [JSONObject] else {
            return .failure(NetworkSourceError.unexpectedResponseFormat)
          }
          return .success(jsonObjects)
        }
        handleResult(result)
      }
    }
    super.init(coder: aDecoder)
  }
  
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    with(StatefulTableViewController()) {
      embedAndMaximize($0)
      $0.tableView.dataSource = dataSource
      tableViewController = $0
    }
    
    networkSource.delegate.changedState = { [unowned self] state in
      switch state {
      case .success(let jsonArray):
        self.section.values = jsonArray
        self.tableViewController.state = .table
      default:
        break
      }
    }
    
    networkSource.fetch()
  }
}
