//
//  DataService.swift
//  complaints
//
//  Created by Sekou Perry on 9/15/16.
//  Copyright © 2016 Sekou Perry. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    
    private var _loadedPosts = [Post]()
    
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    func savePosts() {
        let postData = NSKeyedArchiver.archivedData(withRootObject: _loadedPosts)
        UserDefaults.standard.set(postData, forKey: KEY_POSTS)
        UserDefaults.standard.synchronize()
    }
    
    func loadPosts() {
        if let postData = UserDefaults.standard.object(forKey: KEY_POSTS) as? NSData {
            
            if let postsArray = NSKeyedUnarchiver.unarchiveObject(with: postData as Data) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "postsLoaded"), object: nil) as Notification)
    }
    
    func saveImageAndCreatePath(image: UIImage) {
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate).png"
        let fullPath = documentsPathForFileName(name: imgPath)
        imgData?.writeToFile(fullPath, atomically: true)
        return imgPath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(name: path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentsPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, UserDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.stringByAppendingPathComponent(name)
    }
    
}
