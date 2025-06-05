#** DeviceManager

 -- Make it easier to obtain device information and make coding easier


##** DeviceHelper

  - getEncryptInfo: Get encrypted device information

  - setHomePop: Set the home pop-up box

  - loadsCustom: Set the global customer service floating button
  - customShow: Show the customer service button
  - customHide: Hide the customer service button


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

