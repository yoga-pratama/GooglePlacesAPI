//
//  ViewController.swift
//  GooglePlacesAPI
//
//  Created by Yoga Pratama on 28/11/18.
//  Copyright © 2018 YPA. All rights reserved.
//

import UIKit
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet var nameLbl : UILabel!
    @IBOutlet var addrlbl : UILabel!
    
    var locManager : CLLocationManager!
    var placeClient : GMSPlacesClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        placeClient = GMSPlacesClient.shared()
        locManager = CLLocationManager()
        locManager.requestAlwaysAuthorization()
        
        if  CLLocationManager.locationServicesEnabled(){
            locManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getCurrentLoc(_ sender: UIButton) {
        
        placeClient.currentPlace(callback:{ (placeLikelihoodList , error) -> Void in
            
            if  let error = error {
                print("error : \(error.localizedDescription)")
                return
            }
            
            if  let placeLikelihoodList = placeLikelihoodList {
               let place = placeLikelihoodList.likelihoods.first?.place
                if  let place = place {
                     print(place)
                     self.nameLbl.text = place.name
                     //self.addrlbl.text = place.formattedAddress?.components(separatedBy: ",").joined(separator: "\n")
                    
                    self.addrlbl.text = place.formattedAddress
                    self.nameLbl.sizeToFit()
                    self.addrlbl.sizeToFit()
                    
            
                }
            }else{
                self.nameLbl.text = "No Current place"
                self.addrlbl.text = ""
            }
            
        
        
        })
        
    }
    
}


extension  ViewController  : CLLocationManagerDelegate{
    
    
}

