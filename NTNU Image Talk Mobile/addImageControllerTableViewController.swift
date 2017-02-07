//
//  addImageControllerTableViewController.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 25/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//

import UIKit
import CoreData
import SwiftHTTP
//import Alamofire

class addImageControllerTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var spin: UIActivityIndicatorView!
    
    //var spin:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var UploadBtnText: UIButton!
    @IBAction func UploadBtn(_ sender: UIButton) {
        if(UploadBtnText.currentTitle == "Done!"){
            let myAlert:UIAlertController = UIAlertController(title: "警告", message: "照片請勿重複上傳~", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay, Fine!", style: UIAlertActionStyle.default, handler: {action in print("Okay, Fine")})
            myAlert.addAction(action)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        
        
        if(self.imageView.image == nil){
            print("no pic exists!")
            let myAlert:UIAlertController = UIAlertController(title: "警告", message: "請選擇一張圖片!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay, Fine!", style: UIAlertActionStyle.default, handler: {action in print("Okay, Fine")})
            myAlert.addAction(action)
            self.present(myAlert, animated: true, completion: nil)
            return
        }
        
        self.spin.startAnimating()
        self.UploadBtnText.isEnabled = false
        DispatchQueue.global(qos: .background).async{
        // http request handling
        print("----------------------------------------------")
        
        
        /*activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()*/
        
        
        //{"Content-Disposition": "attachment; filename=hw1_input.jpg"}
        //let url = URL(string: "http://140.122.185.35:8000/api/caption")
        //let request = NSMutableURLRequest(url: url!)
        //let request = NSMutableURLRequest(url: url!, cachePolicy:.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        /*request.httpMethod = "PUT"
        let param = [
            "firstName" : "Tim",
            "lastName" : "Wan",
            "userId" : "g"
        ]
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 1.0) as NSData?
        if(imageData == nil){
            return;
        }
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary) as Data
        print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBB")
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data,response,error in
            
            if error != nil{
                print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
                print("error=\(error)")
                return
            }*/
            // You can print out response object
            /*print("****** response = \(response)")
        
            // Print out response body
            let responseString = NSString(data:data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            //var err: NSError?
            
            
            
        }
        task.resume()*/
        
        //request.setValue("attachment; filename=hw1_input.jpg", forHTTPHeaderField: "Content-Disposition")
        //let data = UIImageJPEGRepresentation(imageView.image!,1.0) as NSData!
        
        
        /*
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            print("god")
            if let data = data{
                let html = String(data: data, encoding: .utf8)
                print(html)
            }
        }
        dataTask.resume()*/
        var result = ""
        //spin.center = self.view.center
        //spin.activityIndicatorViewStyle = .whiteLarge
        //self.view.addSubview(spin)
        
        let semaphone = DispatchSemaphore(value: 0) // set signal
        
        
        //DispatchQueue.global(qos: .background).async{
        do {
            let imageData = UIImagePNGRepresentation(self.imageView.image!)
            //let dataImage = imageData?.base64EncodedString(options: .lineLength64Characters)
            
            //let data = UIImageJPEGRepresentation(imageView.image!,1.0)
            //let url = URL(fileURLWithPath: "/Users/wanshr-tze/Documents/dog.jpg")
            let opt = try HTTP.PUT("http://140.122.185.35:8000/api/caption", parameters: ["file": Upload(data:imageData!,fileName:"image.png", mimeType:"image/png")], headers: ["Content-Disposition": "attachment; filenameimage.png"])
            opt.start { response in
                if let error = response.error {
                    print("got an error: \(error)")
                    return
                }
                //print("=================")
                //print(response.description)
                let tmp:String = response.text!
                let len = tmp.characters.count
                for (i,v) in tmp.characters.enumerated(){
                    if(i > 0 && i < len-3){
                        result.append(v)
                    }
                }
                print(result)
                DispatchQueue.main.async {
                    self.spin.stopAnimating()
                    self.UploadBtnText.isEnabled = true
                    sender.setTitle("Done!", for: .normal)
                    
                }
                
                //print("=================")
                semaphone.signal() // unlock
            }
        } catch let error {
            print("got an error: \(error)")
            return
        }
        //}
        
        _ = semaphone.wait(timeout: DispatchTime.distantFuture) // door
        
        //return
        print("here")
        //{"Content-Disposition": "attachment; filename=hw1_input.jpg"}
        /*
        let headers: HTTPHeaders = [
            "Content-Disposition": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://140.122.185.35:8000/api/caption", headers: headers).responseJSON { response in
            debugPrint(response)
        }*/
        
        
        
        // store data to DB
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newRecord = NSEntityDescription.insertNewObject(forEntityName: "MyDBImages", into: context) as! MyDBImages
        newRecord.setValue(result, forKey: "descript")
        //newRecord.setValue("A boat floating on the surface of water", forKey: "descript")
        if let uploadImage = self.imageView.image{
            newRecord.image = UIImageJPEGRepresentation(uploadImage,1.0) as NSData?
        }
        //let uploadImage = UIImageJPEGRepresentation(imageView.image!, 1.0)
        do{
            try context.save()
            print("saved")
        }catch{
            // process error
            
        }
        
        // change button text
        //sender.setTitle("Done!", for: .normal)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData{
        let body = NSMutableData()
        if parameters != nil{
            for(key,value) in parameters! {
                //body.append(Data("--\(boundary)\r\n".utf8))
                //body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                //body.append(Data("\(value)\r\n".utf8))
                body.appendString(string: "--\(boundary)\r\n")
                
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        let filename = "user-profile.jpg"
        let mimetype = "image/type"
        
        body.appendString(string: "--\(boundary)\r\n")
        //{"Content-Disposition": "attachment; filename=hw1_input.jpg"}

        body.appendString(string: "Content-Disposition: attachment; filename=\"\(filename)\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        //body.append(Data("--\(boundary)\r\n".utf8))
        //body.append(Data("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".utf8))
        //body.append(Data("Content-Type: \(mimetype)\r\n\r\n".utf8))
        //body.append(imageDataKey as Data)
        //body.append(Data("\r\n".utf8))
        //body.append(Data("--\(boundary)--\r\n".utf8))
        return body;
    }
    
    
    func generateBoundaryString() -> String{
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spin.stopAnimating()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("here")
        if(indexPath.row == 0){
            if(imageView.image == nil){
            let myAlert:UIAlertController = UIAlertController(title: "警告", message: "請選擇一張圖片!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Select from library", style: UIAlertActionStyle.default, handler: {action in
                    if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.allowsEditing = false
                        imagePicker.sourceType = .photoLibrary // optional: .camera
                        self.present(imagePicker, animated: true, completion: nil)
                        //
                        self.UploadBtnText.setTitle("Upload", for: .normal)
                    }
                }
            )
            let action2 = UIAlertAction(title: "Take a Photo", style: UIAlertActionStyle.default, handler: {action2 in
                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                    // open interface
                    self.present(imagePicker, animated: true, completion: nil)
                    self.UploadBtnText.setTitle("Upload", for: .normal)
                }else{
                    print("camera is unavailable")
                }
            }
            )
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            myAlert.addAction(action)
            myAlert.addAction(action2)
            myAlert.addAction(cancelAction)
            self.present(myAlert, animated: true, completion: nil)
            
            }}
        
        tableView.deselectRow(at: indexPath, animated: true)
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

extension NSMutableData{
    func appendString(string: String){
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
