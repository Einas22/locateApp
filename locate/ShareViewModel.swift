////
////  ShareViewModel.swift
////  locate
////
////  Created by Einas Alturki on 24/06/1444 AH.
////
//
//import Foundation
//import UIKit
//import SwiftUI
//
//class ShareViewModel : ObservableObject {
//    @Published var name : String // = ""
//    @Published var link : String //= ""
//    @Published var houseNumber : String //= ""
//    @Published var photo : UIImage //= UIImage(named: "logo")!
//    @Published var linkDescription : String //= ""
//    @Published var showWarning : Bool = false
//    @Published var phoneNumber = ""
//    @Published var y : CGFloat = 50
//    @Published var countryCode = ""
//    @Published var countryFlag = ""
//    @Published var showCountryCode : Bool = false
//    
//    init(){
//        
//        self.name = ""
//        self.link = ""
//        self.houseNumber = ""
//        self.linkDescription = ""
//        self.photo = UIImage(named: "logo")!
//        
//    }
//    
//    func enteredValidNumber() -> Bool{
//        if phoneNumber.count >= 9 {
//            return true
//        }
//        return false
//    }
//    
//    func ShareBtn(){
//        let HouseNumber = "House Number"
//        let phoneNumber = phoneNumber //Mobile number
//        let link = link
//        //"\(link ?? "") %0A<img src="\(photo ?? "")" alt="\(Image("logo"))" width="500" height="600">"
//        
//
//        // 1
//        let urlWhats = "https://wa.me/\(countryCode)\(phoneNumber)/?text=\(link)   \(HouseNumber)  \(houseNumber)"
//        // 2
//        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
//          // 3
//          if let whatsappURL = NSURL(string: urlString) {
//            // 4
//            if UIApplication.shared.canOpenURL(whatsappURL as URL) {
//              // 5
//              UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
//            } else {
//              // 6
//              print("Cannot Open Whatsapp")
//            }
//          }
//        }
//
//    }
//    
//    func shareLocationWithPhoto() -> Photo {
//        let imgToShare = Photo(image: Image(uiImage: photo), caption: link)
//        return imgToShare
//    }
//}
