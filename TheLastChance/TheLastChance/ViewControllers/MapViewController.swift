//
//  MapViewController.swift
//  TheLastChance
//
//  Created by  Alexander Fedoseev on 22.12.2024.
//

/*import UIKit
import MapKit
import CoreLocation

final class MapViewController: BaseViewController, CLLocationManagerDelegate {
    private var mapView: MKMapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization() // или requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        setupConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось получить местоположение: \(error.localizedDescription)")
    }

}
extension MapViewController {
    private func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false

        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}
*/
