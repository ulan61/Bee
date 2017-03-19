//
//  MyApplicationsTableViewController.swift
//  Bee
//
//  Created by Ulan on 2/4/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

let myApplicationViewCellReuseId = "myApplication"
let descriptionViewControllerStoryboardId = "Description"

class MyApplicationsTableViewController: UITableViewController {
    
    var address: String!
    
    var telephoneNumber: String!
    
    var serviceDescription: String!
    
    var objects: Array<Dictionary<String,AnyObject>> = []{
        didSet{
            updateUI()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        self.tabBarController?.navigationItem.title = "Мои заявки"
        self.tableView.tableFooterView = UIView()
        guard Internet.isAvailable() else {
            return
        }
        MyApplications.shared.getApplications(){ [unowned self] json in
            
            guard let optJson = json else{
                AlertView.shared.show(in: self, withTitle: "Ошибка", subtitle: "Ошибка на сервере", buttonTitle: "OK")
                return
            }
            
            self.objects = optJson["objects"] as! Array<Dictionary<String, AnyObject>>
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        guard Internet.isAvailable() else {
            AlertView.shared.show(in: self, withTitle: "Соединение отсутствует", subtitle: "Убедитесь, что вы подключены к интернету", buttonTitle: "OK")
            self.objects = []
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let descrVC = segue.destination as? DescriptionViewController else {
            return
        }
        descrVC.address = address
        descrVC.telephoneNumber = telephoneNumber
        descrVC.serviceDescription = serviceDescription
        setBackItem()
    }
}

//MARK: Helper functions 

extension MyApplicationsTableViewController{
    fileprivate func updateUI(){
        self.tableView.reloadData()
    }
    
    fileprivate func setBackItem(){
        let backItem = UIBarButtonItem()
        backItem.title = ""
        tabBarController?.navigationItem.backBarButtonItem = backItem
    }
}

//MARK: UITableViewDelegate methods 

extension MyApplicationsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myApplicationViewCellReuseId, for: indexPath) as! MyApplicationTableViewCell
        tableView.separatorStyle = .none
        guard let category = objects[indexPath.row]["category"] as? Dictionary<String, AnyObject> else{
            return cell
        }
        cell.serviceName = category["name"] as! String
        cell.cost = objects[indexPath.row]["price"] as! String!
        let isActive = objects[indexPath.row]["active"] as! Bool
        guard isActive else {
            cell.employeeName = "В ожидании"
            return cell
        }
        cell.employeeName = "Выполняется"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        address = objects[indexPath.row]["address"] as! String
        telephoneNumber = objects[indexPath.row]["number"] as! String
        serviceDescription = objects[indexPath.row]["description"] as! String
        self.performSegue(withIdentifier: descriptionViewControllerStoryboardId, sender: self)
    }
}
