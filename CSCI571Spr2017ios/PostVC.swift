//
//  PostVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/24/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class PostVC: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableViewVC: UITableView!
    
    var detailID:String = ""
    var detailName:String = ""
    var numRow:Int = 0
    var postData = [JSON]()
    var haveData:Bool = false
    var profileURL:String = ""
    var fetched:Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SwiftSpinner.show("Loading data...")
        fetched = false
        Alamofire.request("http://csci571spr2017ypios-env.us-west-2.elasticbeanstalk.com/wHW92ag5.php?id="+detailID+"&detailName="+detailName+"&detailType=post").responseJSON{ response in
            
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
                    
                    let data: Array<JSON> =  jsonResult["posts"]["data"].arrayValue
                    
                    if(data.isEmpty)
                    {
                        
                        self.haveData = false
                        self.numRow = 0
                    }
                    else{
                        
                        self.haveData = true
                        self.numRow = data.count
                        self.postData = data
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pCell") as! PostCell
        if let url = URL.init(string: profileURL)
        {
            cell.postPic.downloadedFrom(url: url)
        }
        cell.postMessage.text = postData[indexPath.row]["message"].string
        
        let myFormatter = DateFormatter()
        
        myFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        myFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let t1 = myFormatter.date(from: postData[indexPath.row]["created_time"].string!)
        myFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        
        cell.postTime.text = myFormatter.string(from: t1!)
        if((indexPath.row+1) == (self.numRow-1))
        {
            SwiftSpinner.hide()
        }
        
        return cell
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
