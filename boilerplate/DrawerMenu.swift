//
//  DrawerMenu.swift
//  boilerplate
//
//  Created by Ivan Abundis on 28/10/19.
//  Copyright © 2019 Nerdter. All rights reserved.
//www.nerdter.com

import Foundation
import UIKit
import IoniconsKit

//import RxSwift
//import RxCocoa
//
//import Firebase
//import FirebaseAuth



class MenuOption: NSObject {
    let name: String
    let imageName: Ionicons
    
    
    init(name: String, imageName: Ionicons) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel & Dismiss Completely"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

protocol perfomAction {
    func selectedRow(i:Int)
}

class SlideMenuSettings: ViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //    var delegate : Navigation?
    
    let blackView = UIView()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [MenuOption] = {
        return Store.slideMenu
    }()
    
    var homeController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        self.navigationController?.isNavigationBarHidden = true
        title = "Settings"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Store.theme.contrast
        collectionView.register(SlideMenuCell.self, forCellWithReuseIdentifier: cellId)
        showSettings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    
    func showSettings() {
        //show menu
        
        blackView.backgroundColor = Store.theme.blackGrad
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        
        view.addSubview(blackView)
        view.addSubview(collectionView)
        
        let height: CGFloat = CGFloat(settings.count) * cellHeight
        print(height)
        collectionView.anchor(top: view.topAnchor, left: view.leftAnchor,
                              bottom: view.bottomAnchor,
                              size: .init(width: view.bounds.width * 1, height: 0)
        )
        
        blackView.frame = view.frame
        blackView.alpha = 0
        self.collectionView.transform = CGAffineTransform(translationX : -400, y: 0)
        
        //        self.collectionView.transform = CGAffineTransform(translationX : -view.bounds.width, y: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:1, initialSpringVelocity:1, options: .curveEaseIn ,animations: {
            self.collectionView.transform = CGAffineTransform(translationX : 0, y: 0)
            self.blackView.alpha = 1
        }, completion: nil)
    }
    
    
    @objc func handleDismiss(_ setting: MenuOption) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.transform = CGAffineTransform(translationX : -window.bounds.width, y: 0)
            }
            self.dismissDetail()
            //            self.dismiss(animated: false, completion: nil)
            
        }) { (completed: Bool) in
            self.navigate(setting: setting)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SlideMenuCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting)
    }
    
    
    
    //    override init() {
    //
    //    }
    
}







