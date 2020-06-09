//
//  EmployeeViewController.swift
//  EmployeeDirectory
//
//  Created by Vishnu Nair on 09/06/20.
//  Copyright © 2020 Vishnu Nair. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchContainerView : UIView!
     let searchController = UISearchController(searchResultsController: nil)
    fileprivate var filteredList = [EmployeeResponse?]()
    var employeeDetails : [EmployeeResponse?]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.configureSearchController()
            self.setCollectionView()
            self.title = "Employees"
        }
        
        self.getEmployeeDetails()
    }
    
    func getEmployeeDetails(){
        EmployeeRouter().getEmployeeList { (result) in
            switch result{
            case .success(let employeeResponsArray):
                self.employeeDetails = employeeResponsArray
            case .failure(_):
                debugPrint("Failed To Load CollectionView")
                break
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
          DispatchQueue.main.async {
              self.searchController.isActive = false
          }
      }
    
    
}
extension EmployeeViewController: UISearchControllerDelegate{
    
    private func configureSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        searchContainerView.addSubview(searchController.searchBar)
    }
        
    
    private func filterSearchController(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            let searchString = self.searchController.searchBar.text ?? ""
            self.filteredList.removeAll()
            self.filteredList = self.employeeDetails?.filter { employees in
                guard let name = employees?.name else {debugPrint("Name found nil while searching");return false}
                guard let email = employees?.email else {debugPrint("Email found nil while searching");return false}
            let isMatchingSearchText = name.lowercased().contains(searchString.lowercased()) || email.lowercased().contains(searchString.lowercased()) ||
                searchString.lowercased().count == 0
            return  isMatchingSearchText
                } ?? []
        
             self.collectionView.reloadData()
        }
       
        
    }
    
}
extension EmployeeViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterSearchController(searchController.searchBar)
    }
    
}

extension EmployeeViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchController(searchBar)
    }
    
}
extension EmployeeViewController : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func setCollectionView(){
        self.collectionView.register(EmployeeCell.self)
         self.collectionView.delegate = self
         self.collectionView.dataSource = self
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return searchController.isActive ? filteredList.count : employeeDetails?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         let cell : EmployeeCell = collectionView.dequeueReusableCell(for: indexPath) //ReusableViewProtocol
         
        let image = searchController.isActive ?  self.filteredList[indexPath.row]?.profileImage :  employeeDetails?[indexPath.row]?.profileImage
        let empName = searchController.isActive ? self.filteredList[indexPath.row]?.name : employeeDetails?[indexPath.row]?.name
        FetchImage.shared.getImage(imageUrl: image) { (image) in
            DispatchQueue.main.async {
                cell.setView(name: empName, image: image)
            }
        }
        
        return cell
     }
     
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth: CGFloat = collectionView.frame.width
            let itemHeight: CGFloat = collectionView.frame.height / 2
            return CGSize(width: itemWidth, height: itemHeight);
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? EmployeeCell
        guard let employeeDetail = employeeDetails?[indexPath.row] else{return}
        self.goToEmployeeDetailVC(employee: employeeDetail,image:cell?.image)
    }
    private func goToEmployeeDetailVC(employee:EmployeeResponse,image:UIImage?){
           DispatchQueue.main.async {
               let storyboard = UIStoryboard(name: StoryBoardIdentifier.Main.rawValue, bundle: nil)
               let controller = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.EmployeeDetailVC.rawValue) as! EmployeeDetailViewController
               controller.employeeDetail = employee
               controller.image = image
               let backItem = UIBarButtonItem()
               backItem.title = ""
               self.navigationItem.backBarButtonItem = backItem
               self.navigationController?.pushViewController(controller, animated: true)
           }
               
       }
}
