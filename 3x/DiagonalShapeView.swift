//
//  DiagonalShapeView.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit
class DiagonalShapeView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        
        let hRight = size.height * 0.95
        let hLeft = size.height * 0.85
        
        // calculate the 4 points of the shape
        let p1 = self.bounds.origin
        let p2 = CGPoint(x:p1.x + size.width, y:p1.y)
        let p3 = CGPoint(x:p2.x, y:p2.y + hRight)
        let p4 = CGPoint(x:p1.x, y:p1.y + hLeft)

        // create the path
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()

        // fill the path
        UIColor(red: 30.0/255.0, green: 43.0/255.0, blue: 95.0/255.0, alpha: 1).set()
        path.fill()
    }
}
