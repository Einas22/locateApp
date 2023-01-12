//
//  Share.swift
//  locate
//
//  Created by Einas Alturki on 18/06/1444 AH.
//

import SwiftUI
import UIKit
import Combine

struct Share: View {
    
   // @State private var phoneNumber2 : String = ""
    @State var name : String// = ""
    @State var link : String// = ""
    @State var photo : UIImage// = UIImage(named: "logo")!
    @State var linkDescription : String //= ""
    @State var showWarning : Bool = false
    @State var phoneNumber = ""
    @State var y : CGFloat = 50
    @State var countryCode = ""
    @State var countryFlag = ""
    @State var showCountryCode : Bool = false
    
//
//
    var body: some View {
           
        NavigationView{
            ZStack{
                
                Image("bg")
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                
                
                VStack{
                    
                    
                    Text("Share your Location")
                        .font(.headline)
                        .foregroundColor(Color.theme.main)
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 150)
                            .foregroundColor(Color.theme.white)
                            .overlay(
                                RoundedRectangle(cornerRadius:25)
                                    .stroke(Color.theme.black)
                            )
                            .shadow(radius: 2, x: 0, y: 1)
                        
                        
                        
                        
                        
                        HStack(alignment: .center){
                            
                            Image(uiImage: photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 60)
                            
                            Image("line")
                                .resizable()
                                .frame( height: 120)
                                .scaledToFit()
                            
                            
                            
                            VStack(alignment: .leading){
                                
                                Text(name)
                                    .modifier(HeaderTitleModifier())
                                    .padding(.bottom, 3)
                                Text(link)
                                    .modifier(SubTitleModifier())
                            }
                            .padding()
                            
                            ShareLink(item: Image(uiImage: photo), subject: Text("\(link)"), preview:
                                        SharePreview (link, image: Image(uiImage: photo))){
                                Label("",systemImage:"square.and.arrow.up")
                            }
                            
                            
                        }
                        
                        
                        
                    }
                    
                    VStack{
                        Text("Enter number to send location by WhatsApp:")
                        
                        ZStack {
                            HStack  {
                                Text(countryCode.isEmpty ? "🇸🇦 966" : "\(countryFlag) +\(countryCode)")
                                    .frame(width: 100, height: 50)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor(countryCode.isEmpty ? .secondary : .black)
                                    .onTapGesture {
                                        showCountryCode.toggle()
                                        withAnimation (.spring()) {
                                            self.y = 0
                                        }
                                }
                                TextField("Phone Number", text: $phoneNumber)
                                    .padding()
                                    .frame(width: 240, height: 50)
                                    .keyboardType(.phonePad)
                                    .onReceive(Just(phoneNumber)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.phoneNumber = filtered
                                        }
                                    }
                            }.padding()
                            
                            if showCountryCode {
                                CountryCodes(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
                                    .offset(y: y)
                            }
                            
                            
                            RoundedRectangle(cornerRadius: 10).stroke()
                            .frame(width: 340, height: 50)
                        }
                        
                        
                        
                    }
                    .padding()
                    
                    Button(action:{
                        if !phoneNumber.isEmpty
                        {
                            ShareBtn(phoneNumber : phoneNumber, link: link)
                        }
                        else {
                            showWarning.toggle()
                        }
                    }
                           ,label: {
                        Text("Send")
                            //.modifier(ButtonModifier())
                            .frame(minWidth: 0, maxWidth:320)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding()
                            .background(enteredValidNumber() ? Color.theme.main : Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 40)
//                                    .stroke(Color.theme.black, lineWidth: 2)
//                            )
                            .shadow(radius: 2, x: 0, y: 1)
                        
                        
                        
                    })
                    .disabled(!enteredValidNumber())
                    .padding(.bottom, 300)
                }
                
            }//End ZStack bg
        }//End Navigation
    }//End Body
    
    func enteredValidNumber() -> Bool{
        if phoneNumber.count >= 9 {
            return true
        }
        return false
    }
    
    func ShareBtn(phoneNumber : String, link: String ){
        let countryCode = "966" //Country Code
        let phoneNumber = phoneNumber //Mobile number
        let link = link 
        

        // 1
        let urlWhats = "https://wa.me/\(countryCode)\(phoneNumber)/?text=\(link)"
        // 2
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
          // 3
          if let whatsappURL = NSURL(string: urlString) {
            // 4
            if UIApplication.shared.canOpenURL(whatsappURL as URL) {
              // 5
              UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: nil)
            } else {
              // 6
              print("Cannot Open Whatsapp")
            }
          }
        }

    }
}

//struct Share_Previews: PreviewProvider {
//    static var previews: some View {
//        Share(name: String, link: String, photo: UIImage, linkDescription: String).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
