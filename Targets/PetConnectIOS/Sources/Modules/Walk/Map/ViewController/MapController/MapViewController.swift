//
//  MapViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 08.09.2023.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: BaseUIViewController {
    
    var presenter: MainMapPresenter?
            
    // MARK: - Variables
    var currentPoint: CLLocation!
    var firstLoad: Bool = true
    var placemarks:[Place] = []
    
    var manager:CLLocationManager =  {
        let manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        return manager
    }()
    
    var lastUserLocation:CLLocation? = nil
                
    // MARK: - Actions
    
    private func view() -> MapView{
        return view as! MapView
    }
    
    override func loadView() {
        super.loadView()
        self.view = MapView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "favorite"), for: .normal)
        button.addTarget(self, action: #selector(showFavorite), for: .touchUpInside)
        let favouriteButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = favouriteButton
        
        self.addDelegetes()
        self.addTargets()
        manager.requestWhenInUseAuthorization()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presenter?.getAllPointsFromServer()
                
    }
    
    // MARK: - Configuration
    private func addTargets(){
        self.view().addPlaceButton.addTarget(self, action: #selector(addPlace), for: .touchUpInside)
        self.view().locationButton.addTarget(self, action: #selector(changePitch), for: .touchUpInside)
    }
    
    private func addDelegetes(){
        self.view().map.delegate = self
        
        manager.delegate = self
        
        self.view().buttonsCV.delegate = self
        self.view().buttonsCV.dataSource = self
    }
    
    func fetchPlacesOnMap(_ places: [Place]) {
        for place in places {
            let image = place.category == PlaceCategory.walking ? UIImage(named: "markerWalks") : place.category == PlaceCategory.playground ? UIImage(named: "markerPlayground") : UIImage(named: "markerDangerous")
            
            let newAnnotation = PlaceAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.lattitude, longitude: place.longtitude), title: place.name, subtitle: place.category.getTitle(), image: image, identifier: place.id)
            
            if !self.view().map.annotations.contains(where: { annotation in
                let currentAnnotation = annotation as? PlaceAnnotation
                return currentAnnotation?.identifier == newAnnotation.identifier }){
                DispatchQueue.main.async {
                    self.view().map.addAnnotation(newAnnotation)
                }
                    
                }
            
        }
        
    }
    
    @objc func addPlace() {
        
        let sheetViewController = AddPlaceViewController()
        sheetViewController.completionHandler = { point in
         
            self.placemarks.append(point)
            self.fetchPlacesOnMap(self.placemarks)
        }
        sheetViewController.presenter = MapPresenter(view: sheetViewController, model: Place(id: UUID()), pointsNetworksService: presenter?.pointsNetworksService ?? MapNetworkService(), filesNetworkService: FilesNetworkService(), keyChainService: KeyChainStorage(), usersNetworkService: UsersNetworkService(), point: self.view().map.userLocation.location)
        
        present(sheetViewController, animated: true, completion: nil)
    }
    
    @objc func showFavorite() {
        let view = MapAssembly.createFavoriteViewController()
        (view as? FavoriteViewController)?.completionHandler = { [self] point in
            let newLocation = CLLocation(latitude: point.lattitude, longitude: point.longtitude)
            var newCoordinateRegion = self.view().map.region
            newCoordinateRegion.center = newLocation.coordinate
            
            self.view().map.setRegion(newCoordinateRegion, animated: true)
                        
            
            let title = point.name
            let sheetViewController = PlaceDescriptionViewController()
            sheetViewController.completionHandler = { point in
                self.placemarks = self.placemarks.filter{ $0.id != point.id }
                self.fetchPlacesOnMap(self.placemarks)
                
            }
            sheetViewController.completionDeselector = {
                
            }
            
            sheetViewController.placeId = point.id
            sheetViewController.presenter = MapPresenter(view: sheetViewController, model: point, pointsNetworksService: presenter?.pointsNetworksService ?? MapNetworkService(), filesNetworkService: FilesNetworkService(), keyChainService: KeyChainStorage(), usersNetworkService: UsersNetworkService(), point: self.view().map.userLocation.location)
            present(sheetViewController, animated: true, completion: nil)
            
            
        }
        
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func changePitch(){
        switch self.view().map.userTrackingMode{
            
        case .none:
            
            self.view().map.setUserTrackingMode(.follow, animated: true)
        case .follow:
            self.view().map.setUserTrackingMode(.followWithHeading, animated: true)
        case .followWithHeading:
            self.view().map.setUserTrackingMode(.none, animated: true)
        @unknown default:
            break
//                fatalError("Unknown userTrackingMode")
        }
        
    }
    
    func radiusForRegion(region: MKCoordinateRegion) -> CLLocationDistance {
        let centerLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        
        let topLeftCoordinate = CLLocationCoordinate2D(latitude: region.center.latitude - region.span.latitudeDelta / 2,
                                                       longitude: region.center.longitude - region.span.longitudeDelta / 2)
        let topLeftLocation = CLLocation(latitude: topLeftCoordinate.latitude, longitude: topLeftCoordinate.longitude)
        
        return centerLocation.distance(from: topLeftLocation)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        print("didChangeAuthorization")
        if status == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Notify listeners that the user has a new location
//        print("didUpdateLocations")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    }
}

extension MapViewController: MKMapViewDelegate{
    
    
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print("mapViewWillStartLocatingUser")
    }
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        print("mapViewDidStopLocatingUser")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("MAP VIEW didUpdate userLocation")
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        switch mode{
            
        case .none:
            UIView.transition(with: self.view().locationButton, duration: 0.3, options: .transitionCrossDissolve) {
                self.view().locationButton.setImage(UIImage(systemName: "location"), for: .normal)
            }
        case .follow:
            UIView.transition(with: self.view().locationButton, duration: 0.3, options: .transitionCrossDissolve){
                self.view().locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
            }
        case .followWithHeading:
            UIView.transition(with: self.view().locationButton, duration: 0.3, options: .transitionCrossDissolve){
                self.view().locationButton.setImage(UIImage(systemName: "location.north.line.fill"), for: .normal)
            }
        @unknown default:
            break
//                fatalError("Unknown userTrackingMode")
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
        for collection in self.view().buttonsCV.visibleCells {
            if collection.isSelected {
                (collection as? PlaceCell)?.placeLabel.text == "Место для прогулок" ? self.presenter?.getWalkingPointsFromServer() : (collection as? PlaceCell)?.placeLabel.text == "Dog friendly заведения" ? self.presenter?.getPlaygroundPointsFromServer() : self.presenter?.getDangerousPointsFromServer()
                return
            }
        }
        
        self.presenter?.getAllPointsFromServer()
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self){
//            let reuseId = "user"
//            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//
//            if pinView == nil {
//                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            }
//            else {
//                pinView?.annotation = annotation
//            }
//            
//            pinView?.canShowCallout = false
//            pinView!.image = UIImage(named: "user")
//            pinView?.zPriority = .max
//            
//            return pinView
            
            return MKUserLocationView()
        }
        if let placeAnnotation = annotation as? PlaceAnnotation{
            let reuseId = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)

            if pinView == nil {
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            }
            else {
                pinView?.annotation = annotation
            }
            
            pinView?.canShowCallout = false
            pinView!.image = placeAnnotation.image
            
            return pinView
        }
        
        return nil
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let title = view.annotation?.title
        for place in placemarks {
            if place.name == title {
                let sheetViewController = PlaceDescriptionViewController()
                sheetViewController.completionHandler = { point in
                    mapView.removeAnnotations(mapView.annotations)
                    self.placemarks = self.placemarks.filter{ $0.id != point.id }
                    self.fetchPlacesOnMap(self.placemarks)
                    
                }
                sheetViewController.completionDeselector = {
                    mapView.deselectAnnotation(view.annotation, animated: true)
                }
                sheetViewController.placeId = place.id
                sheetViewController.presenter = MapPresenter(view: sheetViewController, model: place, pointsNetworksService: presenter?.pointsNetworksService ?? MapNetworkService(), filesNetworkService: FilesNetworkService(), keyChainService: KeyChainStorage(), usersNetworkService: UsersNetworkService(), point: mapView.userLocation.location)
                present(sheetViewController, animated: true, completion: nil)
                break
            }
        }
        
    }
}

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceCell.identifier, for: indexPath) as! PlaceCell
        
        cell.setup(with: indexPath.row == 0 ? "Место для прогулок" : indexPath.row == 1 ? "Dog friendly заведения" : "Опасные места")
        
        if presenter?.selectedIndex == indexPath{
            cell.placeLabel.font = .boldSystemFont(ofSize: 16)
            cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        } else {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            cell.placeLabel.font = .systemFont(ofSize: 16)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath) as! PlaceCell
        
        if presenter?.selectedIndex == indexPath {
            presenter?.selectedIndex = nil
            
            
            UIView.animate(withDuration: 0.3) {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                cell.placeLabel.font = .systemFont(ofSize: 16)
            }
            
            for cell in collectionView.visibleCells {
                if cell.isSelected == true {
                    break
                }
            }
            
            DispatchQueue.main.async {
            self.presenter?.getAllPointsFromServer()
                let newLocation = CLLocation(latitude: self.view().map.region.center.latitude, longitude: self.view().map.region.center.longitude)
                var newCoordinateRegion = self.view().map.region
                newCoordinateRegion.center = newLocation.coordinate
                                
                self.view().map.setRegion(newCoordinateRegion, animated: true)
            }
            
            
        } else {
            if let preSelected = presenter?.selectedIndex{
                let preSelectedCell = collectionView.cellForItem(at: preSelected) as? PlaceCell
                UIView.animate(withDuration: 0.3){
                    preSelectedCell?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    cell.placeLabel.font = .systemFont(ofSize: 16)
                }
            }
            
            presenter?.selectedIndex = indexPath
            
            
            UIView.animate(withDuration: 0.3){
                cell.placeLabel.font = .boldSystemFont(ofSize: 16)
                cell.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
            
            for cell in collectionView.visibleCells.filter({ (otherCell) in otherCell != cell }) {
                cell.transform = CGAffineTransform(scaleX: 1, y: 1)
                (cell as? PlaceCell)?.placeLabel.font = .systemFont(ofSize: 16)
            }
            
            if let selectedIndex = presenter?.selectedIndex {
                
                let annotations = self.view().map.annotations.filter({ !($0 is MKUserLocation) })
                self.view().map.removeAnnotations(annotations)
                
                selectedIndex.row == 0 ?
                DispatchQueue.main.async {
                    self.presenter?.getWalkingPointsFromServer()
                    
                    let newLocation = CLLocation(latitude: self.view().map.region.center.latitude, longitude: self.view().map.region.center.longitude)
                    var newCoordinateRegion = self.view().map.region
                    newCoordinateRegion.center = newLocation.coordinate
                    
                    self.view().map.setRegion(newCoordinateRegion, animated: true)
                } :
                selectedIndex.row == 1 ?
                DispatchQueue.main.async {
                    self.presenter?.getPlaygroundPointsFromServer()
                    
                    let newLocation = CLLocation(latitude: self.view().map.region.center.latitude, longitude: self.view().map.region.center.longitude)
                    var newCoordinateRegion = self.view().map.region
                    newCoordinateRegion.center = newLocation.coordinate
                    
                    self.view().map.setRegion(newCoordinateRegion, animated: true)
                } :
                DispatchQueue.main.async {
                    self.presenter?.getDangerousPointsFromServer()
                    
                    let newLocation = CLLocation(latitude: self.view().map.region.center.latitude, longitude: self.view().map.region.center.longitude)
                    var newCoordinateRegion = self.view().map.region
                    newCoordinateRegion.center = newLocation.coordinate
                    
                    self.view().map.setRegion(newCoordinateRegion, animated: true)
                }
            }
                        
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 200, height: collectionView.frame.height - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

extension MapViewController: MainMapViewProtocol {
    func getRaduis() -> Int {
        DispatchQueue.main.sync {
            return Int(radiusForRegion(region: self.view().map.region)) + 1000
        }
        
    }
    
    func getLattitude() -> Double {
        DispatchQueue.main.sync {
            return self.view().map.region.center.latitude
        }
        
    }
    
    func getLongtitude() -> Double {
        DispatchQueue.main.sync {
            return self.view().map.region.center.longitude
        }
        
    }
    
    func setUpPoints(points: [Place]) {
        placemarks = points
        fetchPlacesOnMap(placemarks)
    }
    
}
