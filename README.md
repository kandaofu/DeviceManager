#** DeviceManager

 -- Make it easier to obtain device information and make coding easier


##** DeviceHelper

  - getEncryptInfo: Get encrypted device information
  - getDeviceParams: Get unencrypted device information dictionary

  - setHomePop: Set the home pop-up box

  - setCustom: Set the global customer service floating button
  - customShow: Show the customer service button
  - customHide: Hide the customer service button
  
  - getImage: Pull up the album camera to get the picture
  - getContact: Get the contact name and phone number selected by the user
  
  - setSettingAlert: Open the system settings page
  - setShareAppActivities: Share file resources to external
  
  - checkCamera: Request camera permission, callback if successful, jump to pop-up window if failed
  - checkLocation: Request location permission, callback if successful, jump to pop-up window if failed


##** LocationManager
 - LocationManager.shared
 
 - initKey (Required)
 
 - requestLocationState: request location permission
 
 - getLocationInfo
   *\get location information (needs to be initKey)
 
   
##** CountdownTimer

eg: 
* var timer:CountdownTimer?
* timer = CountdownTimer(delegate: self)

  - startCountdown
  *\Enter the start time in seconds and start the countdown
  
  - stop: Active stop
  
  #### CountdownDelegate
  - countdownDidUpdate(hourSting: String, minuteSting: String, secondSting: String)
  - countdownDidUpdate(hourInt: Int, minuteInt: Int, secondInt: Int)
  - countdownDidFinish
  
  
##** KUIViewController

The custom UIViewController class contains the property navigationPopOpen: whether to enable right swipe back. default is true. 
You need to actively override the back() method to implement the method after swiping right. 
Alternatively, you can directly call backAction() under the back() method to implement dismiss or popViewController.

  - back

  - backAction

  - dealWebMessage(web: WKWebView, wkMessage: WKScriptMessage, dict: [String : Any], webScripList: [String]) 
  *\ Handling WKScriptMessage, custom events
  
  
##** KTextField

 - onDeleteBackward: Listening for delete actions
 
 var placeHolderColor: Extended setting placeHolderColor
 

##** KToast

 - show
 
 - loading
 
 - hideLoading
 
 
 ##** KTableViewCell
 
 *\ Enable custom mailbox completion popup view
 
  - setEmailFiled: 
    - contentTextFiled: UITextField?
    - emailFootterArray:[String] = ["@gmail.com", "@icloud.com", "@yahoo.com", "@outlook.com"]
    - emailViewCorner:CGFloat = 4
    - cellEmailOffsetX:CGFloat = 72
    - emailButtonHeight:CGFloat = 48
    - emailButtonLeftMargin:CGFloat = 14
    - emailButtonAttrColor:UIColor?
    - emailButtonTextColor:UIColor = .black
    - emailButtonFirstColor:UIColor = .blue
    - emailButtonFont:UIFont = UIFont(name: "PingFangSC-Medium", size: 13)!
    - emailButtontitleLeft:CGFloat = 12
    - emailHasLine:Bool = true
    - emailLineColor:UIColor = UIColor(hex: "#EEF0F4")
    - didEndFill:(_ text:String) -> Void = {_  in}
    


