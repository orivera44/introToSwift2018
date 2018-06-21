//
//  AppData.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/24/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit


final class AppData {
    
    static let shared = AppData()
    
    private init() {}
    
    private var buildPermits: [BuildingPermit] = []
    
    private var buildPermitFavorites: [BuildingPermit] = []
    
}

// MARK: - Public getters

extension AppData {
    var buildPermitList: [BuildingPermit] {
        return buildPermits
    }
    
    var buildPermitFavoriteList: [BuildingPermit] {
        return buildPermitFavorites
    }
}

// MARK: - Mutating functions

extension AppData {
    
    func reloadBuildingPermit() {
        self.buildPermits.removeAll()
    }
    
    func updateBuildingPermit(with buildingPermitResponse: [BuildingPermit]?){
        guard let response = buildingPermitResponse else { return }
        self.buildPermits.append(contentsOf: response)
    }
    
    func setFavoriteBuildingPermit(){

            for savedBuildingPermit in buildPermitFavoriteList {
                if let row = self.buildPermits.index(where: {$0.buildingPermitId == savedBuildingPermit.buildingPermitId}) {
                    buildPermits[row].favorite = true
                }
            }
    }
    
    
    func retrieveBuildingPermitFavorites(){
        if StorageManage.fileExists("messages.json", in: .documents) {
            let savedBuildingPermitFavorites = StorageManage.retrieve("messages.json", from: .documents, as: [BuildingPermit].self)
            for var buildingPermitFavorite in savedBuildingPermitFavorites{
                buildingPermitFavorite.favorite = true
                buildPermitFavorites.append(buildingPermitFavorite)
            }
        }
    }
    
    
    func sortBuildingPermitFavorites(object toMove: BuildingPermit,  moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        buildPermitFavorites.remove(at: sourceIndexPath.row)
        buildPermitFavorites.insert(toMove, at: destinationIndexPath.row)
        saveBuildingPermitFavorites()
    }
    
    func saveBuildingPermitFavorites() {
        StorageManage.store(buildPermitFavoriteList, to: .documents, as: "messages.json")
    }
    
    func updateBuildingPermitByRow(with indexRow: Int) {
        self.buildPermits[indexRow].favorite = !self.buildPermits[indexRow].favorite
        if self.buildPermits[indexRow].favorite {
            self.buildPermitFavorites.append(self.buildPermits[indexRow])
        }else{
            if let row = self.buildPermitFavorites.index(where: {$0.buildingPermitId == buildPermits[indexRow].buildingPermitId}) {
                buildPermitFavorites.remove(at: row)
            }
        }
        saveBuildingPermitFavorites()
    }
    
    func updateBuildingPermitFavoriteByRow(with indexRow: Int) {
        if let row = self.buildPermits.index(where: {$0.buildingPermitId == buildPermitFavorites[indexRow].buildingPermitId}) {
            buildPermits[row].favorite = !buildPermits[row].favorite
        }
        buildPermitFavorites.remove(at: indexRow)
        saveBuildingPermitFavorites()
    }
    
}
