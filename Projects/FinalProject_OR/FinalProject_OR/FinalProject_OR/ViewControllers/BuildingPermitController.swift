//
//  BuildingPermitController.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/20/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit

class BuildingPermitController: UIViewController {
    
    let queryService = QueryServices()
    let appData = AppData.shared
    var buildPermitList: [BuildingPermit]{
        return appData.buildPermitList
    }

    var buildingPermitSelected: BuildingPermit!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "cargando...")
            refreshControl.addTarget(self, action:  #selector(refresh), for: UIControlEvents.valueChanged)
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
        appData.reloadBuildingPermit()
        tableView.reloadData()
        loadBuildingPermit(with: true)
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBuildingPermit(with: false)
        appData.retrieveBuildingPermitFavorites()
        configureNavigationController("Permisos")
        
        let filterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filternav"), style: .plain, target: self, action: #selector(filterTapped(_:)))
        navigationItem.rightBarButtonItem = filterButton
        navigationItem.rightBarButtonItem?.tintColor = .white
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.layoutIfNeeded()
        tableView.reloadRows(at: tableView.indexPathsForVisibleRows!, with: UITableViewRowAnimation.none)
    }

    private func loadBuildingPermit(with reloadData: Bool!) {
        if reloadData {
            queryService.offset = 0
        }
        queryService.fetchBuildingPermit { [weak self] (_, _) in
            self?.appData.setFavoriteBuildingPermit()
            self?.tableView.reloadData()
        }
    }
    
    @objc func filterTapped(_ sender: UIButton) {
        queryService.isFiltered = !queryService.isFiltered
        appData.reloadBuildingPermit()
        self.loadBuildingPermit(with: true)
    }
    
    @objc func heartTapped(_ sender: UIButton) {
        appData.updateBuildingPermitByRow(with: sender.tag)
        let indexPath = IndexPath(row: sender.tag, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBuildingPermitDetail" {
            let buildingPermitDetailVC = segue.destination as! DetailViewController
            buildingPermitDetailVC.buildingPermit = buildingPermitSelected
        }
    }
}

extension BuildingPermitController: UITableViewDelegate{
    
    func configureBackBarButton(_ title: String? = nil) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buildingPermitSelected = buildPermitList[indexPath.row]
        configureBackBarButton()
        performSegue(withIdentifier: "ShowBuildingPermitDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let totalBuildingPermitCount = buildPermitList.count
        let currentRow = indexPath.row
        if (totalBuildingPermitCount - 1) == currentRow {
            self.loadBuildingPermit(with: false)
        }
    }
}

extension BuildingPermitController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildPermitList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let buildingPermit = buildPermitList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingPermitSummary") as? BuildingPermitSummaryCell
        cell?.configure(with: buildingPermit, at: indexPath.row)
        cell?.favoriteButton.addTarget(self, action: #selector(BuildingPermitController.heartTapped(_:)), for: .touchUpInside)
        return cell ?? UITableViewCell()
    }
    
}
