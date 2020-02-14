//
//  PlaceMarkerView.swift
//  project5
//
//  Created by Yueyang Zhang on 2/6/20.
//  Copyright © 2020 Yueyang Zhang. All rights reserved.
//

import UIKit
import MapKit

class PlaceMarkerView: MKMarkerAnnotationView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var annotation: MKAnnotation? {
        willSet {
          clusteringIdentifier = "Place"
          displayPriority = .defaultLow
          markerTintColor = .systemRed
          glyphImage = UIImage(systemName: "pin.fill")
          }
    }
}
