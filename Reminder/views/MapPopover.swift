//
//  MapPopover.swift
//  Reminder
//
//  Created by Rita Ithaisa on 31/1/23.
//

import Foundation
import SwiftUI
import MapKit


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
]
struct MapPopover: View {
    @Binding var showPopover: Bool
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    var body: some View {
        NavigationView(){
            VStack{
                HStack(){
                    Button(){
                        showPopover = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.lightGray)
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                }.padding()
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
    }
}
