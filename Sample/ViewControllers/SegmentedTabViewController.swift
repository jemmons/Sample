import UIKit
import BagOfTricks



public class SegmentedTabViewController: UIViewController {
  weak var segmentedControl: UISegmentedControl!
  weak var tabController: EmbeddedTabViewController!
  
  
}



public extension SegmentedTabViewController {
  public override func viewDidLoad() {
    with(addBox()) {
      segmentedControl = addSegmentedControl(to: $0)
      tabController = embedTabController(below: $0)
    }
    
    
    segmentedControl.insertSegment(withTitle: "ffoooo", at: 0, animated: false)
  }
}



private extension SegmentedTabViewController {
  func addSegmentedControl(to box: UIView) -> UISegmentedControl {
    let pad: CGFloat = 16
    return given(UISegmentedControl(frame: CGRect.zero)) {
      $0.translatesAutoresizingMaskIntoConstraints = false
      box.addSubview($0)
      NSLayoutConstraint.activate([
        $0.leadingAnchor.constraint(equalTo: box.leadingAnchor, constant: pad),
        $0.trailingAnchor.constraint(equalTo: box.trailingAnchor, constant: -pad),
        $0.topAnchor.constraint(equalTo: box.topAnchor, constant: pad),
        $0.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -pad),
        ])
    }
  }
  
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
  
  
  func embedTabController(below box: UIView) -> EmbeddedTabViewController {
    return given(EmbeddedTabViewController()) {
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


