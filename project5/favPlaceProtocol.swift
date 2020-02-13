//
//  favPlaceProtocol.swift
//  project5
//
//  Created by Yueyang Zhang on 2/11/20.
//  Copyright © 2020 Yueyang Zhang. All rights reserved.
//

import Foundation


protocol PlacesFavoritesDelegate: class {
  func favoritePlace(name: String) -> Void
}
