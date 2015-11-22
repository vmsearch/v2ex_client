//
//  NewsListTableViewController.swift
//  v2ex
//
//  Created by admin on 15/11/21.
//  Copyright © 2015年 admin. All rights reserved.
//

import UIKit

class NewsListTableViewController: UITableViewController {

    let dataURL: NSURL! = NSURL(string: "https://www.v2ex.com/api/topics/hot.json")
    var topicList = [ArticleItems]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "下拉，更新..")
        refreshControl.addTarget(self, action: "updateData", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        self.updateData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func updateData() {
        refreshControl?.beginRefreshing()
        let data:NSData! = try? NSData(contentsOfURL: dataURL, options: NSDataReadingOptions.DataReadingUncached)
        let jsonData:AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        
        if let jsonItem = jsonData as? NSArray {
            for item in jsonItem {
                let topic = ArticleItems(
                    title: item.objectForKey("title") as! String,
                    url: item.objectForKey("url") as! String,
                    content: item.objectForKey("content_rendered") as! String,
                    created_at: item.objectForKey("created") as! Double,
                    thumb:item.objectForKey("member")?.objectForKey("avatar_normal") as! String
                    )
                topicList.append(topic)
                //print(item.objectForKey("member")?.objectForKey("avatar_normal"))
            }
        }
        //print("topic count is \(topicList.count)")
                self.tableView.reloadData()
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
        refreshControl?.endRefreshing()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return topicList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "resumcell")
        cell.textLabel?.text = topicList[indexPath.row].title
        cell.imageView?.image = UIImage(named:"photo")
        cell.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        let http_pre = "https:"
        let URL = http_pre  + topicList[indexPath.row].thumb
        
        let imgURL: NSURL! = NSURL(string: URL)
        
        let session = NSURLSession.sharedSession()
        let request = NSURLRequest(URL: imgURL)
        let thumbQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: thumbQueue, completionHandler: { response, data, error in
          
            let image = UIImage(data :data!)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.imageView?.image = image
            })
            
        })
        
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("infos", sender: self)
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "infos" {
            let indexPtach = tableView.indexPathForSelectedRow
            
            let webViewControll = segue.destinationViewController as? ViewController
            
            webViewControll?.Url = self.topicList[indexPtach!.row].url
            
        }
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        UIView.animateWithDuration(0.25, animations:{
            cell.layer.transform = CATransform3DMakeTranslation(1, 1, 1)
            
        })
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
