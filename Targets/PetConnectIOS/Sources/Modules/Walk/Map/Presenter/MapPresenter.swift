//
//  MapPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 08.09.2023.
//

import UIKit
import CoreLocation

public enum placeFields{
    case category
    case name
    case descriptions
}

protocol MapViewProtocol: AnyObject {

    func enableSaveButton()
    func disableSaveButton()
    func setStrongDescription(_ textField: UITextField)
    func setWeakDescription(_ textField: UITextField)
    func setUpUser(userName: String, userImage: UIImage, likes: Int, dislikes: Int, myLike: String, id: String)
    func closeWithSuccess(point:Place)
    func setFavorite(favorite: [Place])
    func isFavorite(favorite: Bool)
    func setUserId(id: String)
}

protocol MapPresenterProtocol: AnyObject {
    init(
        view: MapViewProtocol,
        model: Place,
        pointsNetworksService: MapNetworkService,
        filesNetworkService:FilesNetworkServiceProtocol,
        keyChainService:KeyChainStorageProtocol,
        usersNetworkService:UsersNetworkService,
        point: CLLocation?

    )
    func moreTapped(id: UUID, action: Int)
    func likeTapped(id: UUID, state: String)
    func deleteLike(id: UUID)
    func deleteFavorite(id: UUID)
    func getPlaceInfo() -> Place?
    
    func setPlaceData(type: placeFields, value: String)
    func descriptionDidChange(value: String, _ textField: UITextField)
    func getPlaceDescription(id: UUID)
    func getFavorite()
    func isFavorite(id: UUID)
    func savedTapped()
    
    func getPersonalInfo()
    func loadPersonalInfo()
    
}

class MapPresenter: MapPresenterProtocol {
    
    weak var view: MapViewProtocol?
    var model: Place?
    var currentPoint: CLLocation?
    var points: [Place]
    var pointsNetworksService: MapNetworkService?
    var filesNetworkService: FilesNetworkServiceProtocol?
    var keyChainService: KeyChainStorageProtocol?
    var usersNetworkService:UsersNetworkService?
    
    required init(
        view: MapViewProtocol,
        model: Place,
        pointsNetworksService: MapNetworkService,
        filesNetworkService: FilesNetworkServiceProtocol,
        keyChainService:KeyChainStorageProtocol,
        usersNetworkService: UsersNetworkService,
        point: CLLocation?) {
            self.view = view
            self.model = model
            self.view?.disableSaveButton()
            self.points = []
            self.currentPoint = point
            self.pointsNetworksService = pointsNetworksService
            self.filesNetworkService = filesNetworkService
            self.keyChainService = keyChainService
            self.usersNetworkService = usersNetworkService
    }
    
    func moreTapped(id: UUID, action: Int) {
        guard action != -1 else { return }
        switch action {
        case 1:
            print("1")
        case 2:
            let favoriteJson = setFavorite(walkingMarkerID: id.uuidString)
            Task{
                do{
                    if let result = try await self.pointsNetworksService?.markFavorite(favoriteJson: favoriteJson){
                        if result {
                            print("Success")
                            DispatchQueue.main.async {
                                self.view?.isFavorite(favorite: true)
                            }
                        } else {
                            print("Fail")
                        }
                    }
                    
                }catch PetsError.unknown{
                    print("Error Set like unknown")
                }catch PetsError.refreshTokenError{
                    print("Error Set like refreshTokenError")
                }catch PetsError.errorParseJson{
                    print("Error Set like errorParseJson")
                }
                
            }
        case 3:
            Task{
                do{
                    if let result = try await self.pointsNetworksService?.deleteMarker(markerId: id){
                        if result {
                            print("Success")
                            DispatchQueue.main.async {
        //                        self.view?.popView(with: "Место Удалено")
                                if let model = self.model {
                                    self.view?.closeWithSuccess(point: model)
                                }
                            }
                        } else {
                            print("Fail")
                        }
                    }
                    
                }catch PetsError.unknown{
                    print("Error Set like unknown")
                }catch PetsError.refreshTokenError{
                    print("Error Set like refreshTokenError")
                }catch PetsError.errorParseJson{
                    print("Error Set like errorParseJson")
                }
                
            }
        case 4:
            Task{
                do{
                    if let result = try await self.pointsNetworksService?.deleteFavorite(markerId: id){
                        if result {
                            print("Success")
                            DispatchQueue.main.async {
                                self.view?.isFavorite(favorite: false)
                            }
                        } else {
                            print("Fail")
                        }
                    }
                    
                }catch PetsError.unknown{
                    print("Error Set like unknown")
                }catch PetsError.refreshTokenError{
                    print("Error Set like refreshTokenError")
                }catch PetsError.errorParseJson{
                    print("Error Set like errorParseJson")
                }
                
            }
        default:
            break
        }
    }
    
    func likeTapped(id: UUID, state: String) {
        let likeJson = setMyLike(walkingMarkerID: id.uuidString, isLike: state)
        
        Task{
            do{
                if let result = try await self.pointsNetworksService?.markLike(likeJson: likeJson){
                    if result {
                        print("Success")
                    } else {
                        print("Fail")
                    }
                }
                
            }catch PetsError.unknown{
                print("Error Set like unknown")
            }catch PetsError.refreshTokenError{
                print("Error Set like refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Set like errorParseJson")
            }
            
        }
    
    }
    
    func deleteLike(id: UUID) {
        Task{
            do{
                if let result = try await self.pointsNetworksService?.deleteLike(markerId: id){
                    if result {
                        print("Success")
                    } else {
                        print("Fail")
                    }
                }
                
            }catch PetsError.unknown{
                print("Error Set like unknown")
            }catch PetsError.refreshTokenError{
                print("Error Set like refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Set like errorParseJson")
            }
            
        }
    }
    
    func deleteFavorite(id: UUID) {
        Task{
            do{
                if let result = try await self.pointsNetworksService?.deleteFavorite(markerId: id){
                    if result {
                        print("Success")
                    } else {
                        print("Fail")
                    }
                }
                
            }catch PetsError.unknown{
                print("Error Set like unknown")
            }catch PetsError.refreshTokenError{
                print("Error Set like refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Set like errorParseJson")
            }
            
        }
    }
    
    func getPlaceInfo() -> Place? {
        return model
    }

    func getPlaceDescription(id: UUID) {
        Task{
            do {
                if let point = try await pointsNetworksService?.getMarker(markerId: id) {
                    var image:Data?
                    if let photoId = point.user.avatars.first?.fileID {
                        if image == nil {
                            if let photoPath = point.user.avatars.first?.filePath {
                                image = try await self.filesNetworkService?.downloadPhoto(photoPath)
                                
                                if let img = image {
                                    DispatchQueue.main.async {
                                        self.view?.setUpUser(userName: point.user.username, userImage: (UIImage(data: img) ?? UIImage(named: "avatar")!), likes: point.likes, dislikes: point.dislikes, myLike: point.myLike.isLike, id: point.user.id)
                                    }
                                   
                                }
                            }
                        }
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
    
    func getFavorite() {
        Task{
            do {
                if let favorites = try await pointsNetworksService?.getFavorite().content {
                    var fav: [Place] = []
                    for favorite in favorites {
                        
                        fav.append(Place(id: UUID(uuidString: favorite.id.walkingMarker.id) ?? UUID(), name: favorite.id.walkingMarker.title, description: favorite.id.walkingMarker.description, category: PlaceCategory(category: favorite.id.walkingMarker.type), lattitude: favorite.id.walkingMarker.location[0][0], longtitude: favorite.id.walkingMarker.location[0][1]))
                    }
                    DispatchQueue.main.sync {
                        self.view?.setFavorite(favorite: fav)
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
    
    func isFavorite(id: UUID) {
        Task{
            do {
                if let point = try await pointsNetworksService?.checkFavorite(markerId: id) {
                    print("Favorite")
                    DispatchQueue.main.sync {
                        self.view?.isFavorite(favorite: true)
                    }
                                        
                }
            
            } catch MapErrors.refreshToken {
                print("refreshTokenError")
            } catch MapErrors.unknown {
                print("unknown")
            } catch MapErrors.notFavorite {
                print("Not favorite")
                DispatchQueue.main.sync {
                    self.view?.isFavorite(favorite: false)
                }
            } catch AuthErrors.unknown {
                print("unknown2")
            }
            
        }
    }
    
    func setPlaceData(type: placeFields, value: String) {
        switch type {
        case .category:
            model?.setCategory(category: value)
        case .name:
            model?.setName(name: value)
        case .descriptions:
            model?.setDescription(description: value)
        }
        if (model?.isEmptyData() ?? true){
            view?.disableSaveButton()
        } else {
            view?.enableSaveButton()
        }
    }
    
    func descriptionDidChange(value: String, _ textField: UITextField){
        if !DescriptionValidation.validateDescription(value: value) {
            view?.setWeakDescription(textField)
        }else{
            view?.setStrongDescription(textField)
        }
    }
    
    func savedTapped(){
        let type = model?.category.getTitle() == "Место для прогулок" ? "WALKS" : model?.category.getTitle() == "Dog friendly заведения" ? "DOG_FRIENDLY" : "DANGEROUS"
        
        let pointJson = createPointRequestJson(title: model?.name ?? "", description: model?.description ?? "", type: type , location: Location(x: currentPoint?.coordinate.latitude ?? 0, y: currentPoint?.coordinate.longitude ?? 0), radiusMeters: 100)
        
        
        Task{
            do{
                if let result = try await self.pointsNetworksService?.createMarker(pointJson: pointJson){
                    print("Saved")

                    let newPlace = Place(id: UUID(uuidString: result.id) ?? UUID(), name: result.title, description: result.description, category: PlaceCategory(category: result.type), lattitude: CLLocationDegrees(result.location[0][0]), longtitude: CLLocationDegrees(result.location[0][1]))
                    
                    DispatchQueue.main.async {
//                        self.view?.popView(with: "Место добавлено")
                        self.view?.closeWithSuccess(point: newPlace)
                    }
                    
                }
                
                
                
            }catch PetsError.unknown{
                print("Error Create pet unknown")
            }catch PetsError.refreshTokenError{
                print("Error Create pet refreshTokenError")
            }catch PetsError.errorParseJson{
                print("Error Create pet errorParseJson")
            }catch FilesErrors.unknown{
                print("Error add image pet unknown")
            }
            
        }
    }
    
    func getPersonalInfo(){
        let userId = keyChainService?.getId()
        
        if userId != nil {
            view?.setUserId(id: userId!)
        }
        self.loadPersonalInfo()
        
    }
    
    func loadPersonalInfo(){
        Task{
            if let personalInfo = try await usersNetworkService?.getMe(){
                
                keyChainService?.setId(id: personalInfo.id)
                
                DispatchQueue.main.async {
                    self.view?.setUserId(id: personalInfo.id)
                }
            }
        }
    }
    
}

