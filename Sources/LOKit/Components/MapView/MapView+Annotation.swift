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

    func updateAnnotations(to newAnnotations: [Annotation]) {
        guard self.mapAnnotations != newAnnotations else {
            return
        }

        self.removeAnnotations(self.mapAnnotations - newAnnotations)
        self.addAnnotations(newAnnotations - self.mapAnnotations)
    }
}
