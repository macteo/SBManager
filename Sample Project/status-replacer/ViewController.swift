//
//  ViewController.swift
//  status-replacer
//
//  Created by Matteo Gavagnin on 04/12/14.
//  Copyright (c) 2014 MacTeo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var statusCenter : CGPoint?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    // return .LightContent
    return .LightContent
  }
}

