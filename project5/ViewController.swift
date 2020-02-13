//
//  ViewController.swift
//  project5
//
//  Created by Yueyang Zhang on 2/6/20.
//  Copyright © 2020 Yueyang Zhang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var viewDescription: UILabel!
    @IBOutlet weak var mapView: MKMapView!{
        didSet { mapView.delegate = self }
    }
    
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var placeText: UILabel!
    @IBOutlet weak var bottomFavButton: UIButton!
    
    var currPlace = Place()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        //        
        // Do any additional setup after loading the view.
        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        // load data
        let dataManager = DataManager.sharedInstance
        dataManager.loadAnnotationFromPlist()
        for place in DataManager.sharedInstance.placeArr{
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.coordinate = place.coordinate
            annotation.subtitle = place.longDescription
            mapView.addAnnotation(annotation)
        }
        
        
        
        let coord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(41.881832), Double(-87.623177))
        let region = MKCoordinateRegion(center:coord, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
        
        
        favButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        //bottomFavButton.addTarget(self, action: #selector(buttonTapped2), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DataSegue" {
            let secondVC: FavoritesTableViewController = segue.destination as! FavoritesTableViewController
            secondVC.delegate = self
        }
    }
    
    @objc func buttonTapped(_ button: UIButton){
        if button.isSelected {
            // set deselected
            button.isSelected = false
            DataManager.sharedInstance.deleteFavorite(place: currPlace)
            print(DataManager.sharedInstance.favArr)
        } else {
            // set selected
            button.isSelected = true
            DataManager.sharedInstance.saveFavorites(place: currPlace)
            print(DataManager.sharedInstance.favArr)
        }
    }
    

}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        var isFav = false
        for place in DataManager.sharedInstance.favArr{
            if view.annotation?.title == place.name{
                isFav = true
            }
        }
        if isFav{
            favButton.isSelected = true
        } else{
            favButton.isSelected = false
        }
        
        
        placeTitle.text = view.annotation?.title!
        placeText.text = view.annotation?.subtitle!
        currPlace = Place()
        currPlace.name = view.annotation?.title!
        if let coor = view.annotation?.coordinate{
            currPlace.coordinate = coor
        }
        currPlace.longDescription = view.annotation?.subtitle!
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKPointAnnotation {
            let identifier = "CustomPin"
            // Create a new view
            var view: MKMarkerAnnotationView

            // Deque an annotation view or create a new one
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                view.markerTintColor = .blue
                view.glyphText = "❤︎"
            }
            return view
        }
        return nil
    }
}

extension ViewController: PlacesFavoritesDelegate {
  func favoritePlace(name: String) {
   // Update the map view based on the favorite
   // place that was passed in
    let placeName = name
    for place in DataManager.sharedInstance.favArr{
        if place.name == placeName{
            let coor = place.coordinate
            let region = MKCoordinateRegion(center:coor, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: false)
            favButton.isSelected = true
            break
        }
    }
   
  }
}


