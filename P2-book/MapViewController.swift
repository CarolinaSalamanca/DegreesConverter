//
//  MapViewController.swift
//  P2-book
//
//  Created by Carolina Salamanca on 7/10/20.
//  Copyright © 2020 Carolina Salamanca. All rights reserved.
//

//import Foundation // we remove this framework
import UIKit  // we need access to UIViewController. so we need to import UIkit
import MapKit

class MapViewController: UIViewController{
    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("Map view controller loaded its view")
    }
    
    var mapView: MKMapView! // we declare this element like this, to force unwrap it (we just declared it, its initialized)
    
    override func loadView() {
        mapView = MKMapView() // here its initialized
        view = mapView // mapview isnt added as a subview but the view itself
        
        // Adding some attributes to the mapView with internationalization
        /*
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybridString, satelliteString])
         */

        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        // Attaching a target-action pair to the segmented control (A method to execute in response to an event in the element segmented control (Target))
        segmentedControl.addTarget(self, // The target
                                   action: #selector(mapTypeChanged(_:)), // the method to execute
                                   for: .valueChanged) // Event that triggers the method
        
        // These translated constraints will often conflict with explicit constraints in the layout and cause an unsatisfiable constraints
        // thats why we set it to false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        // Creating constraints, The method below is called
        //func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint
        //now we have three NSLayoutConstraint instances. Bc thats what the previous method returns
        
        /*
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8) // This is constrainted to the safe area. NSLayoutConstraint
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor) // NSLayoutConstraint
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor) // NSLayoutConstraint
         */
        
        // This constraints are better than the previous because they use its superview margins, and the layout will adapt to them no matter the devide size
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 8) // This is constrainted to the safe area.
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor) // This are constrained to its view margins
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor) // This are constrained to its view margins
        
        // Once the constraint attributes are declared we need to activate them
        // Setting the isActive property is preferable to calling addConstraint(_:) or removeConstraint(_:) yourself.
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    // The @objc annotation is needed to expose this method to the Objective-C runtime.
    // Without this annotation, the segmented control cannot see this action method.
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
}
