//
//  myApplications.swift
//  Bee
//
//  Created by Ulan on 2/27/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import Alamofire

class MyApplications {
    static let shared = MyApplications()
    
    func getApplications(completion: @escaping (_ json: Dictionary<String, AnyObject>?) -> ())  {
        let applicationUrl = "http://176.126.167.34/api/v1/application/?format=json"
        Alamofire.request(applicationUrl).responseJSON { response in
            if let json = response.result.value {
                completion(json as? Dictionary<String, AnyObject>)
            }
        }
    }
}
