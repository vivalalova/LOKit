//
//  File.swift
//
//
//  Created by Lova on 2021/4/10.
//

import MapKit

extension MKMapView {
    var mapAnnotations: [Annotation] {
        self.annotations.compactMap { $0 as? Annotation }
    }
}
