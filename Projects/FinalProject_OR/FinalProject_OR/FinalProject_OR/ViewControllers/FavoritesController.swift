//
//  FavoritesController.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/20/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    let queryService = QueryServices()
    let appData = AppData.shared
    var buildPermitFavoriteList: [BuildingPermit]{
        return appData.buildPermitFavoriteList
    }

    var buildingPermitSelected: BuildingPermit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController("Favoritos")
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        let sortButton = UIBarButtonItem(image: #imageLiteral(resourceName: "sortlight"), style: .plain, target: self, action: #selector(sortButtonPressed))
        sortButton.tintColor = .white
        let addButton = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-heart-outline-50"), style: .plain, target: self, action: #selector(addNewBuildingPermitButtonPressed))
        addButton.tintColor = .white
        navigationItem.rightBarButtonItems = [addButton, sortButton]
    }
    
    @objc func sortButtonPressed(){
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc private func addNewBuildingPermitButtonPressed() {
        let newBuildingPermitVC = storyboard?.instantiateViewController(withIdentifier: "newBuildingPermit") as! BuildingPermitAddController
        newBuildingPermitVC.newBuildingPermit = BuildingPermit()
        newBuildingPermitVC.addDelegate = self
        configureBackBarButton()
        navigationController?.pushViewController(newBuildingPermitVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    @objc func heartTapped(_ sender: UIButton) {
        appData.updateBuildingPermitFavoriteByRow(with: sender.tag)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBuildingPermitDetail" {
            let buildingPermitDetailVC = segue.destination as! DetailViewController
            buildingPermitDetailVC.buildingPermit = buildingPermitSelected
        }
    }

}

extension FavoritesController: AddBuildingPermitDelegate {
    func didPressSaveButton(_ buildingPermit: BuildingPermit) {
        navigationController?.popViewController(animated: true)
        appData.newBuildingPermit(with: buildingPermit)
        tableView.reloadData()
    }
}

extension FavoritesController: UITableViewDelegate{
    
    func configureBackBarButton(_ title: String? = nil) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buildingPermitSelected = buildPermitFavoriteList[indexPath.row]
        configureBackBarButton()
        performSegue(withIdentifier: "ShowBuildingPermitDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}

extension FavoritesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.buildPermitFavoriteList[sourceIndexPath.row]
        appData.sortBuildingPermitFavorites(object: movedObject, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildPermitFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buildingPermit = buildPermitFavoriteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingPermitSummary") as? BuildingPermitSummaryCell
        cell?.configure(with: buildingPermit, at: indexPath.row)
        cell?.favoriteButton.addTarget(self, action: #selector(FavoritesController.heartTapped(_:)), for: .touchUpInside)
        return cell ?? UITableViewCell()
    }
}
