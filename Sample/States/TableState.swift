import Foundation
import Gauntlet



enum TableState: StateType {
  case ready, loading, empty, error, loaded, refreshing
  
  func shouldTransition(to: TableState) -> Bool {
    switch (self, to) {
    case (.ready, .loading),
         (.loading, .empty), (.loading, .error), (.loading, .loaded),
         (.empty, .refreshing), (.error, .refreshing), (.loaded, .refreshing),
         (.refreshing, .empty), (.refreshing, .error), (.refreshing, .loaded):
      return true
    default:
      return false
    }
  }
}
