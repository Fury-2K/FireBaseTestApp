//
//  UILabel.swift
//  FireBaseTestApp
//
//  Created by Manas Aggarwal on 29/05/19.
//  Copyright © 2019 zopsmart. All rights reserved.
//

import Foundation
import UIKit

class MyLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        
        self.textAlignment = .left
        self.font = UIFont(name: "Halvetica", size: 17)
        self.textColor = UIColor.white
        
    }
    
}
