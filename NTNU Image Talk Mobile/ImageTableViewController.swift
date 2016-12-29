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
    var myimages:[MyImage] = [
        MyImage(description:"Cafe Deadend", image:"Hamburger"),
        MyImage(description:"Homei", image:"Hamburger2"),
        MyImage(description:"Traif", image:"Hamburger3")
    ]
    var filteredmyimages = [MyImage]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // clean NavigationBar tint
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil)
        configureSearchController()
    }
    
    
    
    func configureSearchController() {
        print("configureSearchController")
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
        print("Begin Editing")
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel!")
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search is Pressed")
        shouldShowSearchResults = true
        self.tableView.reloadData()
        //searchController.searchBar.resignFirstResponder() // close keyboard
    }
    
    

    
    override func viewWillAppear(_ animated: Bool){
        print("viewWillAppear")
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections")
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection")
        // #warning Incomplete implementation, return the number of rows
        if(shouldShowSearchResults){
            return filteredmyimages.count
        }
        else {
            return myimages.count
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ImageTableViewCell
        // Configure the cell...
        cell.thumbnailImageView.contentMode = UIViewContentMode.scaleAspectFill
        if(shouldShowSearchResults){
            cell.imageDescription.text = filteredmyimages[indexPath.row].description
            cell.thumbnailImageView.image = UIImage(named:filteredmyimages[indexPath.row].image)
        }
        else {
            cell.imageDescription.text = myimages[indexPath.row].description
            cell.thumbnailImageView.image = UIImage(named:myimages[indexPath.row].image)
        }
        return cell
    }

    
    
    
    func filterContentForSearchText(searchText: String){
        filteredmyimages = myimages.filter({ (myimage:MyImage) -> Bool in
            let nameMatch = myimage.description.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
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
        print("swipe button")
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
        print("prepareforsegue")
        if segue.identifier == "showImageDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! imageDetailViewController
                if(shouldShowSearchResults){
                    destinationController.imageImage = filteredmyimages[indexPath.row].image
                    destinationController.imageName = filteredmyimages[indexPath.row].description
                }else{
                    destinationController.imageImage = myimages[indexPath.row].image
                    destinationController.imageName = myimages[indexPath.row].description
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning")
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
