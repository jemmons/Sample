//
//  ViewController.swift
//  Sample
//
//  Created by Joshua Emmons on 4/13/17.
//  Copyright © 2017 MCMXCIX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  weak var tableController: StatusTableViewController!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    tableController = segue.destination as! StatusTableViewController
  }
}

