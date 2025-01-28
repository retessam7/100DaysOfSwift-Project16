//
//  ViewController.swift
//  Project16
//
//  Created by VII on 28.01.2025.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.", wikiURL: "https://en.wikipedia.org/wiki/London")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.", wikiURL: "https://en.wikipedia.org/wiki/Oslo")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.", wikiURL: "https://en.wikipedia.org/wiki/Paris")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.", wikiURL: "https://en.wikipedia.org/wiki/Rome")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.", wikiURL: "https://en.wikipedia.org/wiki/Washington,_D.C.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "map type", style: .plain, target: self, action: #selector(changeMapType))
    }
    
    // viewFor will be called for your annotations, but also Apple's. This is what contains the viewFor method that lets us control how annotation views look.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If isn't from a capital city, it must return nil so iOS uses a default view.
        guard annotation is Capital else { return nil }
        
        // Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
        let identifier = "Capital"
        
        // Try to dequeue an annotation view from the map view's pool of unused views.
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        // If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            // Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // If it can reuse a view, update that view to use a different annotation
            annotationView?.annotation = annotation
        }
        
        annotationView?.pinTintColor = UIColor.black
        
        return annotationView
    }
    
    // don't need to use addTarget() to add an action to the button, because you'll automatically be told by the map view using a calloutAccessoryControlTapped method
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Annotation view contains a property called annotation, which will contain our Capital object, we can pull that out, typecast it as a Capital
        guard let capital = view.annotation as? Capital else {return}
//        let placeName = capital.title
//        let placeInfo = capital.info
        
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        
        let placeWiki = URL(string: capital.wikiURL)
        
        let webViewController = WebViewController()
        webViewController.url = placeWiki
        navigationController?.pushViewController(webViewController, animated: true)
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Map Type", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .standard
        }))
        
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .satellite
        }))
        
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: { [weak self] _ in
            self?.mapView.mapType = .hybrid
        }))
        
        present(ac, animated: true)
    }
}

