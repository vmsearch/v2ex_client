//
//  ViewController.swift
//  v2ex
//
//  Created by admin on 15/11/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var Url:String?
    var content:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.font = UIFont(name: "Helvetica Neue", size: 10)
        detailLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = NSTextAlignment.Natural
        detailLabel.layer.cornerRadius = 10
        detailLabel.layer.borderWidth = 2
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //articles(Url!)
        reloadContent(content!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func reloadContent(contents:String) {
        let data = contents.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false)
        
        let atext = try? NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
        
        detailLabel.attributedText = atext
        

        
        self.view.addSubview(detailLabel)
    }


}

