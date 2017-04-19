import UIKit
import BagOfTricks



public struct DataSourceDelegate {
  var changedState: (DataSourceState)->Void = { _ in }
}



public enum DataSourceState {
  case loading, loaded, empty, error
}



public class ResponsibleDataSource<CellType: ResponsibleCell, ValueSourceType: ValueSource>: NSObject, UITableViewDataSource where CellType.ValueObject == ValueSourceType.ValueObject {
  public var delegate = DataSourceDelegate()
  public let values: ValueSourceType
  public private(set) var state: DataSourceState = .empty {
    didSet {
      delegate.changedState(state)
    }
  }
  
  
  public override init() {
    values = ValueSourceType()
    super.init()
    values.delegate.changedValues = { [weak self] in
      guard let isEmpty = self?.values.isEmpty else {
        return
      }
      self?.state = isEmpty ? .empty : .loaded
    }
  }
  
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return values.numberOfSections
  }
  
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return values.numberOfRows(in: SectionIndex(section))
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return given(tableView.dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath)) {
      if let cell = $0 as? CellType {
        let value = values.value(at: indexPath)
        cell.fill(with: value)
      }
    }
  }
}
