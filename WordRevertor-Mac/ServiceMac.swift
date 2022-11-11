//
//  Service.swift
//  WordRevertor
//
//  Created by Oran Levi on 31/10/2022.
//

class Service {
    
    static let shared: Service = Service()
    
    var str = ""
    
    func reversesWords(lang: [(String, String)]){
        for (searchString, lang) in lang {
            str = str.replacingOccurrences(of: searchString, with: lang).uppercased()
        }
    }
}

