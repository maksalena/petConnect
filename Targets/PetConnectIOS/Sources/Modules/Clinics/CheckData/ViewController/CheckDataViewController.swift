//
//  CheckDataViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 28.10.2023.
//

import UIKit
import AlertKit

class CheckDataViewController: BaseUIViewController {
    
    var presenter:CheckDataPresenterProtocol!
    
    func view() -> CheckDataView {
       return self.view as! CheckDataView
    }
    
    override func loadView() {
       self.view = CheckDataView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view().saveButton.addTarget(self, action: #selector(saveRequest), for: .touchUpInside)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    @objc func saveRequest() {
        // save request
        self.presenter.addAppointment()
    }
}

extension CheckDataViewController:CheckDataViewProtocol{
    
    func fillValues(){
        self.view().specialization.descriptionLabel.text = self.presenter.doctor.specialization.value
        self.view().doctor.descriptionLabel.text = "\(self.presenter.doctor.lastName) \(self.presenter.doctor.firstName) \(self.presenter.doctor.middleName)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU") // Установка русской локали для названия месяцев и дней недели

        let formattedDate = dateFormatter.string(from: self.presenter.dateTime.date)
        self.view().dateTime.descriptionLabel.text = "\(formattedDate), \(self.presenter.dateTime.timeString)"
        
        self.view().pet.descriptionLabel.text = self.presenter.pet.name
        self.view().complance.descriptionLabel.text = self.presenter.compilance
        self.view().clinic.descriptionLabel.text = "\(self.presenter.clinic.title), \(self.presenter.clinic.address)"
        self.view().price.descriptionLabel.text = "\(self.presenter.doctor.specialization.price) ₽ (Оплата возможна только в клинике)"
    }
    
    func appointmentAdded(){
        AlertKitAPI.present(
            title: "Вы записаны",
            icon: .heart,
            style: .iOS17AppleMusic,
            haptic: .success
        )
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func conflictTime(){
        AlertKitAPI.present(
            title: "На данное время уже есть запись",
            subtitle: "Выберите другое время",
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func unknownError() {
        AlertKitAPI.present(
            title: "Что то пошло не так",
            subtitle: "Повторите попытку позже",
            icon: .error,
            style: .iOS17AppleMusic,
            haptic: .error
        )
        self.navigationController?.popToRootViewController(animated: true)
    }
}
