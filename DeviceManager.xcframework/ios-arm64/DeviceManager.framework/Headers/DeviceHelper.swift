//
//   DeviceHelper.swift
//   DeviceManager
//
//   Created by Apple on 2024/6/1
//
//
   
import Foundation
import UIKit

public class DeviceHelper: NSObject {
    
    public static let shared = DeviceHelper()

    /// get device info encrypt
    public func getEncryptDeviceInfo(withIV iv:String,ia:String="",withKey key:String) -> String {
        let info = DeviceInfoHelper.shared.setEncryptInfo(iv: iv,ia: ia, key: key)
        return info
    }
    
    /// set and show home pop up picture
    public func setHomePop(withImageView popImage:UIImageView,buttonText:String,didSelect:@escaping(()->Void)){
        HomePopUpHelper.popShare.setPopUp(popImage: popImage, buttonText: buttonText, didSelect: didSelect)
    }
    
    /// customer floating  button init
    /// If it already exists, the image will be refreshed
    public func setCustom(with imageView:UIImageView,didClick:@escaping(()->Void)){
        CustomerHelper.shared.loadsCustom(with: imageView, didClick: didClick)
    }
    
    /// show customer floating  button
    public func customShow(){
        CustomerHelper.shared.customerView?.show()
    }
    
    /// hide customer floating  button
    public func customHide(){
        CustomerHelper.shared.customerView?.hide()
    }
    
    
    /// getImage form picker
    public func getImage(inViewController vc:UIViewController,result:@escaping((_ image:UIImage)->Void)){
        PhotoPickerHelper.present(from: vc) { image in
            result(image)
        }
    }
    
    /// getContactinfo fullName phoneNumber
    public func getContact(inViewController vc:UIViewController,result:@escaping((_ fullName:String?,_ phoneNumber:String?)->Void)){
        ContactHelper.shared.present(from: vc) { fullName, phoneNumber in
            result(fullName,phoneNumber)
        }
    }
    
    /// open  system setting page
    public func setSettingAlert(inViewController vc:UIViewController,title:String,message:String="",buttonText:String="OK"){
        KManagerHelper.openSetting(vc: vc, title: title,message: message,buttonText: buttonText)
    }
    

    /// check Camera authorizationStatus
    public func checkCamera(title:String="",message:String="Please enable camera access in Settings",buttonText:String="OK",authorizedBlock:@escaping(()->Void)){
        PrivacyHelper.shared.checkCamera(title: title, message: message, buttonText: buttonText, authorizedBlock: authorizedBlock)
    }
    
    /// check Location authorizationStatus
    public func checkLocation(title:String="",message:String="Allow location access to help verify your details and protect your account.",buttonText:String="OK",authorizedBlock:@escaping(()->Void)){
        PrivacyHelper.shared.checkLocation(title: title, message: message, buttonText: buttonText, authorizedBlock: authorizedBlock)
    }
    
}

