//
//  MapView.swift
//  IPCameras
//
//  Created by Lova on 2021/4/4.
//

import Combine
import MapKit
import SwiftUI

public struct MapView: UIViewRepresentable {
    @State var model = ViedModel()

    @Binding var mapType: MKMapType
    @Binding var coordinateRegion: MKCoordinateRegion?
    @Binding var userTrackingMode: MKUserTrackingMode
    @Binding var annotations: [MKAnnotation]

    var viewForAnnotation: (MKAnnotation) -> MKMarkerAnnotationView?

    @Binding var selectedAnnotation: MKAnnotation?

    public func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView(frame: .zero)

        map.delegate = context.coordinator

        self.setup(map)

        return map
    }

    public func updateUIView(_ uiView: MKMapView, context: Context) {
        self.setup(uiView)
    }

    public func makeCoordinator() -> Coordinator { Coordinator(self) }

    public init(mapType: Binding<MKMapType> = .constant(.standard),
                region: Binding<MKCoordinateRegion?> = .constant(nil),
                isZoomEnabled: Binding<Bool> = .constant(true),
                isScrollEnabled: Binding<Bool> = .constant(true),
                showsUserLocation: Binding<Bool> = .constant(true),
                userTrackingMode: Binding<MKUserTrackingMode> = .constant(.follow),
                annotations: Binding<[MKAnnotation]> = .constant([]),
                viewForAnnotation: @escaping (MKAnnotation) -> MKMarkerAnnotationView? = { _ in nil },
                selectedAnnotation: Binding<MKAnnotation?> = .constant(nil)) {
        //
        self._mapType = mapType
        self._coordinateRegion = region
        self._userTrackingMode = userTrackingMode
        self._annotations = annotations

        self.viewForAnnotation = viewForAnnotation

        self._selectedAnnotation = selectedAnnotation
    }
}

extension MapView {
    private func setup(_ mapView: MKMapView) {
        mapView.mapType = self.mapType

        if let region = self.coordinateRegion {
            mapView.region = region
        }

        mapView.userTrackingMode = self.userTrackingMode
        mapView.showsUserLocation = true
    }

//    private func updateAnno(mapView: MKMapView) {
//        mapView.annotations.filter { annotation in
//            self.annotations.contains(where: annotation)
//        }
//    }
}

struct MapView_Previews: PreviewProvider {
    class Anno: NSObject, MKAnnotation {
        var coordinate: CLLocationCoordinate2D

        init(lat: Double, lng: Double) {
            self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
    }

    @State static var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.015, longitude: 121.55),
                                                  latitudinalMeters: 1000, longitudinalMeters: 1000)

    @State static var trackingMode: MKUserTrackingMode = .follow

    static var annotationView: (MKAnnotation) -> MKAnnotationView? = { _ in
        nil
    }

    static var previews: some View {
        MapView(annotations: .constant([Anno(lat: 25.015, lng: 121.55)]))
    }
}

/* ---------------------------------------------------- */
extension MapView {
    class ViedModel: ObservableObject {}
}

/* ---------------------------------------------------- */

// MARK: - MapViewCoordinator

public extension MapView {
    final class Coordinator: NSObject, MKMapViewDelegate {
        let delegate: MapView

        init(_ delegate: MapView) {
            self.delegate = delegate
        }
    }
}

// MARK: - User Location

public extension MapView.Coordinator {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {}
}

// MARK: - Annotation

public extension MapView.Coordinator {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {}

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {}

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        self.delegate.viewForAnnotation(annotation)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.delegate.selectedAnnotation = view.annotation
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.delegate.selectedAnnotation = nil
    }

//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {}

    //    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {}
}

// MARK: - Overlay

extension MapView.Coordinator {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {}
}

// MARK: - Gestures

public extension MapView.Coordinator {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        self.delegate.coordinateRegion = mapView.region
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {}

    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        self.delegate.userTrackingMode = mode
    }
}
