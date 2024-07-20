//
//  NavBarView.swift
//  PetConnect
//
//  Created by Andrey on 12.08.2023.
//

import UIKit

protocol PrimaryNavBarViewDelegate: AnyObject {
    
    /// Open user profile
    func openUserProfile()
}
final class PrimaryNavBarView: UIView {
    
    weak var delegate: PrimaryNavBarViewDelegate?
    
    var titleString:String?
    var notConnection:String = "Соединение..."
    var updating:String = "Обновление..."
    
    private lazy var title: UILabel = {
        let element = UILabel()
        element.textColor = UIColor(named: "on-surface")
        element.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var avatar: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(avatarPressed), for: .touchUpInside)
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 14
        return element
    }()
    
    /// Set up views
    /// - Parameter frame: view frame
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    /// Error handling
    /// - Parameter coder: NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Add subviews
    private func setViews() {
        backgroundColor = .clear
        
        addSubview(title)
        addSubview(avatar)
    }
    
    /// Add constraints to the view
    private func layoutViews() {
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            avatar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            avatar.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 28),
            avatar.widthAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    /// Trigger the delegate function
    @objc func avatarPressed() {
        delegate?.openUserProfile()
    }
    
    /// Configure Primary Tab Bar
    /// - Parameters:
    ///   - text: nav bar title
    ///   - image: nav bar image
    func configure(with text: String, image: UIImage?) {
        self.titleString = text
        title.text = text
        avatar.setImage(image, for: .normal)
    }
    
    func hideImage(){
        avatar.isHidden = true
    }
    
    func setNotConnection(){
        if self.title.text == self.notConnection {return }
        UIView.transition(with: self.title, duration: 0.3, options: .transitionCrossDissolve) {
            self.title.text = self.notConnection
        }
        
    }
    
    func setUpdating(){
        if self.title.text == self.updating {return }
        UIView.transition(with: self.title, duration: 0.3, options: .transitionCrossDissolve) {
            self.title.text = self.updating
        }
        
    }
    
    func setTitle(completion: (()->Void)? = nil ){
        if self.title.text == self.titleString {return }
        UIView.transition(with: self.title, duration: 0.3, options: .transitionCrossDissolve) {
            self.title.text = self.titleString
        } completion: { _ in
            completion?()
        }
        
    }
    
    func setAdditionalText(_ text:String, completion: (()->Void)? = nil ){
        if self.title.text == text {return }
        UIView.transition(with: self.title, duration: 0.3, options: .transitionCrossDissolve) {
            self.title.text = text
        } completion: { _ in
            completion?()
        }
    }
    
    func updateAvatar(image:UIImage){
        self.avatar.setImage(image, for: .normal)
    }
}
