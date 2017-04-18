import Foundation


public protocol ValueSource {
  associatedtype ValueObject
  var isEmpty: Bool {get}
  var numberOfSections: Int {get}
  func numberOfRows(in section: SectionIndex) -> Int
  func value(at indexPath: IndexPath) -> ValueObject
  func append(_ value: ValueObject, in: SectionIndex)
  init()
}

