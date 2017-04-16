import UIKit



public class NetworkTableViewController: StatefulTableViewController {
  private var dataSource: NetworkDataSource? {
    didSet {
      linkTableAndDelegates()
    }
  }
  public var cellType: ResponsibleJSONCell.Type? {
    didSet {
      resetDataSource()
    }
  }
  
  
  private func resetDataSource() {
    let cellIdentifier = cellType?.register(with: tableView)
    dataSource = NetworkDataSource(cellIdentifier: cellIdentifier)
  }
  
  
  private func linkTableAndDelegates() {
    dataSource?.delegate.whenEmpty = { [unowned self] in
      self.state = .empty
    }
    dataSource?.delegate.whenLoaded = { [unowned self] in
      self.state = .loaded
    }
    dataSource?.delegate.whenLoading = { [unowned self] in
      self.state = .loading
    }
    dataSource?.delegate.withError = { [unowned self] error in
      self.state = .error
    }
    
    tableView.dataSource = dataSource
  }
  
  
  public func load() {
    dataSource?.load()
  }
  
  
  public func reload() {
    //...
  }
}
