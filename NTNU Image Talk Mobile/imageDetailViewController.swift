//
//  imageDetailViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit

class imageDetailViewController: UIViewController {
    @IBOutlet weak var imageImageView: UIImageView!
    var imageImage = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Result"
        imageImageView.image = UIImage(named: imageImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        navigationController?.setNavigationBarHidden(false, animated: true)
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
