//
//  ViewController.swift
//  GMSpinner
//
//  Created by Anson Yao on 2017-01-04.
//  Copyright © 2017 TTT. All rights reserved.
//

import UIKit
import SpringSpinnerView

class ViewController: UIViewController {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var containerView2: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let spinnerView = SpringSpinnerView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
    containerView.addSubview(spinnerView)
  }
  
}

