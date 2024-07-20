//
//  NotificationViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 19.08.2023.
//

import UIKit
import AlertKit
import SnapKit

class NotificationViewController: BaseUIViewController, DropDownMenuDelegate {
        
    // MARK: - Variables
    
    var presenter: NotificationPresenterProtocol?
    
    var saveButtonWasEnabledByTime = false
    var saveButtonWasEnabledByDate = false
    
    
    var addButtonTopConstraint: NSLayoutConstraint?
    
    // MARK: - Actions
    
    private func view() -> NotificationView{
        view as! NotificationView
    }
    
    override func loadView() {
        super.loadView()
        self.view = NotificationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addKeyboardObservers()
        
        addTargets()
        addDelegates()
        
        self.view().category.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.willAppear()
        
        if presenter?.isEdit ?? false{
            self.view().addDeleteButton()
        }
        
    }
    
    private func addTargets(){
        self.view().addButton.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
        self.view().saveButton.addTarget(self, action: #selector(saveNotifications), for: .touchUpInside)
        self.view().deleteButton.addTarget(self, action: #selector(deleteNotification), for: .touchUpInside)
    }
    
    private func addDelegates(){
        self.view().name.delegate = self
        self.view().date.delegate = self
        self.view().category.delegate = self
    }
    
    fileprivate func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification){
        
        if var keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            keyboard = self.view.convert(keyboard, from: nil)
            
            var contentInset:UIEdgeInsets = self.view().scrollView.contentInset
            contentInset.bottom = keyboard.size.height - self.view().buttonsStack.frame.height
            self.view().scrollView.contentInset = contentInset
        }
        
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.view().scrollView.contentInset = contentInset
    }
    
    func createNotificationView(index:Int) {
        
        let new = OneNotificationView()
        new.index = index
        new.delegate = self
        
        new.amount.delegate = self
        new.time.delegate = self
        self.view().addNotification(view: new)
        
    }
    
    @objc func addNotification() {
        self.presenter?.model?.prescriptions.append(TabletsFoddersOnePeriodJsonResponse(count: -1, time: ""))
        
        createNotificationView(index: self.presenter?.model?.prescriptions.count ?? 0)
        self.presenter?.validateModelData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.view().scrollView.scrollRectToVisible(self.view().addButton.frame, animated: true)
        }
    }
        
    @objc func saveNotifications() {
        presenter?.savedTapped()
    }
    
    @objc func deleteNotification(){
        presenter?.deleteTapped()
    }
    
    func wrongPrescriptions(){
        let alertLogout = UIAlertController(title: "Ошибка данных", message: "Проверьте, пожалуйства, поля с датой и временем.", preferredStyle: .alert)
         
        alertLogout.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        self.present(alertLogout, animated: true)
    }
        
    func didSelect(_ tableView: UITableView, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presenter?.setNotificationData(type: .category, value: "Корм")
        case 1:
            presenter?.setNotificationData(type: .category, value: "Лекарство")
        default:
            presenter?.setNotificationData(type: .category, value: "")
        }
        
    }
}

extension NotificationViewController:OneNotificationViewDelegate{
    func didRemove(index: Int) {
        for i in index - 1..<self.view().notificationsStack.subviews.count{
            let view = self.view().notificationsStack.subviews[i] as! OneNotificationView
            view.index -= 1
        }
        self.presenter?.model?.prescriptions.remove(at: index - 1)
        self.presenter?.validateModelData()
    }
}

extension NotificationViewController: NotificationViewProtocol {
    func enableSaveButton() {
        self.view().saveButton.isEnabled = true
    }
    
    func disableSaveButton() {
        self.view().saveButton.isEnabled = false
    }
    
    func fillEditValues(notification:OneTabletsFoddersRealmModel) {
                
        switch notification.type {
        case .tablet:
            self.view().category.setText(text: "Лекарство")
        case .fodder:
            self.view().category.setText(text: "Корм")
        }
        self.view().category.isUserInteractionEnabled = false
        self.view().category.layer.opacity = 0.5
        
        
        self.view().name.text = notification.name
        
        self.view().date.text = notification.untilAt.toString()
        
        for periodIndex in 0..<notification.periods.count{
            self.createNotificationView(index: periodIndex + 1)
            let utcDateFormatter = DateFormatter()
            utcDateFormatter.dateFormat = "HH:mm"
            utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set to UTC time zone

            // Parse the UTC date string into a Date object
            let utcDate = utcDateFormatter.date(from: notification.periods[periodIndex].time) ?? Date.now
            
            // Create a DateFormatter for the current local time zone
            let localDateFormatter = DateFormatter()
            localDateFormatter.dateFormat = "HH:mm"
            localDateFormatter.timeZone = TimeZone.current // Set to the current local time zone
            
            // Convert the UTC date to the current local time zone
            let localDateString = localDateFormatter.string(from: utcDate)
            let newNotification = self.view().notificationsStack.subviews[periodIndex] as? OneNotificationView
            newNotification?.amount.text = "\(notification.periods[periodIndex].count)"
            newNotification?.time.text = localDateString
//            notifications[periodIndex].1.text = "\(notification.periods[periodIndex].count)"
//            notifications[periodIndex].2.text = localDateString
        }
        

        
    }
    
    
    func setWeakTime(_ textField: UITextField) {
        (textField.superview?.superview as! CustomTextField).setWrongValue()
        if self.view().saveButton.isEnabled {
            saveButtonWasEnabledByTime = true
            self.view().saveButton.isEnabled = false
        }
    }
    
    func setStrongTime(_ textField: UITextField) {
        (textField.superview?.superview as! CustomTextField).setCorrectValue()
        if (!self.view().saveButton.isEnabled && saveButtonWasEnabledByTime && saveButtonWasEnabledByDate) {
            saveButtonWasEnabledByTime = false
            self.view().saveButton.isEnabled = true
        }
    }
    
    func setWeakDate(_ textField: UITextField) {
        (textField.superview?.superview as! CustomTextField).setWrongValue()
        if self.view().saveButton.isEnabled {
            saveButtonWasEnabledByDate = true
            self.view().saveButton.isEnabled = false
        }
    }
    
    func setStrongDate(_ textField: UITextField) {
        (textField.superview?.superview as! CustomTextField).setCorrectValue()
        if (!self.view().saveButton.isEnabled && saveButtonWasEnabledByDate && saveButtonWasEnabledByTime) {
            saveButtonWasEnabledByDate = false
            self.view().saveButton.isEnabled = true
        }
    }
    
    func popViewWithSuccessAlert(title:String){
        
        AlertKitAPI.present(
            title: title,
            icon: .done,
            style: .iOS17AppleMusic,
            haptic: .success
        )
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NotificationViewController: CustomTextFieldDelegate {
    
    func customTextFieldDidChange(_ textField: UITextField) {
        if textField.restorationIdentifier == "dateTextField" {
            let newText = textField.text?.replacingOccurrences(of: ",", with: ".")
            textField.text = newText
        }else if textField.restorationIdentifier?.contains("time") ?? false{
            
            let index = Int((textField.restorationIdentifier?.split(separator: "_")[1])!)!
            
            let localDateFormatter = DateFormatter()
            localDateFormatter.dateFormat = "HH:mm"
            localDateFormatter.timeZone = TimeZone.current // Set to your local time zone

            // Parse the local date string into a Date object
            if let localDate = localDateFormatter.date(from: textField.text ?? "") {
                
                // Create a DateFormatter for UTC
                let utcDateFormatter = DateFormatter()
                utcDateFormatter.dateFormat = "HH:mm"
                utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Set to UTC time zone
                
                // Convert the local date to UTC
                let utcDateString = utcDateFormatter.string(from: localDate)
                
                
                self.presenter?.model?.prescriptions[index - 1].time = utcDateString
            }
            
        } else if textField.restorationIdentifier?.contains("amount") ?? false {
            let index = Int((textField.restorationIdentifier?.split(separator: "_")[1])!)!
            self.presenter?.model?.prescriptions[index - 1].count = Int(textField.text ?? "-1") ?? -1
        }
        
    }
    func customTextFieldDidBeginEditing(_ textField: UITextField) {
        if textField.restorationIdentifier == "dateTextField" || textField.restorationIdentifier?.contains("time") ?? false || textField.restorationIdentifier?.contains("amount") ?? false{
            textField.addDoneCancelToolbar(showCancelButton: false)
        }
    }
    func customTextFieldDidEndEditing(_ textField: UITextField) {
        switch textField.restorationIdentifier {
        case "nameTextField":
            presenter?.setNotificationData(type: .name, value: textField.text ?? "")

        case "dateTextField":
            presenter?.setNotificationData(type: .date, value: textField.text ?? "")
        default:
            break
        }
        
        self.presenter?.validateModelData()
        
    }
}
