//
//  MainMapPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 15.09.2023.
//

import UIKit
import CoreLocation


protocol MainMapViewProtocol: AnyObject {
    func setUpPoints(points: [Place])
    func getLattitude() -> Double
    func getLongtitude() -> Double
    func getRaduis() -> Int
}

protocol MainMapPresenterProtocol: AnyObject {
    init(
        view: MainMapViewProtocol,
        pointsNetworksService: MapNetworkService
    )
    
    var selectedIndex: IndexPath? { get set }
    func getAllPointsFromServer()
    func getWalkingPointsFromServer()
    func getPlaygroundPointsFromServer()
    func getDangerousPointsFromServer()
}

class MainMapPresenter: MainMapPresenterProtocol {
    
    weak var view: MainMapViewProtocol?
    var pointsNetworksService: MapNetworkService?
    var selectedIndex: IndexPath? = nil
    
    required init(
        view: MainMapViewProtocol,
        pointsNetworksService: MapNetworkService
    ) {
        self.view = view
        self.pointsNetworksService = pointsNetworksService
    }
    
    func getAllPointsFromServer() {
        Task{
            do {
                if let allPoints = try await pointsNetworksService?.searchMarkers(lat: view?.getLattitude() ?? 0, lng: view?.getLongtitude() ?? 0, type: "", raduis: view?.getRaduis() ?? 0) {
                    var points: [Place] = []
                    for point in allPoints {
                        points.append(Place(id: UUID(uuidString: point.id) ?? UUID(), name: point.title, description: point.description, category: .init(category: point.type), lattitude: point.location[0][0], longtitude: point.location[0][1]))
                    }
                    DispatchQueue.main.sync {
                        self.view?.setUpPoints(points: points)
                    }
                    
                    
                }
                
            
            } catch MapErrors.refreshToken {
                print("refreshTokenError")
            } catch MapErrors.unknown {
                print("unknown")
            } catch AuthErrors.unknown {
                print("unknown2")
            }
            
        }
    }
    
    func getWalkingPointsFromServer() {
        Task{
            do {
                if let allPoints = try await pointsNetworksService?.searchMarkers(lat: view?.getLattitude() ?? 0, lng: view?.getLongtitude() ?? 0, type: "WALKS", raduis: view?.getRaduis() ?? 0) {
                    var points: [Place] = []
                    for point in allPoints {
                        points.append(Place(id: UUID(uuidString: point.id) ?? UUID(), name: point.title, description: point.description, category: .init(category: point.type), lattitude: point.location[0][0], longtitude: point.location[0][1]))
                    }
                    self.view?.setUpPoints(points: points)
                    
                }
                
            
            } catch MapErrors.refreshToken {
                print("refreshTokenError")
            } catch MapErrors.unknown {
                print("unknown")
            } catch AuthErrors.unknown {
                print("unknown2")
            }
            
        }
    }
    
    func getPlaygroundPointsFromServer() {
        Task{
            do {
                if let allPoints = try await pointsNetworksService?.searchMarkers(lat: view?.getLattitude() ?? 0, lng: view?.getLongtitude() ?? 0, type: "DOG_FRIENDLY", raduis: view?.getRaduis() ?? 0) {
                    var points: [Place] = []
                    for point in allPoints {
                        points.append(Place(id: UUID(uuidString: point.id) ?? UUID(), name: point.title, description: point.description, category: .init(category: point.type), lattitude: point.location[0][0], longtitude: point.location[0][1]))
                    }
                    self.view?.setUpPoints(points: points)
                    
                }
                
            
            } catch MapErrors.refreshToken {
                print("refreshTokenError")
            } catch MapErrors.unknown {
                print("unknown")
            } catch AuthErrors.unknown {
                print("unknown2")
            }
            
        }
    }
    
    func getDangerousPointsFromServer() {
        Task{
            do {
                if let allPoints = try await pointsNetworksService?.searchMarkers(lat: view?.getLattitude() ?? 0, lng: view?.getLongtitude() ?? 0, type: "DANGEROUS", raduis: view?.getRaduis() ?? 0) {
                    var points: [Place] = []
                    for point in allPoints {
                        points.append(Place(id: UUID(uuidString: point.id) ?? UUID(), name: point.title, description: point.description, category: .init(category: point.type), lattitude: point.location[0][0], longtitude: point.location[0][1]))
                    }
                    self.view?.setUpPoints(points: points)
                    
                }
                
            
            } catch MapErrors.refreshToken {
                print("refreshTokenError")
            } catch MapErrors.unknown {
                print("unknown")
            } catch AuthErrors.unknown {
                print("unknown2")
            }
            
        }
    }
}


