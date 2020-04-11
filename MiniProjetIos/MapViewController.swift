//
//  MapViewController.swift
//  MiniProjetIos
//
//  Created by malek belayeb on 1/12/20.
//  Copyright © 2020 Akthem-Malek. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MapboxGeocoder

class MapViewController: UIViewController {
    var lat : Double = 0
    var log : Double = 0

    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
          // Process Response
          self.processResponse(withPlacemarks: placemarks, error: error)
        
        
        
        print(self.lat)
        let initialLocation = CLLocation(latitude: self.lat, longitude: self.log)
        self.centerMapOnLocation(location: initialLocation)
}
        
        
    }
    

    let regionRadius: CLLocationDistance = 1000
       func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
         mapview.setRegion(coordinateRegion, animated: true)
       }
      
       
       
       

      var address = "tunisia,tunis,marsa"
       lazy var geocoder = CLGeocoder()

      // Geocode Address String
      
       public func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
           // Update View
           
           if let error = error {
               print("Unable to Forward Geocode Address (\(error))")

           } else {
               var location: CLLocation?

               if let placemarks = placemarks, placemarks.count > 0 {
                   location = placemarks.first?.location
               }

               if let location = location {
                   let coordinate = location.coordinate
                  print( "\(coordinate.latitude), \(coordinate.longitude)")
                   self.lat = coordinate.latitude
                   self.log = coordinate.longitude
                   
               } else {
                   print( "No Matching Location Found" )
               }
           }
       }
       

}
