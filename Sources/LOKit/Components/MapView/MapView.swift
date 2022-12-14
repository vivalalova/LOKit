//
//  MapView.swift
//  IPCameras
//
//  Created by Lova on 2021/4/4.
//

import Combine
import MapKit
import SwiftUI

// MARK: - MapView UIViewRepresentable

public struct MapView: UIViewRepresentable {
    @State private(set) var userLocation: MKUserLocation?

    @Binding var mapType: MKMapType
    @Binding var showsUserLocation: Bool
    @Binding var region: MKCoordinateRegion?
    @Binding var userTrackingMode: MKUserTrackingMode
    @Binding var annotations: [Annotation]

    var viewForAnnotation: (MKAnnotation) -> MKMarkerAnnotationView?

    @Binding var selectedAnnotation: MKAnnotation?

    public func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero).config { map in
            map.delegate = context.coordinator
        }
    }

    public func updateUIView(_ uiView: MKMapView, context: Context) {
        DispatchQueue.main.async {
            if uiView.mapType != self.mapType {
                uiView.mapType = self.mapType
            }

            if uiView.showsUserLocation != self.showsUserLocation {
                uiView.showsUserLocation = self.showsUserLocation
            }

            if let region = self.region, region != uiView.region, uiView.userTrackingMode == .none {
                uiView.setRegion(region, animated: true)
            }

            if uiView.userTrackingMode != self.userTrackingMode {
                uiView.setUserTrackingMode(self.userTrackingMode, animated: true)
            }

            uiView.updateAnnotations(to: self.annotations)
        }
    }

    public func makeCoordinator() -> Coordinator { Coordinator(self) }

    public init(mapType: Binding<MKMapType> = .constant(.standard),
                region: Binding<MKCoordinateRegion?> = .constant(nil),
                isZoomEnabled: Binding<Bool> = .constant(true),
                isScrollEnabled: Binding<Bool> = .constant(true),
                showsUserLocation: Binding<Bool> = .constant(true),
                userTrackingMode: Binding<MKUserTrackingMode> = .constant(.follow),
                annotations: Binding<[Annotation]> = .constant([]),
                viewForAnnotation: @escaping (MKAnnotation) -> MKMarkerAnnotationView? = { _ in nil },
                selectedAnnotation: Binding<MKAnnotation?> = .constant(nil)) {
        //
        self._mapType = mapType
        self._region = region
        self._userTrackingMode = userTrackingMode
        self._showsUserLocation = showsUserLocation
        self._annotations = annotations

        self.viewForAnnotation = viewForAnnotation

        self._selectedAnnotation = selectedAnnotation
    }
}

// MARK: - Preview

struct MapView_Previews: PreviewProvider {
    @State static var region: MKCoordinateRegion? = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.015, longitude: 121.55),
                                                                       latitudinalMeters: 1000, longitudinalMeters: 1000)

    @State static var annotations: [Annotation] = [Annotation(lat: 25.015, lng: 121.55)]

    static var previews: some View {
        MapView(region: $region, annotations: $annotations)
            .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - MapViewCoordinator

public extension MapView {
    final class Coordinator: NSObject, MKMapViewDelegate {
        var delegate: MapView

        init(_ delegate: MapView) {
            self.delegate = delegate
        }
    }
}

// MARK: - User Location

public extension MapView.Coordinator {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.delegate.userLocation = userLocation
    }
}

// MARK: - Annotation

public extension MapView.Coordinator {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        Console.log(view)
        Console.log(control)
    }

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
        self.delegate.region = mapView.region
    }

    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        self.delegate.userTrackingMode = mode
    }
}
