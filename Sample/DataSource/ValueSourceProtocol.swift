import Foundation



public struct ValueSourceDelegate {
  var changedValues: ()->Void = {}
  var withError: (Error)->Void = { _ in }
}



public protocol ValueSource: class {
  associatedtype ValueObject
  var numberOfSections: Int {get}
  func numberOfRows(in section: SectionIndex) -> Int
  func value(at indexPath: IndexPath) -> ValueObject
  init()
}

