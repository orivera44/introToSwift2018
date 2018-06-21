//
//  QueryServices.swift
//  FinalProject_OR
//
//  Created by Oscar Rivera on 5/24/18.
//  Copyright © 2018 Oscar Rivera. All rights reserved.
//

import UIKit
import Alamofire

enum APIResourceURL: String {
    case pemas = "rirx-ji6t.json"

    static let baseURL = "https://data.pr.gov/resource/"
    
    var url: String {
        return APIResourceURL.baseURL + self.rawValue
    }
}

class QueryServices {
    
    typealias JSONDictionary = [String: Any]
    typealias SuccessResult = (Bool, String) -> ()
    
    let appData = AppData.shared
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var dataTasks = [URLSessionDataTask]()
    var isFiltered: Bool = false
    var nextPageURL: String?
   
    var errorMessage = ""
    
    var nextURLString: String {
        return (nextPageURL != nil) ? nextPageURL! + paginationURLSection + filterURLSection : APIResourceURL.pemas.url + paginationURLSection + filterURLSection
    }
    
    let limit: Int = 15
    var offset: Int = 0
    
    var paginationURLSection: String {
        
        let nextPage = "?$limit=\(limit)&$offset=\(self.offset)"
        self.offset = (offset+limit)
        return nextPage
    }
    
    var filterURLSection: String {
        if isFiltered {
            return "&adjudicado_o_pendiente=Pendiente"
        }
        return ""
    }
}

extension QueryServices {
    
    func fetchBuildingPermit(completion: @escaping SuccessResult) {
        Alamofire.request(nextURLString).responsePropertyList { (response) in
            let didUpdateBuildingPermit = self.updateBuildingPermitResults(response)
            completion(didUpdateBuildingPermit, self.errorMessage)
        }
    }
    
}

extension QueryServices {
    
    private func updateBuildingPermitResults(_ response: DataResponse<Any>) -> Bool{
        guard let data = response.data else { return false }
        
        if let buildPermitResponse = convertData(to: [BuildingPermit].self, data){
            appData.updateBuildingPermit(with: buildPermitResponse)
            return true
        } else {
            return false
        }
    }
    
}

extension QueryServices {
    
    private func convertData<T:Decodable>(to type: T.Type, _ data: Data) -> T? {
        let decoder = JSONDecoder()
        return try! decoder.decode(type, from: data)
    }
    
}

