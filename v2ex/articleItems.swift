//
//  articleItems.swift
//  v2ex
//
//  Created by admin on 15/11/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import Foundation
class ArticleItems:NSObject {
    
    var title: String
    var url: String
    var thumb:String
    var content: String
    var created_at: Double
    
    override init() {
    self.title = String()
    self.url = String()
    self.content = String()
    self.thumb = String()
    self.created_at = 0
    }
    
    init(title:String, url:String, content:String, created_at:Double, thumb:String) {
    self.title = title
    self.url = url
    self.content = content
    self.created_at = created_at
    self.thumb = thumb
    }
    
    
}