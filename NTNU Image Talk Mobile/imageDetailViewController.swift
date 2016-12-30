//
//  imageDetailViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit

class imageDetailViewController: UIViewController {
    @IBOutlet weak var DescriptionArea: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    var imageImage:NSData?
    var imageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Result"
        
        imageImageView.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        imageImageView.layer.cornerRadius = 5.0
        imageImageView.layer.borderWidth = 4
        //imageImageView.clipsToBounds = true
        //imageImageView.layer.frame = imageImageView.layer.frame.insetBy(dx: 20, dy: 20)
        //imageImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
        //imageImageView.image = UIImage(named: imageImage)
        imageImageView.image = UIImage(data: imageImage! as Data)
        
        let topColor = UIColor(red:15.0/255.0,green:118.0/255.0,blue:128.0/255.0,alpha:1.0)
        let bottomColor = UIColor(red:84.0/255.0,green:187.0/255.0,blue:187.0/255.0,alpha:1.0)
        let gradientColor:[CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0,1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColor
        gradientLayer.locations = gradientLocations as [NSNumber]?
        gradientLayer.frame = self.view.bounds
        //gradientLayer.frame = self.DescriptionArea.layer.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        //self.DescriptionArea.layer.insertSublayer(gradientLayer, at: 0)
        
        
        DescriptionArea.text = imageName
        
    }
    
    override func viewWillLayoutSubviews() {
        DescriptionArea.sizeToFit()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.hidesBarsOnTap = true
        //navigationController?.setNavigationBarHidden(false, animated: true)
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
