//
//  ItemDetailsView.swift
//  Leftovers
//
//  Created by Matthew Izzo on 4/5/19.
//  Copyright © 2019 Matthew Izzo. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class ItemDetailsView: SubView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var claimBtn: UIButton!
    @IBOutlet weak var mapKit: MKMapView!
    
    @IBAction func claimItem(_ sender: UIButton){
        
    }
}
