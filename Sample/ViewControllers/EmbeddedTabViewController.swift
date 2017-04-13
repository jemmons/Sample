import UIKit
import BagOfTricks


public class EmbeddedTabViewController: UIViewController {
  public var viewControllers: [UIViewController] = [] {
    didSet {
      guard 
      selectedIndex = 0
    }
  }
  
  
  public var selectedIndex: Int = -1 {
    willSet {
      removeControllers()
    }
    didSet {
      addSelectedController()
    }
  }
  
  
  fileprivate var selectedConstraints: [NSLayoutConstraint] = []
  
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}



private extension EmbeddedTabViewController {
  var selectedController: UIViewController {
    return viewControllers[selectedIndex]
  }
  
  
  func removeControllers() {
    childViewControllers.forEach {
      $0.willMove(toParentViewController: nil)
      NSLayoutConstraint.deactivate(selectedConstraints)
      selectedConstraints = []
      $0.view.removeFromSuperview()
      $0.removeFromParentViewController()
    }
  }
  
  
  func addSelectedController() {
    with(viewControllers[selectedIndex]) {
      addChildViewController($0)
      view.addSubview($0.view)
      $0.view.translatesAutoresizingMaskIntoConstraints = false
      selectedConstraints = makeConstraints(for: $0)
      NSLayoutConstraint.activate(selectedConstraints)
      $0.didMove(toParentViewController: self)
    }
  }
  
  
  func makeConstraints(for controller: UIViewController) -> [NSLayoutConstraint] {
    return [
      controller.view.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
      controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      controller.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
    ]
  }
}
