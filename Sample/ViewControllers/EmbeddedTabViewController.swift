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
    with(viewControllers[someIndex]) {
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
