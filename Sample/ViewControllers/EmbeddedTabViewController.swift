import UIKit
import BagOfTricks


public class EmbeddedTabViewController: UIViewController {
  public var viewControllers: [UIViewController] = [] {
    didSet {
      guard viewControllers.isNotEmpty else {
        selectedIndex = nil
        return
      }
      selectedIndex = 0
    }
  }
  
  
  public var selectedIndex: Int? {
    willSet {
      removeControllers()
    }
    didSet {
      addSelectedController()
    }
  }

  
  public var numberOfTabs: Int {
    return viewControllers.count
  }
  
  
  fileprivate var selectedConstraints: [NSLayoutConstraint] = []
}



public extension EmbeddedTabViewController {
  func embed(in parentController: UIViewController, constrainedBy constraints: [NSLayoutConstraint]) {
    parentController.addChildViewController(self)
    parentController.view.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate(constraints)
    didMove(toParentViewController: parentController)
  }
}



private extension EmbeddedTabViewController {
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
    guard let someIndex = selectedIndex else {
      return
    }
    selectedConstraints = embedAndMaximize(viewControllers[someIndex])
  }
  
  
}
