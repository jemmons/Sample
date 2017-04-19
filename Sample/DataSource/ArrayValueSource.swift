import UIKit



public class ArrayValueSource<T>: NSObject, ValueSource {
  private var store: [T] {
    didSet {
      delegate.changedValues()
    }
  }
  
  
  public var delegate: ValueSourceDelegate
  
  
  public var isEmpty: Bool {
    return store.isEmpty
  }

  
  public var numberOfSections: Int {
    return 1
  }
  
  
  public func numberOfRows(in section: SectionIndex) -> Int {
    return store.count
  }
  
  
  public func value(at indexPath: IndexPath) -> T {
    assert(indexPath.section == 0)
    return store[indexPath.row]
  }
  

  public func append(_ value: T, in section: SectionIndex = SectionIndex(0)) {
    assert(section.index == 0)
    store.append(value)
  }

  
  public override required init() {
    store = []
    delegate = ValueSourceDelegate()
    super.init()
  }
}
