//
//  SearchCondition.swift
//  Pokemon
//
//  Created by Masaki Sato on 2024/11/16.
//

import Foundation

struct SearchCondition {
    static var shared = SearchCondition()
    
    private let searchNameKey = "searchName"
    private let searchIDKey = "searchID"
    
    var searchName : String {
        get {
            UserDefaults.standard.string(forKey: searchNameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: searchNameKey)
        }
    }
    
    var searchID : String {
        get {
            UserDefaults.standard.string(forKey: searchIDKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: searchIDKey)
        }
    }
}
