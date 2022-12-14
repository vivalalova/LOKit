//
//  File.swift
//
//
//  Created by Lova on 2021/4/10.
//

import MapKit

open class Annotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    public var subtitle: String?

    public init(title: String? = nil, subtitle: String? = nil, lat: Double, lng: Double) {
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        self.title = title
        self.subtitle = subtitle
    }

    public init(title: String? = nil, subtitle: String? = nil, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

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
