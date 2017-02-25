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
    
    var employees = ["Грузчик", "Электрик", "Сантехник", "Посудомойщица", "Повар", "Официант"]
    var selectedEmployee = String()
    
    var serviceName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightBarButtonItem()
        tableView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        title = serviceName
        self.tableView.tableFooterView = UIView()
    }
    
    func setRightBarButtonItem(){
        let rightItem = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(done))
        navigationItem.rightBarButtonItem = rightItem
    }
    func done(sender: UIBarButtonItem) {
        _ = self.navigationController?.popToRootViewController(animated: true)
        let userDef = UserDefaults.standard
        userDef.set(selectedEmployee, forKey: "selectedEmployee")
    }
}

extension ServiceTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: serviceCellReuseId, for: indexPath) as! ServicesTableViewCell
        cell.employeeName = employees[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell
        cell.serviceSelected = true
        selectedEmployee = employees[indexPath.row]
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell
        cell.serviceSelected = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
}





