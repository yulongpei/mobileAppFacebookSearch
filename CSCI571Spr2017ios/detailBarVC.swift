//
//  detailBarVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/26/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit
import FacebookShare

class detailBarVC: UITabBarController {

    
    var detailName:String = ""
    var detailID:String = ""
    var detailURL:String = ""
    var detailProfileName:String = ""
    
    func optionPressed()
    {
        let favList = UserDefaults.standard.dictionary(forKey: detailName)
        
        let alertController = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        if(favList == nil)
        {
            alertController.addAction(UIAlertAction(title:"Add to favorites", style: .default, handler: addToFav))
        }
        else
        {
            if(favList?[detailID] == nil)
            {
                alertController.addAction(UIAlertAction(title:"Add to favorites", style: .default, handler: addToFav))
            }
            else
            {
                alertController.addAction(UIAlertAction(title:"remove from favorites", style: .default, handler: removeFromFav))
            }
        }
        alertController.addAction(UIAlertAction(title:"Share", style: .default, handler: fbShare))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true)
    }
    func addToFav(action: UIAlertAction)
    {
        var fList = UserDefaults.standard.dictionary(forKey: detailName)
        if(fList == nil)
        {
            var detailList = [String:Any]()
            detailList[detailID] = [detailProfileName,detailURL]
            UserDefaults.standard.set(detailList, forKey: detailName)
        }
        else
        {
            fList?[detailID] = [detailProfileName,detailURL]
            UserDefaults.standard.set(fList, forKey: detailName)
        }
    }
    func removeFromFav(action: UIAlertAction)
    {
        var fList = UserDefaults.standard.dictionary(forKey: detailName)
        fList?.removeValue(forKey: detailID)
        UserDefaults.standard.set(fList, forKey: detailName)
    }
    func fbShare(action: UIAlertAction)
    {
        
        let url = URL(fileURLWithPath: "https://www.facebook.com/"+self.detailID)
        let content = LinkShareContent(url: url, title: self.detailProfileName, description: "FB Share for CSCI 571", quote: "", imageURL: NSURL(string: self.detailURL)! as URL)
        
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            // Handle share results
            print("success")
        }
        
        do {
            try shareDialog.show()
        } catch (let error) {
            print("error",error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "options"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(detailBarVC.optionPressed))
        // Do any additional setup after loading the view.
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
