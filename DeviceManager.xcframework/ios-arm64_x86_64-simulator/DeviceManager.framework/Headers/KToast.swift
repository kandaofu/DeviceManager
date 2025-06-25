//
//   KToast.swift
//   DeviceManager
//
//   Created by Apple on 2025/6/5
//
//


import UIKit

public class KToast: NSObject {
    
    private static var hideWorkItem: DispatchWorkItem?
    private static let duration: TimeInterval = 30
    private static var activityIndicator: UIActivityIndicatorView?
    
    public static func show(_ msg:String,delay:CGFloat=1.5){
        hideLoading()
        let toastView = KToastView(title: msg,delay: delay)
        UIWindow.top?.addSubview(toastView)
    }

    public static func loading(_ duration: TimeInterval = 15,tintColor:UIColor = .white,backgroundColor:UIColor = .clear) {
        if let window = UIWindow.top{
            if let _ = window.viewWithTag(20250605) {
                resetHideTimer()
            }else{
                let loadingView = UIView.blankView(width: UIDevice.width, height: UIDevice.height,backgroundColor: backgroundColor)
                loadingView.tag = 20250605
                loadingView.isUserInteractionEnabled = true
                window.addSubview(loadingView)
                
                let showWidth:CGFloat = 80
                let showView = UIView(frame: CGRect(x: (UIDevice.width-showWidth)/2, y: (UIDevice.height-showWidth)/2, width: showWidth, height: showWidth))
                showView.backgroundColor = .black.withAlphaComponent(0.6)
                showView.setCorner(radius: 12)
                loadingView.addSubview(showView)
                
                activityIndicator = UIActivityIndicatorView(style: .large)
                showView.addSubview(activityIndicator!)
                activityIndicator?.color = tintColor
                activityIndicator?.setCenter(superView: showView)
                activityIndicator?.startAnimating()
                resetHideTimer()
                
            }
            
        }
    }
    
    
    private static func resetHideTimer() {
        hideWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            hideLoading()
        }
        hideWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: workItem)
    }
    
    public static func hideLoading() {
        activityIndicator?.stopAnimating()
        activityIndicator = nil
        if let window = UIApplication.shared.windows.first{
            if let loadingView = window.viewWithTag(20250605) {
                loadingView.removeFromSuperview()
            }
        }
        hideWorkItem?.cancel()
        hideWorkItem = nil
    }
    
}
