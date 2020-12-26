//
//  MapViewController.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 24/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var user: User!
    private let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Where is Bryan?"
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back-arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back-arrow")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        let annotation = UserAnnotation(user: user)
        mapView.addAnnotation(annotation)

        let initialLocation = CLLocation(latitude: annotation.latitude, longitude: annotation.longitude)
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

class UserAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var latitude = 0.0
    var longitude = 0.0
    
    init(user: User) {
        
        title = "\(user.name?.title ?? "") \(user.name?.first ?? "") \(user.name?.last ?? "")"
        if let lat = user.location?.coordinates.latitude {
            latitude = NSString(string: "50.300613399999996").doubleValue
        }
        
        if let long = user.location?.coordinates.longitude {
            longitude = NSString(string: "2.8388918999999997").doubleValue
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        super.init()
    }
}
