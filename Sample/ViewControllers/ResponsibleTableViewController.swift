import UIKit
import Gauntlet


enum Result<T> {
  case success(T)
  case failure(Error)
  
  func flatMap<U>(f: (T)->Result<U>) -> Result<U> {
    switch self {
    case let .success(s):
      return f(s)
    case let .failure(e):
      return .failure(e)
    }
  }
}



struct Section<T> {
  var title: String?
  var rows: [T]
}



protocol Fetchable {
  associatedtype ValueObject
  func fetch(completion: (Result<Section<ValueObject>>)->Void)
}


class NetworkValueSource<T, Fetcher: Fetchable>: NSObject, ValueSource where Fetcher.ValueObject == T {
  private var sections: [Section<T>] {
    didSet {
      delegate.changedValues()
    }
  }
  
  
  public var delegate: ValueSourceDelegate

  
  public var isEmpty: Bool {
    return sections.isEmpty
  }
  
  
  public var numberOfSections: Int {
    return sections.count
  }
  
  
  public func numberOfRows(in section: SectionIndex) -> Int {
    return sections[section.index].rows.count
  }
  
  
  public func value(at indexPath: IndexPath) -> T {
    return sections[indexPath.section].rows[indexPath.row]
  }
  
  
  public override required init() {
    sections = []
    delegate = ValueSourceDelegate()
    super.init()
  }
}



class ResponsibleTableViewController<Cell: ResponsibleCell, Value: ValueSource>: StatefulTableViewController where Cell.ValueObject == Value.ValueObject {
  let api = "library API"
  let cell = "Library cell"
  let model = "library model"
  
  func load() {
    machine.queue(.loading)
  }
  
  
  func refresh() {
    machine.queue(.refreshing)
  }
  
  
  let dataSource = ResponsibleDataSource<Cell, Value>()
  let machine = StateMachine<TableState>(initialState: .ready)
  
  
  init() {
    machine.delegates.didTransition = { [weak self] from, to in
      switch to {
      case .loading:
        //fetch stuff
        self?.state = .loading
      case .empty:
        self?.state = .empty
      case .loaded:
        self?.dataSource.values.append(["thing": "stuff"])
        tableView.reloadData()
      case .error:
        self?.state = .error
      }
    }
  }
  
  
}
