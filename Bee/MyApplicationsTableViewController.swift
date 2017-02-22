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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Мои заявки"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        tabBarController?.navigationItem.backBarButtonItem = backItem
    }
}

//MARK: UITableViewDelegate methods 

extension MyApplicationsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: myApplicationViewCellReuseId, for: indexPath) as! MyApplicationTableViewCell
        
        cell.serviceName = "Мастер на вызов"
        cell.employeeName = "Сантехник"
        cell.cost = "1300 сом"
        
        tableView.separatorStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: descriptionViewControllerStoryboardId, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Вчера"
    }
}
