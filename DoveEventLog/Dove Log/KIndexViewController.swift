//
//  KIndexViewController.swift
//  MyDoveLog
//
//  Created by Dave Stucky on 3/1/17.
//  Copyright © 2017 DaveStucky. All rights reserved.
//

import UIKit
import WebKit

class KIndexViewController: UIViewController {

    @IBOutlet var kIndexView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let URL = NSURL(string: "http://services.swpc.noaa.gov/images/planetary-k-index.gif")
        
        kIndexView.load(NSURLRequest(url: URL! as URL) as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
