//
//  EventVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/18/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class EventVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableViewVC: UITableView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var queryStr:String = ""
    var numRow:Int = 0
    var currIndex:Int = 0
    var searchAllData = [JSON]()
    var searchData = [JSON]()
    var fetched:Bool = false
    
    
    @IBAction func prevPage(_ sender: Any) {
        self.searchData.removeAll()
        self.nextButton.isEnabled = true
        self.currIndex -= self.numRow
        if(self.currIndex == 10)
        {
            self.prevButton.isEnabled = false
        }
        for index in (self.currIndex-10)..<self.currIndex
        {
            self.searchData.append(self.searchAllData[index])
        }
        self.numRow = 10
        self.tableViewVC.reloadData()
    }
    
    @IBAction func nextPage(_ sender: Any) {
        self.searchData.removeAll()
        self.prevButton.isEnabled = true
        if((self.currIndex+10)<searchAllData.count)
        {
            self.nextButton.isEnabled = true
            for index in self.currIndex..<(self.currIndex+10)
            {
                searchData.append(searchAllData[index])
            }
            self.numRow = 10
            self.currIndex += 10
        }
        else
        {
            self.nextButton.isEnabled = false
            for index in self.currIndex..<searchAllData.count
            {
                searchData.append(searchAllData[index])
            }
            self.numRow = searchAllData.count-currIndex
            self.currIndex = searchAllData.count
        }
        self.tableViewVC.reloadData()

    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetched = false
        SwiftSpinner.show("Loading data...")
        prevButton.isEnabled = false
        nextButton.isEnabled = false
        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 325
            menuButton.target = self.revealViewController()
            menuButton.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void)
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        Alamofire.request("http://csci571spr2017ypios-env.us-west-2.elasticbeanstalk.com/wHW92ag5.php?q="+queryStr+"&type=event").responseJSON{ response in
            self.fetched = true
            switch response.result{
            case .success(let value):
                let jsonResult = JSON(value)
                let data: Array<JSON> =  jsonResult["data"].arrayValue
                self.searchAllData = data
                if(data.count>10)
                {
                    self.numRow=10
                    self.currIndex=10
                    self.nextButton.isEnabled = true
                    self.searchData.removeAll()
                    for index in 0...9{
                        self.searchData.append(data[index])
                    }
                }
                else
                {
                    self.currIndex=data.count
                    self.numRow=data.count
                    self.searchData = data
                }
            case .failure(let error):
                print(error)
            }
            
            self.tableViewVC.reloadData()
        }

        // Do any additional setup after loading the view.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(fetched && numRow == 0)
        {
            SwiftSpinner.hide()
        }
        return numRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! searchCell
        
        if(numRow > 0 && searchData.count>0)
        {
            cell.profileName.text = searchData[indexPath.row]["name"].string
            if let url = URL.init(string: searchData[indexPath.row]["picture"]["data"]["url"].string!)
            {
                cell.profilePic.downloadedFrom(url: url)
            }
            let favList = UserDefaults.standard.dictionary(forKey: "event")
            if(favList == nil)
            {
                cell.favButton.image = UIImage(named:"empty")
            }
            else
            {
                if(favList?[searchData[indexPath.row]["id"].string!] == nil)
                {
                    cell.favButton.image = UIImage(named:"empty")
                }
                else
                {
                    cell.favButton.image = UIImage(named:"filled")
                }
            }
            
            cell.profileID = searchData[indexPath.row]["id"].string!
            cell.profileURL = searchData[indexPath.row]["picture"]["data"]["url"].string!
        }
        if((indexPath.row+1) == self.numRow)
        {
            SwiftSpinner.hide()
        }
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let thisSender = sender as! searchCell
        let newView = segue.destination as! detailBarVC
        newView.detailID = thisSender.profileID
        newView.detailName = "event"
        newView.detailURL = thisSender.profileURL
        newView.detailProfileName = thisSender.profileName.text!
        let albumView = newView.viewControllers![0] as! AlbumVC
        albumView.detailID = thisSender.profileID
        albumView.detailName = "event"
        let postView = newView.viewControllers![1] as! PostVC
        postView.detailID = thisSender.profileID
        postView.detailName = "event"
        postView.profileURL = thisSender.profileURL
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableViewVC.reloadData()
        
    }

}
