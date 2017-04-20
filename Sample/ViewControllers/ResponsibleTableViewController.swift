import UIKit
import Gauntlet



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
