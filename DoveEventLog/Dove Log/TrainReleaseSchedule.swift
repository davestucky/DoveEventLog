//
//  TrainReleaseSchedule.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 10/24/16.
//  Copyright © 2016 DaveStucky. All rights reserved.
//

import Foundation
import UIKit

struct trainRelsched
{
    var distDir:String?
    var trainDate:String?
    
    init(add: NSDictionary)
    {
        distDir = add["distance_direction"] as? String
        trainDate = add["date"] as? String
    }
}


class TrainingReleaseSchedule: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var cellTrainDate: UILabel!
    @IBOutlet var cellDistance: UILabel!
    @IBOutlet var trschedLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var trainClassPicker: UIPickerView!
    
    var TableData:Array< trainRelsched > = Array < trainRelsched >()
    var stuff  = NSMutableArray()
    var values:NSArray = []
    var classLookUp:String = "red"
    var relData = [trainRelsched]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getTeamKeys()
         self.trainClassPicker.reloadAllComponents()
        classLookUp = stuff[0] as! String
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = TableData[(indexPath as NSIndexPath).row]
        
        print(item)
        
        cell.textLabel!.text = item.distDir!
        cell.detailTextLabel!.text = item.trainDate!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    @IBAction func classProgressPressed(_ sender: AnyObject) {
        TableData.removeAll()
        tableView.reloadData()
        getTrainSchedule()
        
        
    }
    
    func getTeamKeys(){
        let url = URL(string: "http://davestucky.com/birdworks3.php")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for row in (values as? [[String:Any]])! {
            
            let teamColor = row["class_band"]
            print(teamColor!)
            let longname = teamColor!
            stuff.add(longname)
            
            
        }
        
    }
    //  Team Picker View Stuff
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return stuff.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return (stuff[row] as! String)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let itemSelected: String = stuff[row] as! String
        classLookUp = itemSelected
        
    }
    
    //TPV end

    
    func getTrainSchedule(){
        
        let url = URL(string: "http://davestucky.com/birdtrainsched.php?class=\(classLookUp)")
        let data = try? Data(contentsOf: url!)
        values = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for i in 0 ..< values.count
        {
            if let data_block = values[i] as? NSDictionary
            {
                
                TableData.append(trainRelsched(add: data_block))
            }
            do_table_refresh()
        }
        
    }
    
    func do_table_refresh()
    {
        DispatchQueue.main.async(execute: {
            self.trschedLabel.text = "Training History for \(self.classLookUp) Class"
            self.tableView.reloadData()
            return
        })
    }
    
    // End new json way
    
}
