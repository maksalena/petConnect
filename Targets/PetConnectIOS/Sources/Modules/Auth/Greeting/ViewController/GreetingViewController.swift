//
//  GreetingViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 27.12.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit

class GreetingViewController: BaseUIViewController {
    
    var presenter: GreetingPresenterProtocol?
    
    func view() -> GreetingView {
       return self.view as! GreetingView
    }
    
    override func loadView() {
       self.view = GreetingView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        view().signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        view().signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.willAppear()
    }
        
    // MARK: - Actions
    
    @objc func signInTapped(_ sender: UIButton) {
        
        let signInController = AuthBuilder.createSignInPage()
        self.navigationController?.pushViewController(signInController, animated: true)
        
    }
    
    @objc func signUpTapped(_ sender: UIButton) {
        
        let signUpController = AuthBuilder.createSignUpPage()
        self.navigationController?.pushViewController(signUpController, animated: true)
        
    }
}

extension GreetingViewController: GreetingViewProtocol {
    
}
