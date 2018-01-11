//
//  DoveEggsViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 11/7/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import UIKit

class DoveEggsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView!
    var stuff  = NSMutableArray()
    var values:NSArray = []
    var birdListReal = [BirdsWithEggs]()
    var birdListFake = [BirdsWithEggs]()
    var seqID = 0
    var seqHenBand: String = ""
    var seqCockBand: String  = ""
    var seqHatchDate: String  = ""
    let today = Date() as Date
    //let fallsBetween: Bool = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        getAllBirdsWithEggs()
        getAllBirdsWithFakeEggs()
        
    }
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let eggLabel = UILabel()
        if section == 0 {
           eggLabel.text = "Birds with Real Eggs"
            eggLabel.backgroundColor = UIColor.lightGray
        } else {
            eggLabel.text = "Birds with Fake Eggs"
            eggLabel.backgroundColor = UIColor.lightGray
        }
        return eggLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
        return birdListReal.count
        }
        return birdListFake.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let startEggDate = Calendar.current.date(byAdding: .day, value: +18, to: today)! as Date
        let blueEggDate = Calendar.current.date(byAdding: .day, value: +12, to: today)! as Date
        let yellowEggDate = Calendar.current.date(byAdding: .day, value: +6, to: today)! as Date
        let greenEggDate = Calendar.current.date(byAdding: .day, value: +5, to: today)! as Date
        let redEggDate = Calendar.current.date(byAdding: .day, value: -1, to: today)! as Date
        let outEggDate = Calendar.current.date(byAdding: .day, value: -6, to: today)! as Date
        let myEggDate = Calendar.current.date(byAdding: .day, value: -1, to: today)! as Date

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WUADCouplesEggs
        let item = indexPath.section == 0 ? birdListReal[(indexPath as NSIndexPath).row] : birdListFake[(indexPath as NSIndexPath).row]
        if indexPath.section == 0 {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
        let curHatchDate = dateFormat.date(from: item.hatchdate)!
        var fallsBetween = (blueEggDate...startEggDate).contains(curHatchDate)
            if fallsBetween{
                cell.henBand?.textColor = UIColor.blue
                cell.cockBand?.textColor = UIColor.blue
                cell.hatchDate?.textColor = UIColor.blue
                }
            else if curHatchDate == blueEggDate{
                cell.henBand?.textColor = UIColor.blue
                cell.cockBand?.textColor = UIColor.blue
                cell.hatchDate?.textColor = UIColor.blue
                }
            else if curHatchDate == startEggDate{
                cell.henBand?.textColor = UIColor.blue
                cell.cockBand?.textColor = UIColor.blue
                cell.hatchDate?.textColor = UIColor.blue
        }
            fallsBetween = (yellowEggDate...blueEggDate).contains(curHatchDate)
            if fallsBetween{
                cell.henBand?.textColor = UIColor.orange
                cell.cockBand?.textColor = UIColor.orange
                cell.hatchDate?.textColor = UIColor.orange
            }
            else if curHatchDate == yellowEggDate{
                cell.henBand?.textColor = UIColor.orange
                cell.cockBand?.textColor = UIColor.orange
                cell.hatchDate?.textColor = UIColor.orange
            }
            else if curHatchDate == blueEggDate{
                cell.henBand?.textColor = UIColor.orange
                cell.cockBand?.textColor = UIColor.orange
                cell.hatchDate?.textColor = UIColor.orange
        }
            fallsBetween = (myEggDate...greenEggDate).contains(curHatchDate)
            if fallsBetween{
                cell.henBand?.textColor = UIColor.green
                cell.cockBand?.textColor = UIColor.green
                cell.hatchDate?.textColor = UIColor.green
            }
            else if curHatchDate == myEggDate{
                cell.henBand?.textColor = UIColor.green
                cell.cockBand?.textColor = UIColor.green
                cell.hatchDate?.textColor = UIColor.green
            }
            else if curHatchDate == greenEggDate{
                cell.henBand?.textColor = UIColor.green
                cell.cockBand?.textColor = UIColor.green
                cell.hatchDate?.textColor = UIColor.green
        }
            fallsBetween = (outEggDate...redEggDate).contains(curHatchDate)
            if fallsBetween{
                cell.henBand?.textColor = UIColor.red
                cell.cockBand?.textColor = UIColor.red
                cell.hatchDate?.textColor = UIColor.red
            }
            else if curHatchDate == outEggDate{
                cell.henBand?.textColor = UIColor.red
                cell.cockBand?.textColor = UIColor.red
                cell.hatchDate?.textColor = UIColor.red
            }
            else if curHatchDate == redEggDate{
                cell.henBand?.textColor = UIColor.red
                cell.cockBand?.textColor = UIColor.red
                cell.hatchDate?.textColor = UIColor.red
        }
            
        }
            cell.henBand!.text = item.henband
            cell.cockBand!.text = item.cockband
            cell.hatchDate!.text = item.hatchdate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item = birdListReal[(indexPath as NSIndexPath).row]
        seqID = item.ID
        seqHenBand = item.henband
        seqCockBand = item.cockband
        seqHatchDate = item.hatchdate
        self.performSegue(withIdentifier: "updateegginfo", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "updateegginfo" {
            let destinationVC : EditEggViewController  = segue.destination as! EditEggViewController
            destinationVC.IDNumber = seqID
            destinationVC.henbandlabel = seqHenBand
            destinationVC.cockbandlabel = seqCockBand
            destinationVC.datehatchlabel = seqHatchDate


            }
        }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let eggOneHatch = UITableViewRowAction(style: .normal, title: "1st Hatch") { (action, indexPath) in
            // MARK
            let currentCell = tableView.cellForRow(at: indexPath)! as! WUADCouplesEggs
            let henHatch = currentCell.henBand!.text!
            let cockHatch = currentCell.cockBand!.text!
            let hatched = currentCell.hatchDate!.text!
            let finder = currentCell.IDNumber?.text!
            
            let url = URL(string: "http://davestucky.com/birdworks.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let postString = "task=updateEggONEHatch&henband=\(henHatch)&cockband=\(cockHatch)&datehatch=\(hatched)&newhatch=1&recordID=\(String(describing: finder))"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
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
            
        }
        
            eggOneHatch.backgroundColor = UIColor.green
        
        
            let eggTwoHatch = UITableViewRowAction(style: .normal, title: "2nd Hatch") { (action, indexPath) in
            // MARK
            let currentCell = tableView.cellForRow(at: indexPath)! as! WUADCouplesEggs
            let henHatch = currentCell.henBand!.text!
            let cockHatch = currentCell.cockBand!.text!
            let hatched = currentCell.hatchDate!.text!
            let finder = currentCell.IDNumber?.text!
            
            let url = URL(string: "http://davestucky.com/birdworks.php")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            let postString = "task=updateEggTWOHatch&henband=\(henHatch)&cockband=\(cockHatch)&datehatch=\(hatched)&newhatch=1&\(String(describing: finder))"
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
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

        }
        eggTwoHatch.backgroundColor = UIColor.green
        
        return [eggTwoHatch, eggOneHatch]
    }
    

    func getAllBirdsWithEggs(){
        let url = URL(string: "http://davestucky.com/birdworks2.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        if values.count == 0 {
            let eggBirds = BirdsWithEggs()
            eggBirds.henband = "NO"
            eggBirds.cockband = "EGGS"
            eggBirds.hatchdate = "DUE"
            birdListReal.append(eggBirds)
        }
        for row in (values as? [[String:Any]])!  {
            let eggBirds = BirdsWithEggs()
            
            eggBirds.ID = (row["ID"] as! NSString).integerValue
            eggBirds.henband = (row["henbandno"] as? String)!
            eggBirds.cockband = (row["cockbandno"] as? String)!
            eggBirds.hatchdate = (row["datehatch"] as? String)!
            birdListReal.append(eggBirds)
            
        }
    }
   
    func getAllBirdsWithFakeEggs(){
        let url = URL(string: "http://davestucky.com/birdworks8.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        if values.count == 0 {
            let eggBirds = BirdsWithEggs()
            eggBirds.henband = "NO"
            eggBirds.cockband = "FAKES"
            eggBirds.hatchdate = "OUT"
            birdListFake.append(eggBirds)
        }
        
        for row in (values as? [[String:Any]])!  {
            let eggBirds = BirdsWithEggs()
            eggBirds.henband = (row["henbandno"] as? String)!
            eggBirds.cockband = (row["cockbandno"] as? String)!
            eggBirds.hatchdate = (row["datehatch"] as? String)!
            birdListFake.append(eggBirds)
            
        }
    }
}

