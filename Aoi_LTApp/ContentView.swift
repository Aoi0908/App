//
//  ContentView.swift
//  Aoi_LTApp
//
//

import SwiftUI
import CoreLocation
import MapKit

class LocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    var location: CLLocation? {
        didSet {
            self.updateLocation?(location)
        }
    }
    var updateLocation: ((CLLocation?)->())?
    let locationManager = CLLocationManager()
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }
}

struct ContentView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @State private var showingAlert = false
    @State private var navigationLinkIsActive = false
    @State private var alertText = ""
    @State private var listItems: [String] = []
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("バッテリー残量: \(getBatteryLevel())%")
                    if locationViewModel.location != nil {
                        Text("緯度: \(locationViewModel.location!.coordinate.latitude)")
                        Text("経度: \(locationViewModel.location!.coordinate.longitude)")
                    } else {
                        Text("Location not available.")
                    }
                    
                    Text("gehoge")
                    
                }
                MapView(locationViewModel: locationViewModel)
                HStack {
                    Spacer()
                    Button(action: {
                        // Share the contents of the List
                        let activityView = UIActivityViewController(activityItems: [self.getShareContent()], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityView, animated: true, completion: nil)
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    NavigationLink(destination: friendView(), isActive: $navigationLinkIsActive){
                        EmptyView()

                    }
                    Button(action: {
                        // Navigate to friendView
                        self.navigationLinkIsActive = true
                    }) {
                        Image(systemName: "person")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    Spacer()
                    
                }
                
            }
            .padding()
            .navigationBarTitle("自分の情報")
            
        }
    }
    
    func getBatteryLevel() -> Int {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let batteryLevel = device.batteryLevel * 100
        return Int(batteryLevel)
    }
    
    func getShareContent() -> String {
        var shareContent = "バッテリー残量: \(getBatteryLevel())%"
        if let location = locationViewModel.location {
            shareContent += "\nLatitude: \(location.coordinate.latitude)\nLongitude: \(location.coordinate.longitude)"
        } else {
            shareContent += "\nLocation not available."
        }
        return shareContent
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MapView: UIViewRepresentable {
    @ObservedObject var locationViewModel: LocationViewModel
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let location = locationViewModel.location {
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            uiView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            uiView.addAnnotation(annotation)
        }
    }
    
}

struct ShareButton: View {
    var body: some View {
        Button(action: {
            self.share()
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(40)
        }
    }
    
    func share() {
        let activityViewController = UIActivityViewController(activityItems: ["Share Text"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}


