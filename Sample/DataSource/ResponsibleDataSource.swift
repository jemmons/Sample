import UIKit
import BagOfTricks



public struct DataSourceDelegate {
  var whenEmpty: ()->Void = {}
  var whenLoaded: ()->Void = {}
}



public class ResponsibleDataSource<CellType: ResponsibleCell, ValueSourceType: ValueSource>: NSObject, UITableViewDataSource where CellType.ValueObject == ValueSourceType.ValueObject {
  public var delegate = DataSourceDelegate()
  fileprivate let values: ValueSourceType
  
  
  public override init() {
    values = ValueSourceType()
    super.init()
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
  
  
  public func append(_ value: ValueSourceType.ValueObject, in section: SectionIndex) {
    values.append(value, in: section)
    dispatchDelegates()
  }
}



private extension ResponsibleDataSource {
  func dispatchDelegates() {
    switch values.isEmpty {
    case true:
      delegate.whenEmpty()
    case false:
      delegate.whenLoaded()
    }
  }
}
