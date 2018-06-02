//
//  VSAlertController.swift
//  VSAlert
//
//  Created by Varun Santhanam on 6/1/18.
//  Copyright © 2018 Varun Santhanam. All rights reserved.
//

import UIKit

enum VSAlertControllerStyle {
    case alert
    case walkthroughAlert
    case actionSheet
}

class VSAlertController: UIViewController {
    
    public var message: String? {
        get {
            return self.messageVal
        }
    }
    
    public var image: UIImage? {
        get {
            return self.imageVal
        }
    }
    
    public var style: VSAlertControllerStyle {
        get {
            return self.styleVal
        }
    }
    
    public var dismissOnBackgroundTap: Bool = false
    
    public var alertTitleTextColor: UIColor = UIColor.black
    
    private let messageVal: String?
    private let imageVal: UIImage?
    private let styleVal: VSAlertControllerStyle
    
    private var defaultActions: Array<VSAlertAction> = []
    private var destructiveActions: Array<VSAlertAction> = []
    private var cancelActions: Array<VSAlertAction> = []
    
    private var keyboardHasBeenShown: Bool = false
    
    convenience init(title:String?, message:String?, preferredStyle:VSAlertControllerStyle) {
        
        self.init(title: title, message: message, image: nil, preferredStyle: preferredStyle)
        
    }
    
    init(title:String?, message:String?, image:UIImage?, preferredStyle:VSAlertControllerStyle) {
    
        self.messageVal = message
        self.imageVal = image
        self.styleVal = preferredStyle
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.setUpAlertController()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.messageVal = nil
        self.imageVal = nil
        self.styleVal = .alert
        super.init(coder: aDecoder)
        
    }
    
    public func addAction(_ action: VSAlertAction) {
        
    }
    
    private func setUpAlertController() {
        
        
        
    }
    
}
