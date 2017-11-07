//
//  AlbumVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/24/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class AlbumVC: UIViewController, UITableViewDelegate ,UITableViewDataSource {

    @IBOutlet weak var tableViewVC: UITableView!
    
    
    var detailID:String = ""
    var numRow:Int = 0
    var expandedRows = Set<Int>()
    var detailName:String = ""
    var albumData = [JSON]()
    var haveData:Bool = false
    var fetched:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewVC.delegate = self
        self.tableViewVC.dataSource = self
        self.tableViewVC.estimatedRowHeight = 410.0
        self.tableViewVC.rowHeight = UITableViewAutomaticDimension
        
        SwiftSpinner.show("Loading data...")
        
        fetched = false
        
        Alamofire.request("http://csci571spr2017ypios-env.us-west-2.elasticbeanstalk.com/wHW92ag5.php?id="+detailID+"&detailName="+detailName+"&detailType=album").responseJSON{ response in
            self.fetched = true
            
            switch response.result{
            case .success(let value):
                
                let jsonResult = JSON(value)
                if(self.detailName == "event")
                {
                    self.haveData = false
                    self.numRow = 0
                    //let data: Array<JSON> =  jsonResult["album"].arrayValue
                }
                else
                {
                    
                    let data: Array<JSON> =  jsonResult["albums"]["data"].arrayValue
                    
                    if(data.isEmpty)
                    {
                        
                        self.haveData = false
                        self.numRow = 0
                    }
                    else{
                        
                        self.haveData = true
                        self.numRow = data.count
                        self.albumData = data
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
            
            self.tableViewVC.reloadData()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(fetched && !haveData)
        {
            self.tableViewVC.isHidden = true
            let label = UILabel(frame: CGRect(x: 130, y: 323, width: 114, height: 21))
            label.textAlignment = .center
            label.text = "No data found."
            self.view.addSubview(label)
            SwiftSpinner.hide()
        }
        return numRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ExpandCell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell") as! ExpandCell
        
        print("havedata",haveData)
        self.tableViewVC.isHidden = false
        cell.albumName.text = albumData[indexPath.row]["name"].string
        
        if albumData[indexPath.row]["photos"]["data"].arrayValue != []
        {
            if(albumData[indexPath.row]["photos"]["data"][0]["picture"].string != nil)
            {
                if let url = URL.init(string: albumData[indexPath.row]["photos"]["data"][0]["picture"].string!)
                {
                    cell.albumPicOne.downloadedFrom(url: url)
                }
            }
            
            if(albumData[indexPath.row]["photos"]["data"][1]["picture"].string != nil)
            {
                if let url = URL.init(string: albumData[indexPath.row]["photos"]["data"][1]["picture"].string!)
                {
            
                    cell.albumPicTwo.downloadedFrom(url: url)
                }
            }
        }
        
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        
        if((indexPath.row+1) == self.numRow)
        {
            SwiftSpinner.hide()
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandCell
            
            else {return}
        
        switch cell.isExpanded
        {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
        
        cell.isExpanded = !cell.isExpanded
        
        self.tableViewVC.beginUpdates()
        
        self.tableViewVC.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandCell
            
            else {return}
        
        self.expandedRows.remove(indexPath.row)
        cell.isExpanded = false
        
        self.tableViewVC.beginUpdates()
        self.tableViewVC.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 410.0
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
