//
//  ImageLoader.swift
//  TripAndJourney
//
//  Created by devtolife on 12.09.21.
//


import Foundation
import UIKit
class ImageLoader: ObservableObject{
    
    @Published var uiimage: UIImage = UIImage()
   
    init(){
 
    }
    
    func loadImageFromURL(str:String)->UIImage{
       
           let url:URL = URL(string: str)!
           let dat:Data = try! Data(contentsOf: url)
        uiimage = UIImage(data: dat) ?? UIImage(systemName: "citytemp")!
           return uiimage
      }
}

