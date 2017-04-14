import UIKit
import Gauntlet
import Medea



public struct NetworkDataSourceDelegate {
  var whenEmpty: ()->Void = {}
  var whenLoaded: ()->Void = {}
  var whenLoading: ()->Void = {}
  var withError: (NSError)->Void = { _ in }
}


public class NetworkDataSource<T: ExpressibleByJSON>: NSObject, UITableViewDataSource {
  fileprivate let arrayDataSource: ArrayDataSource<T>
  public var delegate = NetworkDataSourceDelegate()
  
  public init(cellIdentifier: CellIdentifier) {
    arrayDataSource = ArrayDataSource(cellIdentifier: cellIdentifier)
    super.init()
    
    arrayDataSource.delegate.whenLoaded = { [unowned self] in
      self.delegate.whenLoaded()
    }
    
    arrayDataSource.delegate.whenEmpty = { [unowned self] in
      self.delegate.whenEmpty()
    }
  }
  
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return arrayDataSource.numberOfSections(in: tableView)
  }
  
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayDataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return arrayDataSource.tableView(tableView, cellForRowAt: indexPath)
  }
}



public extension NetworkDataSource {
  func load() {
    delegate.whenLoading()
    API.library.jsonArrayTask(for: .index) { res in
      switch res {
      case .response(status: 200..<300, jsonArray: let json):
        self.arrayDataSource.source = json.map { T.init(json: $0 as! JSONObject) }
      case .response(status: let status, jsonArray: _):
        self.delegate.withError(NSError(domain: "HTTP Error" , code: status, userInfo: nil))
      case .failure(let error):
        self.delegate.withError(error as NSError)
      }
    }
  }
}

