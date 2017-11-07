//
//  MainVC.swift
//  CSCI571Spr2017ios
//
//  Created by YuLong Pei on 4/18/17.
//  Copyright © 2017 YuLong Pei. All rights reserved.
//

import UIKit
import EasyToast
import Alamofire


class MainVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!

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
    
    @IBAction func clearText(_ sender: Any) {
        if(searchTextField.hasText)
        {
            searchTextField.text = ""
        }
    }
    @IBAction func startSearch(_ sender: Any) {
        if(searchTextField.hasText)
        {
            performSegue(withIdentifier: "nextView", sender: self)
        }
        else
        {
           self.view.showToast("Enter a valid query!", position: .bottom, popTime: 3, dismissOnTap: false)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newView = segue.destination as! searchTabSWRVC
        newView.queryStr = searchTextField.text!
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
