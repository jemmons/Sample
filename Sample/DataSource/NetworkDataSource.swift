import UIKit
import BagOfTricks



enum Result<T> {
  case success(T)
  case failure(Error)
}



struct Section<T> {
  var title: String?
  var rows: [T]
}



protocol Fetcher: class {
  associatedtype ValueObject
  func fetch(completion: (Result<Section<ValueObject>>)->Void)
}




class NetworkDataSource<CellType: ResponsibleCell, ValueSourceType: ValueSource, FetcherType: Fetcher>: NSObject, UITableViewDataSource where CellType.ValueObject == ValueSourceType.ValueObject, FetcherType.ValueObject == CellType.ValueObject {
  let dataSource = ResponsibleDataSource<CellType, ValueSourceType>()

  
//  init(fetcher: FetcherType) {
//    fetcher.fetch { [weak self] res in
//      switch res {
//      case let .success(sections):
//        self?.dataSource.values. = sections.first? ?? []
//      case .error:
//        self?.dataSource.state = .error
//      }
//    }
//  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSource.numberOfSections(in: tableView)
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.tableView(tableView, numberOfRowsInSection: section)
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return dataSource.tableView(tableView, cellForRowAt: indexPath)
  }
}
