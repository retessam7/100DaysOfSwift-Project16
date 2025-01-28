//
//  Capital.swift
//  Project16
//
//  Created by VII on 28.01.2025.
//
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var wikiURL: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String, wikiURL: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.wikiURL = wikiURL
    }
}
