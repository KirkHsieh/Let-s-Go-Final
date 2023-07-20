//
//  hashTag.swift
//  FBLoginTest
//
//  Created by Kirk Hsieh on 2018/8/2.
//  Copyright © 2018年 iDEA. All rights reserved.
//

import Foundation
class hashTag: CustomStringConvertible {
    var tags: [String] = []
    
    var description: String {
        return tags.joined(separator: ",")
    }
    
    func add(tagName: String) {
        tags.append(tagName)
    }
    
    func remove(tagName: String) {
        let itemIndex = (tags.index(of: tagName))!
        tags.remove(at: itemIndex)
    }
    
    func get(index: Int) -> String {
        return tags[index]
    }
    
    func getAll() -> [String] {
        return tags
    }
    
    func toJSON() -> String {
        return "[\""+tags.joined(separator: "\",\"")+"\"]"
    }
    func count() -> Int {
        return tags.count
    }
    
}


