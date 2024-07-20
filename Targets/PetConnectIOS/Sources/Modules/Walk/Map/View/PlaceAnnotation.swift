//
//  PlaceAnnotation.swift
//  PetConnect
//
//  Created by SHREDDING on 21.09.2023.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var identifier: UUID
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, image: UIImage?, identifier: UUID) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.identifier = identifier
    }
}
