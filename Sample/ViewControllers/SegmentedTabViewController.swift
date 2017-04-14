import UIKit
import BagOfTricks



public class SegmentedTabViewController: UIViewController {
  let segmentedControl = UISegmentedControl(frame: CGRect.zero)
  let tabController = EmbeddedTabViewController()
  var viewControllers: [UIViewController] {
    get {
      return tabController.viewControllers
    }
    set {
      tabController.viewControllers = newValue
      Helper.updateSegments(segmentedControl, with: newValue)
      segmentedControl.selectedSegmentIndex = 0
    }
  }
}



public extension SegmentedTabViewController {
  public override func viewDidLoad() {
    with(addBox()) {
      Helper.addSegmentedControl(segmentedControl, to: $0)
      embedTabController(below: $0)
    }
    segmentedControl.addTarget(self, action: #selector(selectedIndexChanged(sender:)), for: .valueChanged)
  }
}


internal extension SegmentedTabViewController {
  func selectedIndexChanged(sender: UISegmentedControl) {
    tabController.selectedIndex = sender.selectedSegmentIndex
  }
}


private extension SegmentedTabViewController {
  func addBox() -> UIView {
    return given(UIView(frame: CGRect.zero)){
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
      NSLayoutConstraint.activate([
        $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        $0.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
        ])
    }
  }
  
  
  func embedTabController(below box: UIView) {
    with(tabController) {
      addChildViewController($0)
      view.addSubview($0.view)
      $0.view.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        $0.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        $0.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        $0.view.topAnchor.constraint(equalTo: box.bottomAnchor),
        $0.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
        ])
      $0.didMove(toParentViewController: self)
    }
  }
}



private enum Helper {
  static func addSegmentedControl(_ control: UISegmentedControl, to box: UIView){
    with(control) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      box.addSubview($0)
      NSLayoutConstraint.activate([
        $0.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: 16),
        $0.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -16),
        $0.topAnchor.constraint(equalTo: box.topAnchor, constant: 8),
        $0.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -8),
        ])
    }
  }

  
  static func updateSegments(_ segmentedControl: UISegmentedControl, with viewControllers: [UIViewController]) {
    viewControllers.map { $0.title }.reversed().forEach {
      segmentedControl.insertSegment(withTitle: $0, at: 0, animated: false)
    }
  }
}
