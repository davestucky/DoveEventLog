//
//  BirdEggInvVC.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 11/8/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class BirdEggInvVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    var stuff  = NSMutableArray()
    var values:NSArray = []
    var birdlist1 = [BirdsWithEggs]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllBirdsList()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birdlist1.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WUADCouplesEggs
        
        let item = birdlist1[(indexPath as NSIndexPath).row]
        
        cell.henBand!.text = item.henband
        cell.cockBand!.text = item.cockband
        cell.hatchDate!.text = item.hatchdate
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\((indexPath as NSIndexPath).row)!")
    }
    
    func getAllBirdsList(){
        let url = URL(string: "http://davestucky.com/birdworks2.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])!  {
            let eggBirds = BirdsWithEggs()
            eggBirds.henband = (row["henbandno"] as? String)!
            eggBirds.cockband = (row["cockbandno"] as? String)!
            eggBirds.hatchdate = (row["datehatch"] as? String)!
            birdlist1.append(eggBirds)
            
        }
    }



}
