//
//  CCHexagonViewController.swift
//  Bee
//
//  Created by Ulan on 2/3/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import CCHexagonFlowLayout

let collectionViewCellReuseId = "hexagonCell"
let collectionViewCellNibName = "CCHexagon"
let serviceTVStoryboardId = "Service"

class ServicesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,CCHexagonDelegateFlowLayout {
    
    var serviceName:String! 
    
    let icons = [Icons.deliver,Icons.beauty,Icons.cars, Icons.cleaning,
                 Icons.fixing, Icons.disinfection, Icons.master,Icons.medicine,
                 Icons.pc, Icons.science, Icons.setup,Icons.finance]
    
    let servicesName = [ServicesName.deliver, ServicesName.beauty, ServicesName.cars, ServicesName.cleaning,
                        ServicesName.fixing, ServicesName.disinfection, ServicesName.master, ServicesName.medicine,
                        ServicesName.pc,ServicesName.science,ServicesName.setup,ServicesName.finance]
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор категории"
        configureCollectionView()
    }
}

//MARK: Helper functions
extension ServicesViewController{
    fileprivate func configureCollectionView() {
        
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layoutConfiguration())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        
        let nibName = UINib(nibName: collectionViewCellNibName, bundle: nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: collectionViewCellReuseId)
        collectionView.setContentOffset(CGPoint(x: -40,y: 0), animated: false)
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        
        self.view.addSubview(collectionView)
    }
    
    fileprivate func layoutConfiguration()->UICollectionViewLayout {
        let layout = CCHexagonFlowLayout.init()
        layout.delegate = self
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.minimumInteritemSpacing = -30.0
        layout.minimumLineSpacing = CGFloat(view.bounds.width/37.5)
        layout.itemSize = CGSize(width: 160, height: 145)
        
        let modelName = UIDevice.current.modelName
        if modelName == Devices.iPhone6sPlus ||
            modelName == Devices.iPhone7Plus ||
            modelName == Devices.iPhone6Plus {
            layout.sectionInset = UIEdgeInsets(top: 40,
                                               left: view.bounds.width/6.5,
                                               bottom: 80,
                                               right: 0)
        }
        else if modelName == Devices.iPhoneSE ||
            modelName == Devices.iPhone5s ||
            modelName == Devices.iPhone5 {
            layout.sectionInset = UIEdgeInsets(top: 40,
                                               left: view.bounds.width/20,
                                               bottom: 80,
                                               right: 0)
        }else{
            layout.sectionInset = UIEdgeInsets(top: 40,
                                               left: view.bounds.width/9,
                                               bottom: 80,
                                               right: 0)
        }
        
        layout.gap = 76.0
        
        return layout
    }
}

//MARK: UICollectionViewDelegate methods
extension ServicesViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseId, for: indexPath) as! CCHexagonCollectionViewCell
        
        cell.iconImage = UIImage(named:icons[indexPath.row])
        cell.text = servicesName[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        serviceName = servicesName[indexPath.row]
        self.performSegue(withIdentifier: serviceTVStoryboardId, sender: self)
    }
}
//MARK: UIScrollViewDelegate methods
extension ServicesViewController{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtTop || scrollView.isAtBottom{
            scrollView.panGestureRecognizer.isEnabled = false
            scrollView.panGestureRecognizer.isEnabled = true
        }
    }
}

//MARK: UIStoryboardSegue methods
extension ServicesViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let serviceTVC = segue.destination as? ServiceTableViewController else {
            return
        }
        
        serviceTVC.serviceName = serviceName
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
}
