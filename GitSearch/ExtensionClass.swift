//
//  Repository.swift
//  GitSearch
//
//  Created by Jonas Boateng on 30/03/2018.
//  Copyright © 2018 Jonas Boateng. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    convenience init(activityIndicatorStyle: UIActivityIndicatorViewStyle, placeInTheCenterOf parentView: UIView) {
        self.init(activityIndicatorStyle: activityIndicatorStyle)
        center = parentView.center
        self.color = UIColor(red:1.00, green:0.427 ,blue:0 , alpha:1.00);
        self.hidesWhenStopped = true
        parentView.addSubview(self)
    }
}

extension UIColor{
    class func getCustomColor() -> UIColor
    {
        //255,109,0 - RGBA of colour used
        return UIColor(red:1.00, green:0.427 ,blue:0 , alpha:1.00)
    }
    
    func getNameofColour() ->String
    {
        return "gitOrange"
    }
}

extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

extension Array where Element: Equatable {
    mutating func removeObject(object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object: object)
        }
    }
}
