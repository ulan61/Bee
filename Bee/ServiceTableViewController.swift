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
    
    var serviceName:String!
    
    var indexPathOfSelectedCell: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        title = serviceName
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: serviceCellReuseId, for: indexPath) as! ServicesTableViewCell
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell
        
        indexPathOfSelectedCell = indexPath
        deselectPreviousCell(at: indexPath)
        cell.serviceSelected = true
        
//        _ = self.navigationController?.popToRootViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ServicesTableViewCell
        cell.serviceSelected = false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
//MARK: Helper functions
extension ServiceTableViewController {
    func deselectPreviousCell(at indexPath: IndexPath) {
        if indexPath != indexPathOfSelectedCell{
            let previousSelectedCell = tableView.cellForRow(at: indexPathOfSelectedCell) as! ServicesTableViewCell
            previousSelectedCell.serviceSelected = false
        }
    }
}
