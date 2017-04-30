import Foundation
import Gauntlet



public enum NetworkSourceState<T>: StateType {
  case ready, fetching, success([T]), failure(Error), reloading
  
  public func shouldTransition(to: NetworkSourceState) -> Bool {
    switch (self, to) {
    case (.ready, .fetching),
         (.fetching, .success), (.fetching, .failure),
         (.success, .reloading), (.failure, .reloading),
         (.reloading, .success), (.reloading, .failure):
      return true
    default:
      return false
    }
  }
}

