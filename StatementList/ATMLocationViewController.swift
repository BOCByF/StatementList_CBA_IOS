//
//  ATMLocationViewController.swift
//  StatementList
//
//  Created by Shelton Han on 22/12/16.
//  Copyright © 2016 Shelton Han. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct AnnotationIdentifier {
    static let atm = "CBAFindUsAnnotationIconATM"
}

class ATMAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String = "CBA ATM") {
        self.coordinate = coordinate
        self.title = title
    }

}

class ATMLocationViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    public var atmAnnotations: [MKAnnotation]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let atms = self.atmAnnotations {
            self.mapView?.showAnnotations(atms, animated: false)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationIdentifier.atm) else {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier.atm)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.image = UIImage(named: "CBAFindUsAnnotationIconATM")
            return annotationView
        }
        return annotationView
    }
    
}
