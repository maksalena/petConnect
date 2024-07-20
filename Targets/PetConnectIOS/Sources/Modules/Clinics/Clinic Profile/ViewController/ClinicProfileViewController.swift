//
//  ClinicProfileViewController.swift
//  PetConnect
//
//  Created by SHREDDING on 24.10.2023.
//

import UIKit

final class ClinicProfileViewController: BaseUIViewController {
    
    private func view() -> ClinicProfileView{
        return view as! ClinicProfileView
    }
    
    override func loadView() {
        super.loadView()
        self.view = ClinicProfileView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDelegates()
        addTargets()
        self.view().segmentCollectionView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func addDelegates(){
        self.view().segmentCollectionView.delegate = self
        self.view().segmentCollectionView.dataSource = self
    }
    
    func addTargets(){
        self.view().infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        self.view().servicesButton.addTarget(self, action: #selector(servicesButtonTapped), for: .touchUpInside)
        self.view().doctorsButton.addTarget(self, action: #selector(doctorsButtonTapped), for: .touchUpInside)
        self.view().feedbackButton.addTarget(self, action: #selector(feedbackButtonTapped), for: .touchUpInside)
        
        self.view().bookVisit.addTarget(self, action: #selector(bookVisitTapped), for: .touchUpInside)
    }
    
    
    @objc func bookVisitTapped(){
//        let vc = ClinicsAssembly.createAppointmentTypeViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - ButtonTargets
    @objc func infoButtonTapped(){
        self.selectSegment(index: 0)
        self.collectionViewscrollToCell(index: 0)
    }
    
    @objc func servicesButtonTapped(){
        self.selectSegment(index: 1)
        self.collectionViewscrollToCell(index: 1)
    }
    
    @objc func doctorsButtonTapped(){
        self.selectSegment(index: 2)
        self.collectionViewscrollToCell(index: 2)
    }
    
    @objc func feedbackButtonTapped(){
        self.selectSegment(index: 3)
        self.collectionViewscrollToCell(index: 3)
    }
    
    func selectSegment(index:Int){
        self.view().selectSegment(index: index)
    }
    
    func collectionViewscrollToCell(index:Int){
        self.view().segmentCollectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
    }

}

// MARK: - segmentCollectionView Datasource
extension ClinicProfileViewController:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileClinicCollectionViewCell", for: indexPath) as! ProfileClinicCollectionViewCell
        cell.tableView.delegate = self
        cell.tableView.restorationIdentifier = "CollectionViewTableView\(indexPath.row)"
        cell.tableView.dataSource = self
        cell.tableView.reloadData()
        return cell
    }
        
}

extension ClinicProfileViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: self.view().segmentCollectionView.frame.width,
            height: self.view().segmentCollectionView.frame.height
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - segmentCollectionView Delegate
extension ClinicProfileViewController:UICollectionViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.view().segmentCollectionView {
            let page = Int(self.view().segmentCollectionView.contentOffset.x / self.view().segmentCollectionView.frame.size.width)
            self.selectSegment(index: page)
        }
    }
}

// MARK: - UITableViewDataSource
extension ClinicProfileViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.restorationIdentifier{
        case "CollectionViewTableView0": return 3
        case "CollectionViewTableView1": return 10
        case "CollectionViewTableView2": return 2
        case "CollectionViewTableView3": return 5
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.restorationIdentifier{
        case "CollectionViewTableView0": 
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicInfoTableViewCell", for: indexPath) as! ClinicInfoTableViewCell
            switch indexPath.row{
            case 0:  cell.configureCell(style: .location, title: "Адрес", textViewTexts: ["Казань, ул. Чистопольская 34"])
            case 1:  cell.configureCell(style: .clock, title: "Ежедневно 09:00 - 21:00", textViewTexts: [])
            case 2:  cell.configureCell(style: .phone, title: "Контакты", textViewTexts: ["+ 8 999 111 00 88", "+ 8 999 111 00 88", "+ 8 999 111 00 88", "+ 8 999 111 00 88", "+ 8 999 111 00 88", "+ 8 999 111 00 88", "+ 8 999 111 00 88"])
            default: break
            }
            return cell
        case "CollectionViewTableView1":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicServicesTableViewCell", for: indexPath) as! ClinicServicesTableViewCell
            
            let service:[ClinicServiceModel] = [
                ClinicServiceModel(title: "хуй", price: "100"),
                ClinicServiceModel(title: "Вторичный приём", price: "700"),
                ClinicServiceModel(title: "хуй", price: "700"),
                ClinicServiceModel(title: ",kz", price: "700")
            ]
            
            cell.configureCell(title: "Услуги долбоеба", services: service)
            return cell
        case "CollectionViewTableView2":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicDoctorsTableViewCell", for: indexPath) as! ClinicDoctorsTableViewCell
            return cell
            
        case "CollectionViewTableView3":
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicSendFeedbackTableViewCell", for: indexPath) as! ClinicSendFeedbackTableViewCell
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ClinicFeedbackTableViewCell", for: indexPath) as! ClinicFeedbackTableViewCell
                return cell
            }
            
        default: return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ClinicProfileViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.restorationIdentifier == "CollectionViewTableView2"{
//            let vc = ClinicsAssembly.createDoctorProfileViewController()
            
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
