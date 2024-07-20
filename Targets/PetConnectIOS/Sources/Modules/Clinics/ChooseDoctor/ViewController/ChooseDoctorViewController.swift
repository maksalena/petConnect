//
//  ChooseDoctorViewController.swift
//  PetConnect
//
//  Created by Алёна Максимова on 10.11.2023.
//  Copyright © 2023 PetConnect. All rights reserved.
//

import UIKit
import AlertKit

final class ChooseDoctorViewController: BaseUIViewController {
    
    var presenter:ChooseDoctorPresenterProtocol!
    
    private func view() -> ChooseDoctorView {
        return view as! ChooseDoctorView
    }
    
    override func loadView() {
        super.loadView()
        self.view = ChooseDoctorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view().filterDoctorCollectionView.delegate = self
        self.view().filterDoctorCollectionView.dataSource = self
//        self.view().filterDoctorCollectionView.reloadData()
        
        self.view().doctorTableView.delegate = self
        self.view().doctorTableView.dataSource = self
        
        self.view().doctorTableView.reloadData()
        
        self.view().calendarView.delegate = self
        
        
        let refresh = UIRefreshControl()
        refresh.addAction(UIAction(handler: { _ in
            self.view().doctorTableView.reloadData()
            self.view().doctorTableView.refreshControl?.endRefreshing()
        }), for: .valueChanged)
        
        self.view().doctorTableView.refreshControl = refresh
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.presenter.searchDoctors(date: self.view().calendarView.selectedDate, reload: true)
//    }

}

// MARK: - doctorCollectionView Datasource
extension ChooseDoctorViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier{
        case "calendar":
            return self.presenter.doctors[collectionView.tag].calendar.count
        case "filterDoctorCollectionView":
            var count = 1
            if self.presenter.specialistIndex != nil{
                count += 1
            }
            
            return count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.restorationIdentifier{
        case "calendar":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentTimeCollectionViewCell", for: indexPath) as! AppointmentTimeCollectionViewCell
            
            cell.time.text = self.presenter.doctors[collectionView.tag].calendar[indexPath.row].time
            
            return cell
        
        case "filterDoctorCollectionView":
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorCollectionViewCell", for: indexPath) as! DoctorCollectionViewCell
            
            switch indexPath.row{
            case 0:
                cell.configure(title: self.presenter.clinic.title)
            case 1:
                if let index = self.presenter.specialistIndex{
                    cell.configure(title: self.presenter.clinic.specializations[index].value)
                }
            default:
                fatalError("Wrong number of Items")
            }
            
            return cell
            
        default:
            fatalError("CollectionView Not Found")
            
        }
        
    }
        
}

extension ChooseDoctorViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView.restorationIdentifier == "calendar"{
            return 4
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.restorationIdentifier{
        case "calendar":
            return .init(width: 60, height: 32)
        
        case "filterDoctorCollectionView":
            
            switch indexPath.row{
            case 0:
                return CGSize(width: self.presenter.clinic.title.count * 7 + 48, height: 36)
            case 1:
                if let index = self.presenter.specialistIndex{
                    return CGSize(width: self.presenter.clinic.specializations[index].value.count * 7 + 48, height: 36)
                }
            default:
                fatalError("Wrong number of Items")
            }
            
        default:
            fatalError("CollectionView Not Found")
        }
        
        return CGSize(width: 100, height: 36)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView.cellForItem(at: indexPath) is AppointmentTimeCollectionViewCell{
            let time = self.presenter.doctors[collectionView.tag].calendar[indexPath.row]
            
            
            if self.view().calendarView.selectedDate > .now || Date.timeStringToDate(date: self.view().calendarView.selectedDate, time: time.time) > Date.now{
                let vc = ClinicsAssembly.createRequestViewController(dateTime: (date: self.view().calendarView.selectedDate, timeId: time.id, timeString: time.time), doctor: self.presenter.doctors[collectionView.tag], clinic: self.presenter.clinic)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                AlertKitAPI.present(
                    title: "Время уже прошло",
                    subtitle: "Выберите другое время",
                    icon: .error,
                    style: .iOS17AppleMusic,
                    haptic: .error
                )
            }
            
//            let vc = ClinicsAssembly.createRequestViewController(dateTime: (date: self.view().calendarView.selectedDate, timeId: time.id, timeString: time.time), doctor: self.presenter.doctors[collectionView.tag], clinic: self.presenter.clinic)
            
//            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
    }

}

extension ChooseDoctorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView.restorationIdentifier {
        case "doctorTableView":
            if self.presenter.doctors.count == 0 {
                self.view().noDoctorsLabel.isHidden = false

                return 0
            } else {
                self.view().noDoctorsLabel.isHidden = true
            }
            
            if self.presenter.isNextPage{
                return self.presenter.doctors.count + 1
            }
            return self.presenter.doctors.count
            

        default:
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell is LoadDoctorsTableViewCell{
            self.presenter.searchDoctors(date: self.view().calendarView.selectedDate, reload: false)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView.restorationIdentifier {
        case "doctorTableView":

            
            if self.presenter.isNextPage && indexPath.row == tableView.numberOfRows(inSection: 0) - 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: "LoadDoctorsTableViewCell", for: indexPath) as! LoadDoctorsTableViewCell
                
                cell.acitivity.startAnimating()
                
                return cell
            }
            
            
            let doctor = presenter.doctors[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell") as! DoctorTableViewCell
            
            cell.calendar.tag = indexPath.row
            
            cell.calendar.dataSource = self
            cell.calendar.delegate = self
            
            cell.calendar.reloadData()
            cell.configure(
                firstName: doctor.firstName,
                lastName: doctor.lastName,
                middleName: doctor.middleName,
                specialization: doctor.specialization.value,
                price: doctor.specialization.price,
                experience: doctor.experience,

                mark: (markAverage: doctor.mark.avr, numMarks: doctor.mark.num),

                tableViewWidth: tableView.frame.width - 40 - 32
            )
            
            
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (tableView.cellForRow(at: indexPath)?.reuseIdentifier == "DoctorTableViewCell") {
            // provide info of the chosen doctor
            let vc = ClinicsAssembly.createDoctorProfileViewController(doctor: self.presenter.doctors[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            //logic for random doctor
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.restorationIdentifier == "doctorTableView"{
            
//            print(tableView.rowHeight)
//            print(tableView.estimatedRowHeight)
            
//            print()
            
//            print(cell?.frame)
//            if indexPath.row == 1{
//                let width = tableView.frame.width - 40
//                let collectionViewCellWidth = 60
//                let numInRow = Int(width) / collectionViewCellWidth
//                
//                let numOfCells = 10
//                let cellHeight = 32
//                let numRows = (numOfCells / numInRow) + 1
//                
//                return tableView.rowHeight + CGFloat(cellHeight * numRows)
//                
//            }
            
        }
        
        return UITableView.automaticDimension
    }
    
    
}

extension ChooseDoctorViewController:ChooseDoctorViewControllerProtocol{
    func reloadDoctorsList() {
        self.view().doctorTableView.reloadData()
    }
    
    
}

extension ChooseDoctorViewController:CalendarCustomViewDelegate{
    func didSelect(date: Date) {
        self.presenter.searchDoctors(date: date, reload: true)
    }
}


