//
//  Loading.swift
//  PetConnect
//
//  Created by SHREDDING on 22.08.2023.
//

import UIKit

class LoadingUIView: UIView {
    
    // MARK: - Private properties
    
    private lazy var activityIndicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Public properties
    
    public var baseView:UIView!
    
    // MARK: - Inits
    override init(frame: CGRect) {
        fatalError("init(frame: CGRect) is not implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(frame: CGRect) is not implemented")
    }
    
    init(baseView:UIView){
        super.init(frame: CGRectZero)
        self.baseView = baseView
        commonInit()
    }
    
    
    private func commonInit(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.opacity = 0
        
        self.addSubview(self.activityIndicator)
        self.baseView.addSubview(self)
        self.baseView.sendSubviewToBack(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    // MARK: - public Funcs
    
    public func activate(){
        self.baseView.bringSubviewToFront(self)
        self.activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3) {
            self.layer.opacity = 0.5
        }
    }
    
    public func deactivate(){
        UIView.animate(withDuration: 0.3) {
            self.layer.opacity = 0
        }
        self.activityIndicator.stopAnimating()
        self.baseView.sendSubviewToBack(self)
    }
    
}
