//
//  BaseViewController.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpBackgroundPentagonView()
    }
    func setUpBackgroundPentagonView(){
        let backgroundView = DiagonalShapeView(frame:CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height - 80))
        self.view.addSubview(backgroundView)
        self.view.sendSubviewToBack(backgroundView)
    }
}
