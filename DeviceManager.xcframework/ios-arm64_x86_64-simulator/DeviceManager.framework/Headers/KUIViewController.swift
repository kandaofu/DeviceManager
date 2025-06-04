//
//   KUIViewController.swift
//   DeviceManager
//
//   Created by Apple on 2025/6/4
//   
//
   

import UIKit
import WebKit
import StoreKit

public class KUIViewController: UIViewController,UIGestureRecognizerDelegate {
    
    public var navigationPopOpen:Bool = true

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if navigationPopOpen{
            back()
        }
        return false
    }
    
    public func back() {
        
    }
    
    public func backAction(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    public func dealWebMessage(web:WKWebView,wkMessage:WKScriptMessage,dict:[String:Any],webScripList:[String]){
        let name = wkMessage.name
        let kBody = "\(wkMessage.body)"
        if name == webScripList.first{
            let kData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let kJSON = String(data: kData!, encoding: String.Encoding.utf8) ?? ""
            web.evaluateJavaScript("\(name)(\(kJSON))") { _, error in
                print(String(format: "%@ error: %@", name, error?.localizedDescription ?? ""))
            }
        }else if name.contains(webScripList[2]){
            if let phone = URL(string: "tel:\(kBody)") {
                UIApplication.shared.open(phone)
            }
        }else if name == webScripList[3]{
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }else if name.contains(webScripList[4]){
            if #available(iOS 14.0, *){
                if  let kWinds = self.view.window?.windowScene {
                    SKStoreReviewController.requestReview(in: kWinds)
                }
            }else{
                SKStoreReviewController.requestReview()
            }
        }else if name == webScripList.last{
            if let url = URL(string: kBody) {
                UIApplication.shared.open(url)
            }
        }
     
    }

}

