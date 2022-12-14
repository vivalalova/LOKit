//
//  File.swift
//
//
//  Created by Lova on 2021/4/9.
//

import MapKit

// MARK: - Equatable

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude
            &&
            lhs.longitude == rhs.longitude
    }
}

extension MKCoordinateSpan: Equatable {
    public static func == (lhs: MKCoordinateSpan, rhs: MKCoordinateSpan) -> Bool {
        lhs.latitudeDelta == rhs.latitudeDelta
            &&
            lhs.longitudeDelta == rhs.longitudeDelta
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center == rhs.center
            &&
            lhs.span == rhs.span
    }
}

extension Array where Element: Equatable {
    static func - (lhs: Self, rhs: Self) -> Self {
        lhs.filter { lh in
            !rhs.contains { rh in
                rh == lh
            }
        }
    }
}
