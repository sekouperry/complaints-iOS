//
//  Post.swift
//  complaints
//
//  Created by Sekou Perry on 9/12/16.
//  Copyright © 2016 Sekou Perry. All rights reserved.
//

import Foundation


class Post NSObject, NSCoding {
    
    fileprivate var _imagePath: String!
    fileprivate var _title: String!
    fileprivate var _postDesc: String!
    
    
    var imagePath: String {
        return _imagePath
    }
    
    var title: String {
        return _title
    }
    
    var postDesc: String {
        return _postDesc
    }
    
    
    init(imagePath: String, title: String, description: String) {
        self._imagePath = imagePath
        self._title = title
        self._postDesc = description
        
    }
    
    override init() {
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("description") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._postDesc, forKey: "description")
        aCoder.encodeObject(self._title, forKey: "title")
    }
    
}
