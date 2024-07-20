//
//  DeclineAppointmentViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit

class DeclineAppointmentViewController: BaseUIViewController {
        
    var presenter: DeclineAppointmentPresenter?
    
    func view() -> DeclineAppointmentView {
       return self.view as! DeclineAppointmentView
    }
    
    override func loadView() {
       self.view = DeclineAppointmentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if presenter?.appointment.status == "old" {
            view().configureRecent()
            
            if presenter?.appointment.hasRating == false {
                
                view().ratingView.star1.addTarget(self, action: #selector(mark), for: .touchUpInside)
                view().ratingView.star2.addTarget(self, action: #selector(mark), for: .touchUpInside)
                view().ratingView.star3.addTarget(self, action: #selector(mark), for: .touchUpInside)
                view().ratingView.star4.addTarget(self, action: #selector(mark), for: .touchUpInside)
                view().ratingView.star5.addTarget(self, action: #selector(mark), for: .touchUpInside)
                view().bringSubviewToFront(view().ratingCoverView)
                view().bringSubviewToFront(view().ratingView)
                view().ratingView.layer.opacity = 1
                view().ratingCoverView.layer.opacity = 0.5
                
                view().ratingView.acceptButton.addTarget(self, action: #selector(sendRating), for: .touchUpInside)
                
            }
        }else{
            view().configureNew()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().declineButton.addTarget(self, action: #selector(decline), for: .touchUpInside)
        fillView()
    }
    
    @objc func sendRating() {
        view().ratingView.layer.opacity = 0
        view().ratingCoverView.layer.opacity = 0
        var rating = 0
        
        if (view().ratingView.star1.currentBackgroundImage == UIImage(named: "filledStar")) {
            rating += 1
        }
        if (view().ratingView.star2.currentBackgroundImage == UIImage(named: "filledStar")) {
            rating += 1
        }
        if (view().ratingView.star3.currentBackgroundImage == UIImage(named: "filledStar")) {
            rating += 1
        }
        if (view().ratingView.star4.currentBackgroundImage == UIImage(named: "filledStar")) {
            rating += 1
        }
        if (view().ratingView.star5.currentBackgroundImage == UIImage(named: "filledStar")) {
            rating += 1
        }
        
        presenter?.sendRating(rating: rating, id: presenter?.appointment.id ?? UUID())
    }
    
    @objc func mark(sender: UIButton) {
        if view().ratingView.star1 == sender {
            view().setStar(button: view().ratingView.star1, isFilled: true)
            view().setStar(button: view().ratingView.star2, isFilled: false)
            view().setStar(button: view().ratingView.star3, isFilled: false)
            view().setStar(button: view().ratingView.star4, isFilled: false)
            view().setStar(button: view().ratingView.star5, isFilled: false)
            
        } else if view().ratingView.star2 == sender {
            view().setStar(button: view().ratingView.star1, isFilled: true)
            view().setStar(button: view().ratingView.star2, isFilled: true)
            view().setStar(button: view().ratingView.star3, isFilled: false)
            view().setStar(button: view().ratingView.star4, isFilled: false)
            view().setStar(button: view().ratingView.star5, isFilled: false)

        } else if view().ratingView.star3 == sender {
            view().setStar(button: view().ratingView.star1, isFilled: true)
            view().setStar(button: view().ratingView.star2, isFilled: true)
            view().setStar(button: view().ratingView.star3, isFilled: true)
            view().setStar(button: view().ratingView.star4, isFilled: false)
            view().setStar(button: view().ratingView.star5, isFilled: false)

        } else if view().ratingView.star4 == sender {
            view().setStar(button: view().ratingView.star1, isFilled: true)
            view().setStar(button: view().ratingView.star2, isFilled: true)
            view().setStar(button: view().ratingView.star3, isFilled: true)
            view().setStar(button: view().ratingView.star4, isFilled: true)
            view().setStar(button: view().ratingView.star5, isFilled: false)

        } else if view().ratingView.star5 == sender {
            view().setStar(button: view().ratingView.star1, isFilled: true)
            view().setStar(button: view().ratingView.star2, isFilled: true)
            view().setStar(button: view().ratingView.star3, isFilled: true)
            view().setStar(button: view().ratingView.star4, isFilled: true)
            view().setStar(button: view().ratingView.star5, isFilled: true)
        }
    }
    
    @objc func decline() {
        let alertLogout = UIAlertController(title: "Подтвердите действие", message: "Вы уверены, что действительно хотите отменить приём?", preferredStyle: .alert)
        
        alertLogout.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        alertLogout.addAction(UIAlertAction(title: "Отменить приём", style: .destructive, handler: { [self] _ in
            
            self.presenter?.declineTapped(id: self.presenter?.appointment.id ?? UUID())
            self.view().infoImage.image = UIImage(named: "declinedAppointment")
            self.view().declineButton.isHidden = true
        }))
        
        self.present(alertLogout, animated: true)
    }
    
    func fillView() {
        view().petNameLabel.descriptionLabel.text = presenter?.appointment.petName
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM, HH:mm"
        
        if let date = dateFormatterGet.date(from: ((presenter?.appointment.day ?? "") + " " + (presenter?.appointment.time ?? ""))) {
            view().dateAndTimeLabel.descriptionLabel.text = dateFormatterPrint.string(from: date)
        }
        
        view().doctorLabel.descriptionLabel.text = presenter?.appointment.name
        
        view().specialisationLabel.descriptionLabel.text = presenter?.appointment.specialization
        
        view().complaineLabel.descriptionLabel.text = presenter?.appointment.compliance
        
        view().clinicNameAndAddressLabel.descriptionLabel.text = (presenter?.appointment.clinicName ?? "") + " " + (presenter?.appointment.address ?? "")
        
        view().priceLabel.descriptionLabel.text = "\(presenter?.appointment.price ?? 0) ₽"
        view().recomendations.descriptionLabel.text = presenter?.appointment.recomendation
        view().diagnoz.descriptionLabel.text = presenter?.appointment.destination
    }
        
        
    
}

extension DeclineAppointmentViewController: DeclineAppointmentViewProtocol {
    
}
