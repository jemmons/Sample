import Foundation
import Gauntlet
import Medea



enum NetworkState<SuccessType>: StateType {
  case ready, fetching, success(SuccessType), failure(NSError)
  
  func shouldTransition(to: NetworkState) -> Bool {
    switch (self, to) {
    case (.ready, .fetching),
         (.fetching, .success),
         (.fetching, .failure):
      return true
      
    default:
      return false
    }
  }
}



typealias JSONArrayNetworkState = NetworkState<[JSONObject]>
