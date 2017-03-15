//
//  Post.swift
//  snapChatProject
//
//  Created by Paige Plander on 3/11/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    /// The image that the user posted
    let postImage: UIImage
    
    /// Boolean indicating whether or not the post has been read
    var read: Bool = false
    
    /// Username of the poster
    let username: String
    
    /// The thread the the post was added to
    let thread: String
    
    /// The date that the snap was posted
    let date: Date
    
    /// Designated initializer for posts
    ///
    /// - Parameters:
    ///   - username: The name of the user making the post
    ///   - postImage: The image that will show up in the post
    ///   - thread: The thread that the image should be posted to
    init(username: String, postImage: UIImage, thread: String) {
        self.postImage = postImage
        self.username = username
        self.thread = thread
        date = Date()
    }
    
    func getTimeElapsedString() -> String {
        let secondsSincePosted = -date.timeIntervalSinceNow
        let minutes = Int(secondsSincePosted / 60)
        if minutes == 1 {
            return "\(minutes) minute ago"
        }
        return "\(minutes) minutes ago "
    }

}
