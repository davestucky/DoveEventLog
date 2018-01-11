//
//  DoveInventoryTable.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 11/1/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit


class DoveInventoryTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    var stuff  = NSMutableArray()
    var values:NSArray = []
    var birdlist = [Birdies]()
    var selectedBirds: [Int:String] = [:]
    var birdHere: UISwitch?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllBirdsList()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.birdlist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WUADCustomCellAll
        
        let item = birdlist[(indexPath as NSIndexPath).row]
        
        cell.bandNumber!.text =  item.birdband
        cell.bandyear!.text = item.bandyear
        cell.bandPre!.text = item.bandpre
        cell.bandInven?.setOn(false, animated: false)
        
        switch item.birdlast{
        case "0":
            cell.lastInven?.setOn(false, animated: true)
            break
        case "1":
            cell.lastInven?.setOn(true, animated: true)
            break
        default:
            cell.lastInven?.setOn(true, animated: true)
            break
            
        }
        return cell
        
    }

        func getAllBirdsList(){
        let url = URL(string: "http://davestucky.com/birdworks1.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            let birdies = Birdies()
            birdies.birdband = (row["band_no"] as? String)!
            birdies.bandpre = (row["band_suffix"] as? String)!
            birdies.bandyear = (row["band_year"] as? String)!
            birdies.birdinv = (row["invenhere"] as? String)!
            birdies.birdlast = (row["lastinven"] as? String)!
            birdlist.append(birdies)
        }
    }
}
