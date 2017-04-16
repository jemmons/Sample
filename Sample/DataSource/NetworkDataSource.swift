import UIKit
import Gauntlet



public struct NetworkDataSourceDelegate {
  var whenEmpty: ()->Void = {}
  var whenLoaded: ()->Void = {}
  var whenLoading: ()->Void = {}
  var withError: (NSError)->Void = { _ in }
}


public class NetworkDataSource: NSObject, UITableViewDataSource {
  fileprivate let jsonDataSource: JSONDataSource
  public var delegate = NetworkDataSourceDelegate()
  
  public init?(cellIdentifier: CellIdentifier?) {
    guard let id = cellIdentifier else {
      return nil
    }
    jsonDataSource = JSONDataSource(cellIdentifier: id)
    super.init()
    
    jsonDataSource.delegate.whenLoaded = { [unowned self] in
      self.delegate.whenLoaded()
    }
    
    jsonDataSource.delegate.whenEmpty = { [unowned self] in
      self.delegate.whenEmpty()
    }
  }
  
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return jsonDataSource.numberOfSections(in: tableView)
  }
  
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return jsonDataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return jsonDataSource.tableView(tableView, cellForRowAt: indexPath)
  }
}



public extension NetworkDataSource {
  func load() {
    delegate.whenLoading()
    API.library.jsonArrayTask(for: .index) { res in
      switch res {
      case .response(status: 200..<300, jsonArray: let jsonArray):
        guard let json = jsonArray as? [JSONObject] else {
          self.delegate.withError(NSError(domain: "HTTP Error" , code: 500, userInfo: nil))
          return
        }
        self.jsonDataSource.source = json
        
      case .response(status: let status, jsonArray: _):
        self.delegate.withError(NSError(domain: "HTTP Error" , code: status, userInfo: nil))
      
      case .failure(let error):
        self.delegate.withError(error as NSError)
      }
    }
  }
}

