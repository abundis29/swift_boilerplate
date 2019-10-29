//
//  Theme.swift
//  boilerplate
//
//  Created by Ivan Abundis on 28/10/19.
//  Copyright © 2019 Nerdter. All rights reserved.
//

import Foundation
import UIKit



class Store: NSObject {
    static var inital: String = ""
    static var selectedAccount: String = ""
    static var categoryData: [String] = [String]()
    static var navigationBar:Bool = false
    
    
    static var slideMenu:[MenuOption] = [
        MenuOption(name: "Cancel", imageName: .androidCancel),
        MenuOption(name: "Logout", imageName: .logOut)
        
    ]
    
    
    struct theme {
        static let primary = UIColor(8,8,9,1)
        static let secondary = UIColor(255,255,255,1)
        static let secondaryGrad = UIColor(255,255,255,0.5)
        static let ternary = UIColor(37,32,55,1)
        static let red = UIColor(35, 14, 11, 0.9)
        static let primaryGrad = UIColor(240,135,114,0.3)
        static let primaryGradient = UIColor(8,8,9,0.3)
        static let blackGrad = UIColor(0,0,0,0.3)
        static let contrast = UIColor(30,25,47,1)
        static let gradientBlack = UIColor(0,0,0,0.5)
        static let warning = UIColor(238, 211, 69,1)
        static let blue = UIColor(66, 141, 195,1)
        static let alert = UIColor(236, 114, 108,1)
        static let danger = UIColor(217, 76, 93,1)
        static let success = UIColor(154, 184, 46,1)
        static let orange = UIColor(228, 119, 61,1)
        static let darkGreen = UIColor(4, 36, 23, 1)
        static let green = UIColor(61, 208, 153, 1)
    }
    
    deinit {
        print("")
    }
    
}

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a:CGFloat){
        self.init(displayP3Red: r/255, green: g/255,blue: b/255, alpha: a)
    }
}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}


extension UIView {
    
    func anchor(top:NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                centerX:NSLayoutXAxisAnchor? = nil,
                centerY:NSLayoutYAxisAnchor? = nil,
                size: CGSize = .zero,
                widthA:NSLayoutDimension? = nil,
                heightA:NSLayoutDimension? = nil,
                centerPadding:CGFloat?=nil){
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: padding.left).isActive = true
        }
        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: padding.top).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant:padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant:padding.bottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant:padding.right).isActive = true
        }
        
        if let widthA = widthA {
            widthAnchor.constraint(equalTo: widthA).isActive = true
            if centerPadding != 0 {
                widthAnchor.constraint(equalTo: widthA, constant:centerPadding ?? 0).isActive = true
            }
        }
        if let heightA = heightA {
            heightAnchor.constraint(equalTo: heightA).isActive = true
        }
        //        Mark: Specific Size
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
    }
}

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: false, completion: nil)
        
        
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}




extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
            
        }).resume()
    }
    
}


//Global variables
struct GlobalVariables {
    static let blue = UIColor.rbg(r: 129, g: 144, b: 255)
    static let purple = UIColor.rbg(r: 161, g: 114, b: 255)
}

//Extensions
extension UIColor{
    class func rbg(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.height / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

//Enums
enum ViewControllerType {
    case welcome
    case conversations
}

enum PhotoSource {
    case library
    case camera
}

enum ShowExtraView {
    case contacts
    case profile
    case preview
    case map
}

enum MessageType {
    case photo
    case text
    case location
}

enum MessageOwner {
    case sender
    case receiver
}

