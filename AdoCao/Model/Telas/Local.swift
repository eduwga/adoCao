//
//  Local.swift
//  AdoCao
//
//  Created by André N. dos Santos on 07/07/22.
//

import Foundation
import MapKit

class Local: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
