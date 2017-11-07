//
//  searchTabSWRVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/20/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class searchTabSWRVC: SWRevealViewController {

    var queryStr:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "sw_front")
        {
            let newView = segue.destination as! searchTabBarC
            let nvcUser = newView.viewControllers![0] as! UINavigationController
            let svcUser = nvcUser.topViewController as! UserVC
            svcUser.queryStr = queryStr
            let nvcPage = newView.viewControllers![1] as! UINavigationController
            let svcPage = nvcPage.topViewController as! PageVC
            svcPage.queryStr = queryStr
            let nvcEvent = newView.viewControllers![2] as! UINavigationController
            let svcEvent = nvcEvent.topViewController as! EventVC
            svcEvent.queryStr = queryStr
            let nvcPlace = newView.viewControllers![3] as! UINavigationController
            let svcPlace = nvcPlace.topViewController as! PlaceVC
            svcPlace.queryStr = queryStr
            let nvcGroup = newView.viewControllers![4] as! UINavigationController
            let svcGroup = nvcGroup.topViewController as! GroupVC
            svcGroup.queryStr = queryStr
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
