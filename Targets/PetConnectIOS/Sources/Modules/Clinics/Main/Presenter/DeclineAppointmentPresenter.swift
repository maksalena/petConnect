//
//  DeclineAppointmentPresenter.swift
//  PetConnect
//
//  Created by Алёна Максимова on 26.01.2024.
//  Copyright © 2024 PetConnect. All rights reserved.
//

import UIKit
import RealmSwift

protocol DeclineAppointmentViewProtocol: AnyObject {
}

protocol DeclineAppointmentPresenterProtocol: AnyObject {
    init(
        view: DeclineAppointmentViewProtocol,
        appointment: AppointmentModel,
        clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol,
        filesNetworkService: FilesNetworkServiceProtocol,
        keychainService: KeyChainStorageProtocol
    )
    
    var appointment: AppointmentModel { get }
    func declineTapped(id: UUID)
    func sendRating(rating: Int, id: UUID)
    
}

class DeclineAppointmentPresenter: DeclineAppointmentPresenterProtocol {
    var appointment: AppointmentModel
    weak var view: DeclineAppointmentViewProtocol?
    var index = "00"
    var clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol?
    var filesNetworkService: FilesNetworkServiceProtocol?
    var keychainService: KeyChainStorageProtocol?
    
    
    required init(
        view: DeclineAppointmentViewProtocol,
        appointment: AppointmentModel,
        clinicsNetworkService: AppointmentClinicsNetworkServiceProtocol,
        filesNetworkService: FilesNetworkServiceProtocol,
        keychainService: KeyChainStorageProtocol) {
            self.view = view
            self.appointment = appointment
            self.clinicsNetworkService = clinicsNetworkService
            self.filesNetworkService = filesNetworkService
            self.keychainService = keychainService
        }
    
    func declineTapped(id: UUID) {
        Task{
            do{
                try await self.clinicsNetworkService?.declineAppointment(id: id)
                
            } catch {
                print(12345)
            }
        }
    }
    
    func sendRating(rating: Int, id: UUID) {
        
        let ratingJSON = createRatingRequestJson(value: rating)
        Task{
            do{
                try await self.clinicsNetworkService?.sendRating(id: id, ratingJSON: ratingJSON)
                
            } catch {
                print(12345)
            }
        }
    }
}

