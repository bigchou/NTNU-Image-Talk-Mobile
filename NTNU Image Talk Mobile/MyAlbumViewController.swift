//
//  MyAlbumViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 30/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit

class MyAlbumViewController: UITableViewController {

    var myimages:[MyImage] = [
        MyImage(description:"Cafe Deadend", image:"Hamburger"),
        MyImage(description:"Homei", image:"Hamburger2"),
        MyImage(description:"Traif", image:"Hamburger3")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/
    override func numberOfSections(in tableView: UITableView) -> Int {
        //print("numberOfSections")
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberOfRowsInSection")
        // #warning Incomplete implementation, return the number of rows
        return myimages.count
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellForRowAt")
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        // Configure the cell...
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        cell.textLabel?.text = myimages[indexPath.row].description
        cell.imageView?.image = UIImage(named:myimages[indexPath.row].image)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("prepareforsegue")
        if segue.identifier == "showMyImageDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! imageDetailViewController
                destinationController.imageImage = myimages[indexPath.row].image
                destinationController.imageName = myimages[indexPath.row].description
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }

}
