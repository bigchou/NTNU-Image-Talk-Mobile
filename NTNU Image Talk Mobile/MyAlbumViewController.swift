//
//  MyAlbumViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 30/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit
import CoreData

class MyAlbumViewController: UITableViewController {
    
    /*
    var myimages:[MyImage] = [
        MyImage(description:"Cafe Deadend", image:"Hamburger"),
        MyImage(description:"Homei", image:"Hamburger2"),
        MyImage(description:"Traif", image:"Hamburger3")]*/
    var myimages:[MyImage] = []
    var previous_count = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("myalbum viewdidload")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // Retrieve Data From DB
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyDBImages")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            print("Retrive!")
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    let description = result.value(forKey: "descript")
                    let data =  result.value(forKey: "image")
                    let tmpobj = MyImage(description: description as! String, image: data! as! NSData)
                    myimages.append(tmpobj)
                    //print(result)
                }
                self.tableView.reloadData()
            }
        }catch{
            print("error")
        }
        previous_count = myimages.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool){
        //print("viewWillAppear")
        //print("Retrieve Data From Local DB")
        // Retrieve Data From DB
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyDBImages")
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try context.fetch(fetchRequest)
            if(previous_count != results.count){
                myimages.removeAll()
                for result in results as! [NSManagedObject]{
                    let description = result.value(forKey: "descript")
                    let data =  result.value(forKey: "image")
                    let tmpobj = MyImage(description: description as! String, image: data! as! NSData)
                    myimages.append(tmpobj)
                    //print(result)
                }
                previous_count = results.count
                self.tableView.reloadData()
                print("Retrieve!")
            }else{
                print("nothing change")
            }
        }catch{
            print("error")
        }
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
        //cell.imageView?.image = UIImage(named:myimages[indexPath.row].image)
        cell.imageView?.image = UIImage(data:myimages[indexPath.row].image! as Data)
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //print("swipe button")
        let share = UITableViewRowAction(style: .default, title: "Share") {
            (action, indexPath) in
            // share item at indexPath
            let defaultText = "Just checking in at " + self.myimages[indexPath.row].description
            if let imageToShare = UIImage(data: self.myimages[indexPath.row].image as! Data){
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        share.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue:253.0/255.0, alpha:1.0)
        return [share]
    }

}
