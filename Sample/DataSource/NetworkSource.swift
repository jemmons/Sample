import Foundation
import SessionArtist
import Gauntlet



public struct NetworkSourceDelegate<T> {
  var changedState: (NetworkSourceState<T>)->Void = { _ in }
}



public class NetworkSource<T> {
  fileprivate let machine: StateMachine<NetworkSourceState<T>>
  private let performFetch: (_ handleResult: @escaping HandleResult) -> Void
  public var delegate: NetworkSourceDelegate<T>
  public typealias HandleResult = (Result<[T]>)->Void
  
  
  public init(performFetch: @escaping (_ handleResult: @escaping HandleResult)->Void) {
    delegate = NetworkSourceDelegate()
    machine = StateMachine<NetworkSourceState<T>>(initialState: .ready)
    self.performFetch = performFetch
    
    machine.delegates.didTransition = { [weak self] _, newState in
      defer {
        self?.delegate.changedState(newState)
      }

      switch newState {
      case .fetching, .reloading:
        self?.performFetch() { res in
          switch res {
          case .success(let t):
            self?.machine.queue(.success(t))
          case .failure(let e):
            self?.machine.queue(.failure(e))
          }
        }
      case .ready, .success, .failure:
        break
      }
    }
  }
}



public extension NetworkSource {
  func fetch() {
    machine.queue(.fetching)
  }
  
  
  func reload() {
    machine.queue(.reloading)
  }
}
