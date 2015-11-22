//
//  ViewController.swift
//  v2ex
//
//  Created by admin on 15/11/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailView: UIWebView!
    var Url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        articles(Url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func articles(url:String){
        
        print("url \(url)")
        
        let Url:NSURL! = NSURL(string: url)
        let request = NSURLRequest(URL: Url)
        
        detailView.loadRequest(request)
        
        
    }


}

