//
//  ViewController.swift
//  Sample
//
//  Created by Joshua Emmons on 4/13/17.
//  Copyright © 2017 MCMXCIX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  weak var tabController: SegmentedTabViewController!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    tabController = segue.destination as! SegmentedTabViewController
    let vc1 = UIViewController(nibName: nil, bundle: nil)
    vc1.view.backgroundColor = UIColor.green
    vc1.title = "Green"
    let vc2 = UIViewController(nibName: nil, bundle: nil)
    vc2.view.backgroundColor = UIColor.blue
    vc2.title = "Blue"
    
    tabController.viewControllers = [vc1, vc2]
  }
}

