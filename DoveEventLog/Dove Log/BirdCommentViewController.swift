//
//  BirdCommentViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/19/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class BirdCommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stuff  = NSMutableArray()
    var findBand: String!
    @IBOutlet var bandNoEdit: UILabel!
    @IBOutlet var commentTabView: UITableView!
    @IBOutlet var dateComment: UITextField!
    @IBOutlet var newComment: UITextView!
    var values : NSArray = []
    var valuesbc:NSArray = []
    var editBandPrefix: String!
    var editBandYear: String!
    var logenter : String!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commentTabView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getBirdEssentials()
        getBirdComments()
        bandNoEdit.textColor = UIColor.green
        bandNoEdit.textAlignment = NSTextAlignment.center
        bandNoEdit.text = "Comments for \(editBandPrefix!) \(findBand!)  \(editBandYear!)"
        bandNoEdit.font = UIFont(name:"HelveticaNeue-Bold", size: 18.0)
        self.dateComment.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        

           }

    func tableView(_ commentTabView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stuff.count
    }
    
    func tableView(_ commentTabView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.commentTabView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = stuff[(indexPath as NSIndexPath).row] as? String
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
    func tableView(_ commentTabView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func getBirdEssentials(){
        let url = URL(string: "http://davestucky.com/birdeditget.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let birdGet = row["band_no"] as? String
            //let longname = findBand
            if birdGet == findBand{
                editBandYear = row["band_year"] as? String
                editBandPrefix = row["band_suffix"] as? String
                bandNoEdit.text = editBandPrefix + " - " + findBand + " - " + editBandYear
            }
            
        }
        
    }

    
    func getBirdComments(){
        
        let url = URL(string: "http://davestucky.com/birdeditcommentsget.php")
        let databc = try? Data(contentsOf: url!)
        valuesbc = try! JSONSerialization.jsonObject(with: databc!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (valuesbc as? [[String:Any]])! {
            
            let birdGet = row["band_number"] as? String
            
            if birdGet == findBand{
                let commentDate = row["comment_date"] as? String
                let comment = row["comment_comment"] as? String
                let longinfo = commentDate! + " - " + comment!
                stuff.add(longinfo)
                
            }
        }
    }
  
    @IBAction func saveCommentPressed(_ sender: AnyObject) {
     let date = Date() //get the time, in this case the time an object was created.
     //format date
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd" //format style. Browse online to get a format that fits your needs.
     let dateString = dateFormatter.string(from: date)
     
     //hack
     let url = URL(string: "http://davestucky.com/birdworks.php")
     var request = URLRequest(url: url!)
     request.httpMethod = "POST"
     let postString = "task=misccomment&band=\(findBand!)&date=\(dateString)&desc=\(newComment.text!)"
     request.httpBody = postString.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
     let task = URLSession.shared.dataTask(with: request, completionHandler: {
     data, response, error in
     
     if error != nil {
     print("error=\(String(describing: error))")
     return
     }
     
     print("response = \(String(describing: response))")
     
     let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
     print("responseString = \(String(describing: responseString))")
     })
     task.resume()
     self.newComment.text = ""
     
     
     
     }
    
    
}
