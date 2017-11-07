//
//  FavPlace.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/26/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit

class FavPlace: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var tableViewVC: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if revealViewController() != nil {
            revealViewController().rearViewRevealWidth = 325
            menuButton.target = self.revealViewController()
            menuButton.action = #selector((SWRevealViewController.revealToggle) as (SWRevealViewController) -> (Void) -> Void)
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fList = UserDefaults.standard.dictionary(forKey: "place")
        if(fList == nil)
        {
            return 0
        }
        else
        {
            return (fList?.count)!
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fList = UserDefaults.standard.dictionary(forKey: "place")
        let cell = tableView.dequeueReusableCell(withIdentifier: "fcell", for: indexPath) as! FavCell
        
        let favIdList = [String](fList!.keys).sorted()
        cell.profileID = favIdList[indexPath.row]
        if let temp = fList?[favIdList[indexPath.row]] as? [String]{
            cell.favName.text = temp[0]
            cell.profileURL = temp[1]
            if let url = URL.init(string: temp[1])
            {
                cell.favPic.downloadedFrom(url: url)
            }
        }
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableViewVC.reloadData()
        
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let thisSender = sender as! FavCell
        let newView = segue.destination as! detailBarVC
        newView.detailID = thisSender.profileID
        newView.detailName = "place"
        newView.detailURL = thisSender.profileURL
        newView.detailProfileName = thisSender.favName.text!
        let albumView = newView.viewControllers![0] as! AlbumVC
        albumView.detailID = thisSender.profileID
        albumView.detailName = "place"
        let postView = newView.viewControllers![1] as! PostVC
        postView.detailID = thisSender.profileID
        postView.detailName = "place"
        postView.profileURL = thisSender.profileURL
        
        
    }
    

}
