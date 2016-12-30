//
//  MyImage.swift
//  NTNU Image Talk Mobile
//
//  Created by WAN SHR-TZE on 24/12/2016.
//  Copyright © 2016 WAN SHR-TZE. All rights reserved.
//
// OOP practice
//import CoreData
import Foundation

class MyImage{
    var description = ""
    //var image = ""
    var image: NSData?
    
    /*
    init(description:String,image:String){
        self.description = description
        self.image = image
    }*/
    init(description:String,image:NSData){
        self.description = description
        self.image = image
    }
}

/*
class MyDBImage:NSManagedObject{
    @NSManaged var descript: String
    @NSManaged var image: NSData?
}*/
