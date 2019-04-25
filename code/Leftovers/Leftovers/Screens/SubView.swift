//
//  SubView.swift
//  Leftovers
//
//  Created by Matthew Izzo on 4/4/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//
//View that can be called and subclassed in the rest of the views

import UIKit

@IBDesignable class SubView: UIView {
    
    //Override initializer when frame loaded
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    //Initializer called by story board
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    //Additonal setup
    func configure() {
        
    }
}
