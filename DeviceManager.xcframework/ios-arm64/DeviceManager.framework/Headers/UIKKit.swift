//
//   UIKKit.swift
//   DeviceManager
//
//   Created by Apple on 2025/6/4
//   
//
   

import UIKit

//MARK: - UIView
public extension UIView{
    
    static func blankView(width:CGFloat  = UIDevice.width,height:CGFloat = UIDevice.height,backgroundColor:UIColor = .clear) ->UIView{
        let blankView = UIView()
        blankView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        blankView.backgroundColor = backgroundColor
        return blankView
    }
    
    func addGradient(startPoint:CGPoint = CGPoint(x: 0.5, y: 0),endPoint:CGPoint = CGPoint(x: 0.5, y: 1),colors:[UIColor]){
        self.removeAllLayers()
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeAllLayers(){
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
    }
    
}

//MARK: - CGFloat
public extension CGFloat{
    
    var intValue:Int{
        return Int(self)
    }
    
    var stringValue:String{
        return String(format: "%.f", self)
    }
    
    func kScale() ->CGFloat{
        return UIScreen.main.bounds.size.width/375*self
    }
    
}

//MARK: - Int
public extension Int{
    
    var stringValue:String{
        return String(format: "%ld", self)
    }
    
}

public extension Int64{
    
    var stringValue:String{
        return String(format: "%ld", self)
    }
    
}

public extension UInt64{
    
    var stringValue:String{
        return String(format: "%ld", self)
    }
    
}

//MARK: - String
public extension String{
    
    
    
}

//MARK: - UIFont
extension UIFont{
    static func pingFangSC_regular(_ size:CGFloat) ->UIFont{
        return UIFont(name: "PingFangSC-Regular", size: size)!
    }
    
    static func pingFangSC_medium(_ size:CGFloat) ->UIFont{
        return UIFont(name: "PingFangSC-Medium", size: size)!
    }
    
    static func pingFangSC_semibold(_ size:CGFloat) ->UIFont{
        return UIFont(name: "PingFangSC-Semibold", size: size)!
    }
    
}

//MARK: - UIColor
public extension UIColor{
    static func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat = 1.0) ->UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
        
        var hexValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&hexValue)
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        
        switch hex.count {
        case 3:
            r = CGFloat((hexValue & 0xF00) >> 8) / 15.0
            g = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
            b = CGFloat(hexValue & 0x00F) / 15.0
        case 6:
            r = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(hexValue & 0x0000FF) / 255.0
        default:
            self.init(white: 0, alpha: 0)
            return
        }
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    
}

//MARK: - UIWindow
public extension UIWindow{
    
    static var top:UIWindow?{
        return UIApplication.shared.windows.first
    }
    
}

class UIKKit: NSObject {

}

