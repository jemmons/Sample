import UIKit



public extension UIViewController {
    @discardableResult func embedAndMaximize(_ child: UIViewController) -> [NSLayoutConstraint] {
        addChildViewController(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = Helper.makeMaximizedConstraints(from: child, to: self)
        NSLayoutConstraint.activate(constraints)
        child.didMove(toParentViewController: self)
        return constraints
    }
}



private enum Helper {
    static func makeMaximizedConstraints(from child: UIViewController, to parent: UIViewController) -> [NSLayoutConstraint] {
        return [
            child.view.topAnchor.constraint(equalTo: parent.topLayoutGuide.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: parent.bottomLayoutGuide.topAnchor),
        ]
    }
}
