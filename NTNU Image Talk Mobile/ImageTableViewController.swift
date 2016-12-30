//
//  ImageTableViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit
import CoreData

class ImageTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate{
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
    
    }
    /*
    var myimages:[MyImage] = [
        MyImage(description:"Cafe Deadend", image:"Hamburger"),
        MyImage(description:"Homei", image:"Hamburger2"),
        MyImage(description:"Traif", image:"Hamburger3")
    ]*/
    
    var filteredmyimages = [MyImage]()
    var shouldUpdateSearchResults = false
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // delete all coredata
        deleteallrecordbycoredata() // for test use
        
        // clean NavigationBar tint
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil)
        configureSearchController()
        
        
        
        
        
        /*
        let url = NSURL(string: "http://api.fixer.io/latest?base=EUR")
        let task = URLSession.shared.dataTask(with: url! as URL) { (data,response,error) in
            if error != nil{
                print("ERROR")
            }else{
                if let content = data{
                    do{
                        // Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        //print(myJson)
                        if let rates = myJson["rates"] as? NSDictionary{
                            print(rates)
                        }
                    }catch{
                        
                    }
                }
            }
            
        }
        task.resume()
        */
        
        
        
    }
    
    

    
    func deleteallrecordbycoredata(){
        // Initialize Fetch Request
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyDBImages")
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object as! NSManagedObject)
                print("del")
            }
        }
    }
    
    
    func configureSearchController() {
        //print("configureSearchController")
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false //become darker when searching
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        // Place the search bar view to the tableview headerview.
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if(filteredmyimages.count != 0){
            filteredmyimages.removeAll()
        }
        print("Begin Editing")
        shouldUpdateSearchResults = false
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        /*
        if(filteredmyimages.count != 0){
            filteredmyimages.removeAll()
        }*/
        print("Cancel!")
        shouldUpdateSearchResults = false
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        /*
        let tmp = ["a1","b2","c3","d4"]
        for item in tmp{
            let tmpobj = MyImage(description:item,image:"Hamburger")
            filteredmyimages.append(tmpobj)
        }*/
        print("Search is Pressed")
        shouldUpdateSearchResults = true;
        updateSearchResults(for: searchController)
        searchController.searchBar.resignFirstResponder() // close keyboard
    }
    
    

    
    override func viewWillAppear(_ animated: Bool){
        //print("viewWillAppear")
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //print("numberOfSections")
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numberOfRowsInSection")
        // #warning Incomplete implementation, return the number of rows
        return filteredmyimages.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("cellForRowAt")
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ImageTableViewCell
        // Configure the cell...
        cell.thumbnailImageView.contentMode = UIViewContentMode.scaleAspectFill
        cell.imageDescription.text = filteredmyimages[indexPath.row].description
        //cell.thumbnailImageView.image = UIImage(named:filteredmyimages[indexPath.row].image)
        cell.thumbnailImageView.image = UIImage(data: filteredmyimages[indexPath.row].image! as Data)
        return cell
    }

    
    
    /*
    func filterContentForSearchText(searchText: String){
        filteredmyimages = myimages.filter({ (myimage:MyImage) -> Bool in
            let nameMatch = myimage.description.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    */
    func updateSearchResults(for searchController: UISearchController) {
        /*
        print("updateSearchResults: "+searchController.searchBar.text!)
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }*/
        print("update")
        if(shouldUpdateSearchResults == true){
            print("Updating")
            /*
            for random in 1...30 {
                //let random = arc4random_uniform(20) + 10; // range between 10 and 30
                let tmpobj = MyImage(description: String(random), image: "Hamburger")
                filteredmyimages.append(tmpobj)
            }*/
            
            /*
            let url = NSURL(string: "http://api.fixer.io/latest?base=EUR")
            let task = URLSession.shared.dataTask(with: url! as URL) { (data,response,error) in
                if error != nil{
                    print("ERROR")
                }else{
                    if let content = data{
                        do{
                            // Array
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            //print(myJson)
                            if let rates = myJson["rates"] as? NSDictionary{
                                for (country, rate) in rates{
                                    let tmpobj = MyImage(description: country as! String, image: "Hamburger")
                                    self.filteredmyimages.append(tmpobj)
                                    //print(country)
                                }
                                
                            }
                        }catch{
                            
                        }
                    }
                }
                
            }
            task.resume()*/
            
            // synchrnous
            do{
                let url = URL(string: "http://api.fixer.io/latest?base=EUR")
                let html = try String(contentsOf: url!)
                if let data = html.data(using: String.Encoding.utf8) {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                        //print(json!)
                        if let rates = json?["rates"] as? NSDictionary{
                            //print(rates[searchController.searchBar.text])
                            //let tmpobj = MyImage(description: "\(rates[searchController.searchBar.text!])", image: "Hamburger")
                            //self.filteredmyimages.append(tmpobj)
                            
                            for (country, rate) in rates{
                                if(country as? String == searchController.searchBar.text){
                                    //var tmpimg = UIImage(named: "Hamburger")
                                    let tmpimg = UIImage(named: "Hamburger")
                                    let data = UIImageJPEGRepresentation(tmpimg!,1.0) as NSData?
                                    let tmpobj = MyImage(description: country as! String, image: data! as NSData)
                                    self.filteredmyimages.append(tmpobj)
                                }
                                //print(country)
                            }
                        }
                    } catch {
                        print("Something went wrong")
                    }
                }
            }catch{
                print("error")
            }
            
            
        }
        tableView.reloadData()
    }
 
 
 
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // build Action List
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.alert)
        // add action
        optionMenu.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        // display
        self.present(optionMenu, animated: true, completion: nil)
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    // Override to support editing the table view.
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            imageNames.remove(at: indexPath.row)
            print("Total item: \(imageNames.count)")
            for name in imageNames{
                print(name)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }*/
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //print("swipe button")
        let share = UITableViewRowAction(style: .default, title: "Share") {
            (action, indexPath) in
            // share item at indexPath
            let defaultText = "Just checking in at " + self.filteredmyimages[indexPath.row].description
            if let imageToShare = UIImage(data: self.filteredmyimages[indexPath.row].image as! Data){
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        share.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue:253.0/255.0, alpha:1.0)
        return [share]
    }
    /*
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //print("swipe button")
        let share = UITableViewRowAction(style: .default, title: "Share") {
            (action, indexPath) in
            // share item at indexPath
            let defaultText = "Just checking in at "
            if let imageToShare = UIImage(named: "Hamburger"){
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        share.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue:253.0/255.0, alpha:1.0)
        return [share]
    }*/
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("prepareforsegue")
        if segue.identifier == "showImageDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! imageDetailViewController
                //destinationController.imageImage = filteredmyimages[indexPath.row].image
                destinationController.imageImage = filteredmyimages[indexPath.row].image!
                destinationController.imageName = filteredmyimages[indexPath.row].description
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        //print("didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
