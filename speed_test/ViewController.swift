//
//  ViewController.swift
//  speed_test
//
//  Created by Liam Connery on 8/25/19.
//  Copyright © 2019 Liam Connery. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    let speed_display: UITextView = {
       
        let text_view = UITextView()
        
        text_view.text = "0 mph"
        text_view.textAlignment = .center
        text_view.font = UIFont(name: "HelveticaNeue-Thin", size: 50)
        
        text_view.translatesAutoresizingMaskIntoConstraints = false
        
        return text_view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        format_view()

        setup_lm()
        
        self.locationManager.startUpdatingLocation()
        
    
        // add sub views here
        self.view.addSubview(speed_display)
        
        format_subviews()
    }
    
    func setup_lm() {
       
        locationManager.delegate = self
        if NSString(string: UIDevice.current.systemVersion).doubleValue > 8 {
            
            locationManager.requestAlwaysAuthorization()
        }

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        guard let speed = manager.location?.speed else { return }
       // speed_display.text = speed < 0 ? "No movement registered" : "\(speed) mph?"
        
        var mph: Int = Int(round(speed * 2.237))
        
        if (mph < 0) {
            
            mph = 0
        }
        
        speed_display.text = "\(mph) mph"
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var speed: CLLocationSpeed = CLLocationSpeed()
        speed = locationManager.location!.speed
       
    }
    
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status != CLAuthorizationStatus.denied{
            locationManager.startUpdatingLocation()
        }
    }
    
    func format_subviews() {
        
        // speed display
        speed_display.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        
        speed_display.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        speed_display.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        speed_display.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        speed_display.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        
    }
    
    func format_view() {
        
        self.view.backgroundColor = .white
    }


}

