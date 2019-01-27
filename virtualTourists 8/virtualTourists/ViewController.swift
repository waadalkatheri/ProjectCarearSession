//
//  ViewController.swift
//  virtualTourists
//
//  Created by Najla Al qahtani on 1/20/19.
//  Copyright © 2019 Najla Al qahtani. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapV: MKMapView!
    
    var stack = CoreDataStack.shared
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapV.delegate = self
        self.loadPinData()
        
        let defaults = UserDefaults.standard
        defaults.synchronize()
        
        if let region = defaults.object(forKey: "MapViewRegion") as! [CLLocationDegrees]! {
            
            let center = CLLocationCoordinate2D(latitude: region[0], longitude: region[1])
            let span = MKCoordinateSpan(latitudeDelta: region[2], longitudeDelta: region[3])
            let region = MKCoordinateRegion(center: center, span: span)
            
            mapV.setRegion(region, animated: true)
            mapV.regionThatFits(region)
        }
        
        // Add long-press gesture to map to add pins
        // Requires a 1.5 second press without moving your finger
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.addAnnotation))
        recognizer.minimumPressDuration = 0.8
        recognizer.allowableMovement = 0.0
        mapV.addGestureRecognizer(recognizer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for annotation in mapV.annotations {
            mapV.deselectAnnotation(annotation, animated: false)
        }
    }
    
    func loadPinData() {
        
        let request = Pin.fetchRequest()
        
        do {
            let pins = try stack.viewContext.fetch(request)
            
            for pin in pins {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
                self.mapView.addAnnotation(annotation)
            }
        } catch {
            AlertMessage.display(con: self, error: "Loading pin data failed.")
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        let defaults = UserDefaults.standard
        let region: [CLLocationDegrees] = [self.mapV.region.center.latitude, self.mapV.region.center.longitude, self.mapV.region.span.latitudeDelta, self.mapV.region.span.longitudeDelta]
        defaults.set(region, forKey: "MapViewRegion")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView()
        pinView.animatesDrop = true
        
        return pinView
    }
    
    @objc func addAnnotation(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = mapV.convert(gestureRecognizer.location(in: mapV), toCoordinateFrom: mapV)
            self.mapV.addAnnotation(annotation)
            
            let pin = Pin(context: (stack.persistentContainer.viewContext))
            pin.latitude = annotation.coordinate.latitude
            pin.longitude = annotation.coordinate.longitude
            stack.saveContext()
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        var controller = photoViewController()
        controller = self.storyboard?.instantiateViewController(withIdentifier: "photoAlbumView") as! photoViewController
        
        controller.latitude = (view.annotation?.coordinate.latitude)! as Double
        controller.longitude = (view.annotation?.coordinate.longitude)! as Double
        let request = Pin.fetchRequest()
        
        do {
            let pins = try (stack.persistentContainer.viewContext).fetch(request)
            
            for pin in pins {
                
                if pin.latitude == controller.latitude && pin.longitude == controller.longitude {
                    
                    controller.pinData = pin
                    break
                }
            }
        } catch {
            AlertMessage.display(con: self, error: "Cannot fetch pin data: \(error), \(error._userInfo)")
        }
        
        self.present(controller, animated: true, completion: nil)
    }
}

