//
//  NewApplication.swift
//  Bee
//
//  Created by Ulan on 3/4/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import Alamofire

class NewApplication {
    static let shared = NewApplication()
    
    func post(parameters: NSDictionary,completion: @escaping (_ response:DataResponse<Any>)->()) {
        
        let descr = parameters["description"] as! String
        let price = parameters["price"] as! String
        let address = parameters["address"] as! String
        let category = parameters["category"] as! String
        let number = parameters["number"] as! String

        let encDescr = descr.stringByAddingPercentEncodingForURLQueryParameter()
        let encPrice = price.stringByAddingPercentEncodingForURLQueryParameter()
        let encAddress = address.stringByAddingPercentEncodingForURLQueryParameter()
        let encCategory = category.stringByAddingPercentEncodingForURLQueryParameter()
        let encNumber = number.stringByAddingPercentEncodingForURLQueryParameter()

        let url = "http://176.126.167.34/get_application?description=\(encDescr)&price=\(encPrice)&address=\(encAddress)&category=\(encCategory)&number=\(encNumber)"
        Alamofire.request(url).responseJSON {
            response in
            completion(response)
        }
    }
}
