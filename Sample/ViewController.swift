//
//  ViewController.swift
//  Sample
//
//  Created by Joshua Emmons on 4/13/17.
//  Copyright © 2017 MCMXCIX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var segmentedControl: UISegmentedControl!
  weak var tabController: EmbeddedTabViewController!
  
  
  @IBAction func changedTab(sender: UISegmentedControl) {
    tabController.selectedIndex = sender.selectedSegmentIndex
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    tabController = segue.destination as! EmbeddedTabViewController
//    let vc1 = UIViewController(nibName: nil, bundle: nil)
//    let vc2 = UIViewController(nibName: nil, bundle: nil)
//    vc1.view.backgroundColor = UIColor.green
//    vc2.view.backgroundColor = UIColor.blue
//    
//    tabController.viewControllers = [vc1, vc2]
  }
}

