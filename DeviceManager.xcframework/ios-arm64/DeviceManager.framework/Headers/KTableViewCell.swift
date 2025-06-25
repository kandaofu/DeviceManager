//
//   KTableViewCell.swift
//   DeviceManager
//
//   Created by Apple on 2025/6/6
//   
//
   

import UIKit

open class KTableViewCell: UITableViewCell,UITextFieldDelegate {
    
    open var contentTextFiled: UITextField?
    public var emailFootterArray:[String] = ["@gmail.com", "@icloud.com", "@yahoo.com", "@outlook.com"]
    public var emailViewCorner:CGFloat = 4
    public var cellEmailOffsetX:CGFloat = 72
    public var emailButtonHeight:CGFloat = 48
    public var emailButtonLeftMargin:CGFloat = 14
    public var emailButtonAttrColor:UIColor?
    public var emailButtonTextColor:UIColor = .black
    public var emailButtonFirstColor:UIColor = .blue
    public var emailButtonFont:UIFont = UIFont(name: "PingFangSC-Medium", size: 13)!
    public var emailButtontitleLeft:CGFloat = 12
    public var emailHasLine:Bool = true
    public var emailLineColor:UIColor = UIColor(hex: "#EEF0F4")
    public var didEndFill:(_ text:String) -> Void = {_  in}
    
    private var isEmailFiled:Bool = false
    private var superTable: UITableView?
    
    private lazy var emailSelectView:UIView = {
        let emailSelectView = UIView(frame: CGRect(x: emailButtonLeftMargin, y: 0, width: UIDevice.width-emailButtonLeftMargin*2, height: emailButtonHeight*4))
        emailSelectView.backgroundColor = .white
        emailSelectView.setCorner(radius: emailViewCorner)
        emailSelectView.setShadow(UIColor(hex: "#0B2C04"),opacity: 0.15)
        return emailSelectView
    }()
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    open func setEmailFiled(textFiled:UITextField,tableView:UITableView){
        self.contentTextFiled = textFiled
        self.superTable = tableView
        self.isEmailFiled = true
        self.contentTextFiled?.delegate = self
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        emailSelectView.isHidden = true
        didEndFill(textField.text ?? "")
    }

    open func textFieldDidBeginEditing(_ textField: UITextField) {
        if isEmailFiled,let superTable = superTable{
            self.scrollTop()
            showEmailSelectView(inputTextString: textField.text ?? "")
        }
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isEmailFiled{
            let inputTextString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
            showEmailSelectView(inputTextString: inputTextString)
        }
        return true
    }
    
    private func showEmailSelectView(inputTextString:String){
        guard inputTextString.count > 0,let superTable = superTable else {
            emailSelectView.isHidden = true
            return
        }
        let formatterTextString = inputTextString.replacingOccurrences(of: " ", with: "")
        let inputPartArray = formatterTextString.split(separator: "@").map { String($0) }
        
        var fixResultList: [String] = []
        
        if inputPartArray.count == 1 {
            fixResultList = emailFootterArray
        } else if inputPartArray.count == 2 {
            fixResultList = emailFootterArray.filter { $0.hasPrefix("@\(inputPartArray[1])") }
        } else {
            emailSelectView.isHidden = true
            return
        }
        
        if fixResultList.isEmpty {
            emailSelectView.isHidden = true
            return
        }
        
        let sizeInConvert = superTable.convert(self.frame, to: self.superview)
        emailSelectView.frame = CGRect(x: emailButtonLeftMargin, y: sizeInConvert.origin.y + cellEmailOffsetX, width: UIDevice.width-2*emailButtonLeftMargin, height: CGFloat(fixResultList.count)*emailButtonHeight)
        emailSelectView.isHidden = false
        emailSelectView.setCorner(radius: emailViewCorner)
        if let indexPath = superTable.indexPath(for: self){
            superTable.scrollToRow(at: indexPath, at: .top, animated: true)
        }else{
            superTable.setContentOffset(CGPoint(x: 0, y: sizeInConvert.origin.y - self.h), animated: true)
        }
        
        if superTable.subviews.contains(emailSelectView) == false {
            superTable.addSubview(emailSelectView)
        }
        
        emailSelectView.subviews.forEach { sbus in
            sbus.removeFromSuperview()
        }
        
        for (index, buttonText) in fixResultList.enumerated() {
            let resultShowText = inputPartArray[0] + buttonText
            let emailButton = UIButton(type: .custom)
            emailButton.titleLabel?.font = emailButtonFont
            emailButton.frame = CGRect(x: 0, y: CGFloat(index) * emailButtonHeight, width: emailSelectView.w, height: emailButtonHeight)
            emailButton.text = resultShowText
            emailButton.contentHorizontalAlignment = .left
            emailButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: emailButtontitleLeft, bottom: 0, right: 0)
            emailButton.addTarget(self, action: #selector(emailButtonClick(_ :)), for: .touchUpInside)
            
            if let emailButtonAttrColor = emailButtonAttrColor{
                emailButton.setAfterTitle(color: emailButtonAttrColor)
            }else{
                if fixResultList.count == 1 || index == 0{
                    emailButton.setTitleColor(emailButtonFirstColor, for: .normal)
                }else{
                    emailButton.setTitleColor(emailButtonTextColor, for: .normal)
                }
            }
            
            emailSelectView.addSubview(emailButton)
            if index != 0 && emailHasLine{
                let lineView = UIView(frame: CGRect(x: emailButtontitleLeft, y: CGFloat(index) * emailButtonHeight, width: emailSelectView.w-emailButtontitleLeft*2, height: 1))
                lineView.backgroundColor = emailLineColor
                emailSelectView.addSubview(lineView)
            }
        }
           
    }
    
    @objc private func emailButtonClick(_ sender:UIButton){
        if let title = sender.title(for: .normal){
            contentTextFiled?.text = title
            contentTextFiled?.resignFirstResponder()
        }
    }
    
    
}

public extension UITableViewCell {
    func indexPath(in tableView: UITableView? = nil) -> IndexPath? {
        let tableView = tableView ?? findTableView()
        return tableView?.indexPath(for: self)
    }

    func findTableView() -> UITableView? {
        var view = self.superview
        while let currentView = view {
            if let tableView = currentView as? UITableView {
                return tableView
            }
            view = currentView.superview
        }
        return nil
    }
    
    func scrollNext(){
        if let superTable = self.findTableView(),let indexPath = self.indexPath(in: superTable){
            var newIndexPath = indexPath
            if newIndexPath.row > 0{
                newIndexPath.row = indexPath.row - 1
            }
            superTable.scrollToRow(at: newIndexPath, at: .top, animated: true)
        }
        
    }
    
    func scrollTop(){
        if let superTable = self.findTableView(){
            let sizeInConvert = superTable.convert(self.frame, to: self.superview)
            superTable.setContentOffset(CGPoint(x: 0, y: sizeInConvert.origin.y - self.h), animated: true)
        }
        
    }
    
}
