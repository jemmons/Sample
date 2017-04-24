import UIKit
import Gauntlet


public enum Result<T> {
  case success(T)
  case failure(Error)
  
  public func flatMap<U>(f: (T)->Result<U>) -> Result<U> {
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



class ResponsibleTableViewController<Cell: ResponsibleCell, Value: ValueSource>: StatefulTableViewController where Cell.ValueObject == Value.ValueObject {
  let api = "library API"
  let cell = "Library cell"
  let model = "library model"
  
}
