import Foundation



public struct SectionIndex: ExpressibleByIntegerLiteral {
  var index: Int
  
  
  public init(integerLiteral value: Int) {
    index = value
  }
  
  
  public init(_ index: Int) {
    self.init(integerLiteral: index)
  }
}
