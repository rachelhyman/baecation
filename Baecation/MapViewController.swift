//
//  MapViewController.swift
//  Baecation
//
//  Created by Rachel Hyman on 1/2/16.
//  Copyright © 2016 Rachel Hyman. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RealmSwift

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager: CLLocationManager = CLLocationManager()
    var lastLocation: CLLocation!
    var places:Results<Place>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        locationManager.delegate = self
        lastLocation = CLLocation(latitude:0, longitude:0)
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
        
        let realm = try! Realm()
        places = realm.objects(Place)
        
        if places?.count > 0 {
            self.addPins()
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName("dataLoaded", object: nil, queue: NSOperationQueue.mainQueue()) { [weak self] _ in
            self!.addPins()
        }
    }
    
    func addPins() {
        mapView.addAnnotations(Array(places![0..<places!.count]))
    }
    
    //MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last!.distanceFromLocation(lastLocation) > 50 {
            mapView.camera = MKMapCamera(lookingAtCenterCoordinate: locations.last!.coordinate, fromDistance: 3000, pitch: 0, heading: locations.last!.course)
            lastLocation = locations.last!
        }
    }
}
