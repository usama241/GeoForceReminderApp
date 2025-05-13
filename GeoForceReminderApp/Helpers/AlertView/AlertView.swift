//
//  AlertView.swift
//  Moody
//
//  Created by Usama on 15/06/2020.
//  Copyright © 2020 com.pyntail. All rights reserved.
//

import UIKit

class AlertView: UIView {

    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    var showArrowImg: Bool = false
    
    var onClose: ((Bool)->Void)? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    static func show(title: String, desc: String? = nil, descColor: UIColor = .ColorA5A5A5, btnYesTitle: String, btnNoTitle: String, showArrowImg: Bool = false, showSecondBtn: Bool = true, onClose: @escaping (Bool)->Void){
        
        let av : AlertView = AlertView.fromNib()
        av.lblTitle.text = title
        av.lblDesc.text = desc
        if desc == nil {
            av.lblDesc.isHidden = true
        } else {
            av.lblDesc.isHidden = false
        }
        if !showSecondBtn {
            av.btnNo.isHidden = true
        }
        av.lblDesc.textColor = descColor
        av.showArrowImg = showArrowImg
        av.btnYes.setTitle(btnYesTitle, for: .normal)
        av.btnNo.setTitle(btnNoTitle, for: .normal)
        if av.showArrowImg {
            av.btnNo.setImage(UIImage(named: "btnNextLong"), for: .normal)
        } else {
            av.btnNo.setImage(UIImage(named: ""), for: .normal)
        }
        
        av.onClose = onClose
        av.setUpUI()
        
        av.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        UIApplication.shared.keyWindow?.addSubview(av)
        
        av.vwMain.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            av.vwMain.transform = CGAffineTransform.identity
        }) { (completion) in
            
        }
    }
    
    func setUpUI(){
        setTheme()
    }
    
    func setTheme(){
        
        self.backgroundColor = .primaryColor.withAlphaComponent(0.70)
    }
    
    @IBAction func btnOkeyTapped(_ sender: Any) {
        closeView()
        onClose?(true)
    }
    
    @IBAction func btnNoTapped(_ sender: Any) {
        closeView()
        onClose?(false)
    }
    
    func closeView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: { finished in
            self.removeFromSuperview()
        })
    }
    
}
