//
//  ImageTableViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit


class ImageTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate{
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
    
    }
    var imageNames = ["Cafe Deadend","Homei","xox","oxo"]
    //var searchController:UISearchController!
    var filteredImageNames = [String]()
    var resultSearchController = UISearchController()
    //var mysearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // clean NavigationBar tint
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil)
        
        
        
        
        self.resultSearchController = UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater = self
        
        self.resultSearchController.dimsBackgroundDuringPresentation = false
        self.resultSearchController.searchBar.sizeToFit()
        self.resultSearchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.tableView.tableHeaderView = self.resultSearchController.searchBar
        self.tableView.reloadData()
        //searchController = UISearchController(searchResultsController: nil)
        //tableView.tableHeaderView = searchController.searchBar
        //self.searchController.delegate = self;
        
        
        //navigationItem.titleView = searchBar
        //self.resultSearchController.searchBar = searchBar()
        //resultSearchController.searchBar = self
        //var searchBar = self.resultSearchController.searchBar
        //mysearchBar.delegate = self
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("xxx")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print("Press Search Button")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        print("Press")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.resultSearchController.isActive){
            return self.filteredImageNames.count
        }else{
            return imageNames.count
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ImageTableViewCell
        
        // Configure the cell...
        cell.thumbnailImageView.contentMode = UIViewContentMode.scaleAspectFill
        if(self.resultSearchController.isActive){
            cell.imageDescription.text = self.filteredImageNames[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: "Hamburger.jpg")
        }else{
            cell.imageDescription.text = imageNames[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: "Hamburger.jpg")
        }
        return cell
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        self.filteredImageNames.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        //let array = (self.imageNames as NSArray).filterArrayUsingPredicate(searchPredicate)
        let array = imageNames.filter { searchPredicate.evaluate(with: $0) }
        self.filteredImageNames = array 
        self.tableView.reloadData()
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
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImageDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! imageDetailViewController
                if(self.resultSearchController.isActive){
                    destinationController.imageName = filteredImageNames[indexPath.row]
                }else{
                    destinationController.imageImage = "Hamburger"
                    destinationController.imageName = imageNames[indexPath.row]
                    
                }
                
                
            }
        }
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
/*
extension ImageTableViewController: UISearchBarDelegate{
    func searchBar(searchBar: UISearchBar,searchBarSearchButtonClicked selectedScope: Int){
        print("hello")
    }
}*/
