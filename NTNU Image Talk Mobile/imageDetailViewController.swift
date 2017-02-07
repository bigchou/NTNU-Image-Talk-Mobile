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
    var relevant_1sttext:String = ""
    var relevant_2ndtext:String = ""
    @IBAction func firstrelevantimage(_ sender: Any) {
        let alert = UIAlertController(title: "Description", message: relevant_1sttext, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func secondrelevantimage(_ sender: Any) {
        let alert = UIAlertController(title: "Description", message: relevant_2ndtext, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBOutlet weak var relevant_1stpic: UIImageView!
    @IBOutlet weak var relevant_2ndpic: UIImageView!
    @IBOutlet weak var relevant_1stimg: UIButton!
    @IBOutlet weak var relevant_2ndimg: UIButton!
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
        // fit top-left
        //DescriptionArea.numberOfLines = 0
        //DescriptionArea.sizeToFit()
        
        // synchrnous transmission
        
        var relevantimg =  [String]()
        var relevanturl = [String]()
        do{
            let input : String = (imageName).lowercased()
            let urlwithPercentEscapes = input.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let qry : String = "http://140.122.185.35:8000/api/images/"+urlwithPercentEscapes!+"/"
            print(qry)
            let url = URL(string: qry)
            let html = try String(contentsOf: url!)
            if let data = html.data(using: String.Encoding.utf8) {
                do {
                    let myJson = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let items = myJson as? NSArray{
                        for item in items{
                            if let ditem = item as? NSDictionary{
                                let text = ditem["text"] as! String
                                relevantimg.append(text)
                                let url = ditem["img"] as! String
                                relevanturl.append(url)
                                //let url = URL(string: ditem["img"] as! String)
                                //let data = try? Data(contentsOf: url!)
                                //let tmpobj = MyImage(description: text, image: data! as NSData)
                                //relevantimg.append(tmpobj)
                            }
                        }
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }catch{
            print("error")
        }
        
        
        // list all relevances
        relevant_1sttext = relevantimg[1]
        relevant_2ndtext = relevantimg[2]
        // set button title
        let maxlen = 38
        var str:String = relevantimg[1]
        var btntitle:String = str
        if(str.characters.count >= maxlen){
            btntitle = str.substring(to: str.index(str.startIndex, offsetBy: maxlen))+"..."
        }
        relevant_1stimg.setTitle(btntitle, for: .normal)
        str = relevantimg[2]
        btntitle = str
        if(str.characters.count >= maxlen){
            btntitle = str.substring(to: str.index(str.startIndex, offsetBy: maxlen))+"..."
        }
        relevant_2ndimg.setTitle(btntitle, for: .normal)
        
        // set thumnail picture
        var url = URL(string: relevanturl[1])
        var data = try? Data(contentsOf: url!)
        relevant_1stpic.image = UIImage(data: data!)
        url = URL(string: relevanturl[2])
        data = try? Data(contentsOf: url!)
        relevant_2ndpic.image = UIImage(data: data!)
        
        
    
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
