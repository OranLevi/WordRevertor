//
//  Service.swift
//  Reverse-Translation
//
//  Created by Oran Levi on 31/10/2022.
//

import UIKit

class Service {
    
    static let shared: Service = Service()
    
    var str = ""
    
    func reversesWords(lang: [(String, String)]){
        for (searchString, lang) in lang {
            str = str.replacingOccurrences(of: searchString, with: lang).uppercased()
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
