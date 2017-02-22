//
//  ServiceTableViewController.swift
//  Bee
//
//  Created by Ulan on 2/9/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

let serviceCellReuseId = "serviceCell"

class ServiceTableViewController: UITableViewController {
    
    var employeeNames = ["Грузчик", "Электрик", "Сантехник", "Посудомойщица", "Повар", "Официант"]
    
    var serviceName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        title = serviceName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return employeeNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: serviceCellReuseId, for: indexPath) as! ServicesTableViewCell
        
        cell.employeeName = employeeNames[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell

        cell.serviceSelected = true
        
//        _ = self.navigationController?.popToRootViewController(animated: true)

    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell
        cell.serviceSelected = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 60
    }
}



//        _ = self.navigationController?.popToRootViewController(animated: true)


