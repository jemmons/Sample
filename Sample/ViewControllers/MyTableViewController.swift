import UIKit
import BagOfTricks
import Gauntlet



public enum StateThing<T>: StateType {
    case ready, fetching, success(T), failure(Error)
    
    public func shouldTransition(to: StateThing) -> Bool {
        switch (self, to) {
        case (.ready, .fetching),
             (.fetching, .success), (.fetching, .failure),
             (.success, .ready), (.failure, .ready):
            return true
        default:
            return false
        }
    }
}




public struct FetcherDelegate<T> {
    var changedState: (StateThing<T>)->Void = { _ in }
}



public class Fetcher<T> {
    private let machine = StateMachine<StateThing<T>>(initialState: .ready)
    private let fetchFactory: ((Result<T>)->Void)->Void
    public var delegate = FetcherDelegate<T>()
    
    
    init(factory: @escaping ((Result<T>)->Void)->Void) {
        fetchFactory = factory
        machine.delegates.didTransition = { [weak self] _, to in
            defer {
                self?.delegate.changedState(to)
            }
            
            switch to {
            case .ready:
                break
                
            case .fetching:
                self?.fetchFactory { (res: Result<T>) in
                    switch res {
                    case let .success(t):
                        self?.machine.queue(.success(t))
                    case let .failure(e):
                        self?.machine.queue(.failure(e))
                    }
                }
                
            case .success, .failure:
                self?.machine.queue(.ready)
            }
        }
    }
    
    
    func fetch() {
        machine.queue(.fetching)
    }
}



public class MyTableViewController: UIViewController {
    private let dataSource = ResponsibleDataSource<MyCell, ArrayValueSource<JSONObject>>()
    private lazy var fetcher: Fetcher = {
        Fetcher() { (completion: @escaping ((Result<[JSONObject]>) -> Void)) in
            API.library.jsonArrayTask(for: .index) { res in
                completion(res.flatMap { jsonArray in jsonArray.map { ($0 as? JSONObject) ?? [:] } })
            }
        }
    }()
    private weak var tableViewController: StatefulTableViewController!
    
    
    
    @IBAction func foo(sender: Any) {
        dataSource.values.append(["name_": "Foo"], in: 0)
        tableViewController.tableView.reloadData()
    }

    
    public override func viewDidLoad() {
        super.viewDidLoad()

        tableViewController = given(StatefulTableViewController()) {
            embedAndMaximize($0)
        }
        
//        dataSource.delegate.changedState = { [unowned self] dataState in
//            let tableState: StatefulTableViewController.State
//            switch dataState {
//            case .empty:
//                tableState = .empty
//            case .loaded:
//                tableState = .table
//            case .error:
//                tableState = .error
//            case .loading:
//                tableState = .busy
//            }
//            self.tableViewController.state = tableState
//        }
        
        tableViewController.tableView.dataSource = dataSource
        
        dataSource.values.append(["name_": "World"], in: 0)
    }
}
