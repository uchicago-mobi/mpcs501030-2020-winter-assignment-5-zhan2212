//
//  DataManager.swift
//  project5
//
//  Created by Yueyang Zhang on 2/9/20.
//  Copyright © 2020 Yueyang Zhang. All rights reserved.
//

import Foundation
import MapKit

struct PlaceData: Decodable {
    var places: [placeItem]
    var region: [Double]
}

struct placeItem: Decodable {
    var name: String
    var description: String
    var lat:Double
    var long:Double
    var type:Int
}

public class DataManager {
    var placeArr: [Place]
    var favArr: [Place]
    // MARK: - Singleton Stuff
    public static let sharedInstance = DataManager()
    //This prevents others from using the default '()' initializer
    fileprivate init() {
        self.placeArr = []
        self.favArr = []
    }

  // Your code (these are just example functions, implement what you need)
    func loadAnnotationFromPlist() {
        // extract information from plist
        if let path = Bundle.main.path(forResource: "Data", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let places = try?PropertyListDecoder().decode(PlaceData.self, from:xml){
            for place in places.places{
                let location = CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat), longitude: CLLocationDegrees(place.long))
                // create Place() to store information
                let place2 = Place()
                place2.longDescription = place.description
                place2.coordinate = location
                place2.name = place.name
                self.placeArr.append(place2)
            }
        }
    }
    
    func saveFavorites(place: Place) {
        self.favArr.append(place)
    }
    
    func deleteFavorite(place:Place) {
        var index = 0
        for place2 in self.favArr {
            if place2.name == place.name{
                self.favArr.remove(at: index)
            }
            index += 1
        }
    }
    
    func listFavorites() -> [Place]{
        return self.favArr
    }
}
