////
////  ShareViewModel.swift
////  locate
////
////  Created by Einas Alturki on 20/06/1444 AH.
////
//
//import SwiftUI
//import Combine
//
//struct Photo: Transferable {
//    static var transferRepresentation: some TransferRepresentation {
//        ProxyRepresentation(exporting: \.image)
//    }
//    public var image: Image
//    public var caption: String
//}
//
//class ShareViewModel: ObservableObject {
//   
//    @Published var name : String = ""
//    @Published var link : String = ""
//    @Published var photo : UIImage = UIImage(named: "logo")!
//    @Published var linkDescription : String = ""
//    @Published var showWarning : Bool = false
//    @Published var phoneNumber = ""
//    @Published var y : CGFloat = 50
//    @Published var countryCode = ""
//    @Published var countryFlag = ""
//    @Published var showCountryCode : Bool = false
//    
////    init(){
////
////    }
//    
//    func enteredValidNumber() -> Bool{
//        if phoneNumber.count >= 9 {
//            return true
//        }
//        return false
//    }
//    
//    func ShareBtn(phoneNumber : String, link: String ){
//        let countryCode = "966" //Country Code
//        let phoneNumber = phoneNumber //Mobile number
//        let link = link
//        
//
//        // 1
//        let urlWhats = "https://wa.me/\(countryCode)\(phoneNumber)/?text=\(link)"
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
//
//
