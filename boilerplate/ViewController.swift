//
//  ViewController.swift
//  boilerplate
//
//  Created by Ivan Abundis on 28/10/19.
//  Copyright © 2019 Nerdter. All rights reserved.
//  www.nerdter.com

import UIKit

class ViewController: UIViewController {
    
    //    MARK:DECLARE COMPONENTS
    
    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let logoView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.image = #imageLiteral(resourceName: "logo-s2-white2x")
        return view
    }()
    
    var titleLabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Sweet BoilerPlate 👽"
        self.edgesForExtendedLayout = []
        
        navigationController?.navigationBar.isTranslucent = Store.navigationBar
        view.backgroundColor = Store.theme.primary
        view.addSubview(infoView)
        view.addSubview(logoView)

        
        
        preparaUI()
    
    }
    //    MARK: FUNCTIONS
    
    func preparaUI(){
        logoView.anchor(top:view.topAnchor,left:nil, bottom:nil, right:nil,  padding: .init(top: 10, left: 0, bottom: 0, right: 0),
                        centerX:view.centerXAnchor, size: .init(width: 180, height: 60))
        
        infoView.anchor(top:nil,left:nil, bottom:nil, right:nil,  padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                        centerX:view.centerXAnchor,centerY: view.centerYAnchor, size: .init(width: 280, height: 160))
        
        infoView.backgroundColor = Store.theme.secondaryGrad
        
        
        setupNavBarButtons()
    
    }
    
    
    
    func setupNavBarButtons() {
        
        titleLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Sweet BoilerPlate 👽"
        titleLabel.textColor = Store.theme.secondary
        titleLabel.font = UIFont.systemFont(ofSize: 20)
//        self.tabBarController?.
        navigationItem.titleView = titleLabel
        
        let menuButton = UIBarButtonItem(image: UIImage.ionicon(with: .androidMenu, textColor: Store.theme.secondary, size: CGSize(width: 30, height: 30)).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(handleMore))

        let button = UIButton()
        button.setImage(UIImage.ionicon(with: .iosInformation, textColor: Store.theme.secondary, size: CGSize(width: 30, height: 30)), for: .normal)
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 30, height: 30)

        let addTransactionButton = UIBarButtonItem(customView: button)
//        self.tabBarController?.
        navigationItem.rightBarButtonItems = [menuButton, addTransactionButton]
        
        
        navigationController?.navigationBar.barTintColor = Store.theme.ternary
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    @objc func handleMore() {
        let modalViewController = SlideMenuSettings()
        modalViewController.modalPresentationStyle = .overFullScreen
        presentDetail(modalViewController)

    }
    @objc func add(){
        
    }
    
    func navigate(setting:MenuOption) {
        if setting.name != "Cancel" {
            self.tabBarController?.selectedIndex = 1
        }
        if setting.name == "Logout" {
            print("🔥")
            
        }
    }

}




