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
    public func getEncryptInfo(withID id:String,withKey key:String,isEncrypt:Bool=true) -> String {
        let info = DeviceInfoHelper.shared.setEncryptInfo(id: id, key: key, isEncrypt: isEncrypt)
        return info
    }
    
    /// set and show home pop up picture
    public func setHomePop(withImageView popImage:UIImageView,buttonText:String,didSelect:@escaping(()->Void)){
        HomePopUpHelper.popShare.setPopUp(popImage: popImage, buttonText: buttonText, didSelect: didSelect)
    }
    
    /// customer floating  button init
    /// If it already exists, the image will be refreshed
    public func loadsCustom(with imageView:UIImageView,didClick:@escaping(()->Void)){
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
    public func getImage(vc:UIViewController,result:@escaping((_ image:UIImage)->Void)){
        PhotoPickerHelper.present(from: vc) { image in
            result(image)
        }
    }
    
    /// getContactinfo fullName phoneNumber
    public func getContact(vc:UIViewController,result:@escaping((_ fullName:String?,_ phoneNumber:String?)->Void)){
        ContactHelper.present(from: vc) { fullName, phoneNumber in
            result(fullName,phoneNumber)
        }
    }
    
    /// open  system setting page
    public func openSetting(vc:UIViewController,title:String,message:String="",buttonText:String="OK"){
        KManagerHelper.openSetting(vc: vc, title: title,message: message,buttonText: buttonText)
    }
    
    /// share source with applicationActivities
    func shareWithAppActivities(vc:UIViewController,sourceView:UIView,file: Any) {
        KManagerHelper.shareWithAppActivities(vc: vc, sourceView: sourceView, file: file)
    }

    
}

