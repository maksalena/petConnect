//
//  ClinicsListPresenter.swift
//  PetConnect
//
//  Created by Егор Завражнов on 21.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import Foundation

protocol ClinicsListViewControllerProtocol:AnyObject{
    func reloadClinicsList()
}

protocol ClinicsListPresenterProtocol:AnyObject{
    init(view:ClinicsListViewControllerProtocol, clientClinicsNetworkService:ClientClinicsNetworkServiceProtocol)
    
    var clinics:[PetClinicModel] { get }
    
    var isNextPage:Bool { get }
    
    func searchClinics(reload:Bool)
}

class ClinicsListPresenter:ClinicsListPresenterProtocol{
    weak var view:ClinicsListViewControllerProtocol?
    
    var clientClinicsNetworkService:ClientClinicsNetworkServiceProtocol
    
    var clinics:[PetClinicModel] = []
    
    private var prevPage:Int = -1
    var isNextPage:Bool = true
    
    required init(view:ClinicsListViewControllerProtocol, clientClinicsNetworkService:ClientClinicsNetworkServiceProtocol) {
        self.view = view
        self.clientClinicsNetworkService = clientClinicsNetworkService
    }
    
    func searchClinics(reload:Bool){
        if reload{
            self.prevPage = -1
            self.isNextPage = true
            self.clinics = []
        }
        
        if !self.isNextPage{
            return
        }
        
        Task{
            do{
                prevPage += 1
                let clinicsJson = try await self.clientClinicsNetworkService.searchClinics(page: prevPage)
                self.isNextPage = clinicsJson.paging.after != nil
                
                DispatchQueue.main.async {
                    for clinic in clinicsJson.content{
                        
                        let schedule:PetClinicModel.Schedule? = nil
                        
                        var specializations: [PetClinicModel.Specialization] = []
                        
                        for specialization in clinic.specializations{
                            let new = PetClinicModel.Specialization(
                                id: specialization.specialization.id,
                                value: specialization.specialization.value,
                                price: specialization.price,
                                description: specialization.specialization.description
                            )
                            
                            specializations.append(new)
                        }
                        
                        
                        let newClinic = PetClinicModel(
                            clinicId: clinic.id,
                            title: clinic.name,
                            address: clinic.address,
                            schedule: clinic.schedule,
                            description: clinic.description,
                            phone: clinic.phone ?? "",
                            specializations: specializations
                        )
                        
                        self.clinics.append(newClinic)
                    }
                    
                    self.view?.reloadClinicsList()
                }

            } catch{
                self.prevPage = -1
                self.isNextPage = true
                self.clinics = []
            }
        }
    }
}
