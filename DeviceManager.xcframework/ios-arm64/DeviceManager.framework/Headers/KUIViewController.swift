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

open class KUIViewController: UIViewController,UIGestureRecognizerDelegate {
    
    public var navigationPopOpen:Bool = true

    open override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if navigationPopOpen{
            backAction()
        }
        return false
    }
    
    open func backAction() {
        
    }
    
    public func goBack(){
        if self.presentingViewController != nil{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    public func present(_ targetFile:UIViewController){
        targetFile.modalPresentationStyle = .fullScreen
        self.present(targetFile, animated: true)
    }
    
    public func dealWebMessage(web:WKWebView,wkMessage:WKScriptMessage,dict:[String:Any],webScripList:[String]){
        guard webScripList.count > 4 else { return }
        let name = wkMessage.name
        let kBody = "\(wkMessage.body)"
        if name == webScripList.first{
            let kData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let kJSON = String(data: kData!, encoding: String.Encoding.utf8) ?? ""
            web.evaluateJavaScript("\(webScripList[1])(\(kJSON))") { _, error in
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
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}


//MARK: - extension
public extension UIViewController {
    //Disable right swipe back gesture
    func popGestureClose() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    //Undisable the right swipe back gesture
    func popGestureOpen() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    
    func removeSelf(){
        if let navigationController = self.navigationController,
           !navigationController.viewControllers.contains(self) {
            return
        }
        if let navigationController = self.navigationController {
            navigationController.viewControllers.removeAll { $0 === self }
        }
    }
    
    static var topVC: UIViewController? {
        get {
            guard let window = UIWindow.top else { return nil }
            let rootVC = window.rootViewController
            if let tabBarVC = rootVC as? UITabBarController {
                if let navigationVC = tabBarVC.selectedViewController as? UINavigationController {
                    return navigationVC.topViewController
                } else {
                    return tabBarVC.selectedViewController
                }
            } else if let navigationVC = rootVC as? UINavigationController {
                return navigationVC.topViewController
            } else {
                return rootVC?.presentedViewController
            }
        }
    }
    
    func bePushed(hideSelf:Bool=false){
        if let navigationController = UIWindow.top?.rootViewController as? UINavigationController{
            navigationController.pushViewController(self, animated: true)
            if hideSelf,let rootVC = navigationController.viewControllers.first {
                navigationController.setViewControllers([rootVC, self], animated: true)
            }
        }
        
    }
    
}
