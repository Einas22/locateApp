//
//  Share.swift
//  locate
//
//  Created by Einas Alturki on 18/06/1444 AH.
//

import SwiftUI
import UIKit
import Combine

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
    public var image: Image
    public var caption: String
}

struct Share: View {
    
    @State private var phoneNumber2 : String = ""
    @State var name : String //= ""
    @State var link : String //= ""
    @State var houseNumber : String
    @State var photo : UIImage //= UIImage(named: "logo")!
    @State var linkDescription : String //= ""
    @State var showWarning : Bool = false
    @State var phoneNumber = ""
    @State var y : CGFloat = 50
    @State var countryCode = ""
    @State var countryFlag = ""
    @State var showCountryCode : Bool = false
//
   // @StateObject var vm = ShareViewModel()
    
    @Binding var isPresented : Bool

    
    var body: some View {
           
        NavigationView{
            GeometryReader { geo in
              //  ZStack{
                    
                    //                Image("bg")
                    //                    .ignoresSafeArea()
                    //                    .accessibilityHidden(true)
                    
                    
                    
                VStack{
                    
                    HStack{
                        Text("Share")
                        Text( name)
                        Text("Location")
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.main)
                    .accessibilityLabel("Share \( name) Location")
                    
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 350, height: 150)
                            .foregroundColor(Color.theme.white)
                            .overlay(
                                RoundedRectangle(cornerRadius:25)
                                    .stroke(Color.theme.black)
                            )
                            .shadow(radius: 2, x: 0, y: 1)
                            .accessibilityHidden(true)
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .center){
                                
                                Image(uiImage:  photo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 60)
                                    .accessibilityLabel("\( name) Photo")
                                
                                Image("line")
                                    .resizable()
                                    .frame( height: 80)
                                    .scaledToFit()
                                    .accessibilityHidden(true)
                                
                                VStack(alignment: .leading){
                                    
                                    Text( name)
                                        .modifier(HeaderTitleModifier())
                                        .padding(.bottom, 3)
                                        .accessibilityLabel("\( name) Location")
                                    
                                    Text( houseNumber)
                                        .modifier(SubTitleModifier())
                                        .accessibilityLabel("House Number \( houseNumber)")
                                    
                                    
                                }
                                //.padding()
                                //message: Text("\(link)"),
                                
                                //                            ShareLink(item: Image(uiImage: photo) ,message: Text("\(link)"),
                                //                                      preview:
                                //                                        SharePreview (link, image: Image(uiImage: photo))){
                                //                                Label("",systemImage:"square.and.arrow.up")
                                ShareLink(item: Image(uiImage:  photo), subject: Text("\( link)"), preview:
                                            SharePreview ( link, image: Image(uiImage:  photo))){
                                    Label("",systemImage:"square.and.arrow.up")
                                }
                                            .accessibilityLabel("Share Link button")
                            }
                            
                            Text( link)
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("Location Link")
                        }
                    }
                    
                    VStack{
                        Text("Enter number to send location by WhatsApp:")
                        
                        ZStack {
                            HStack  {
                                Text( countryCode.isEmpty ? "🇸🇦 966" : "\( countryFlag) +\( countryCode)")
                                    .frame(width: 100, height: 50)
                                    .background(Color.secondary.opacity(0.2))
                                    .cornerRadius(10)
                                    .foregroundColor( countryCode.isEmpty ? .secondary : .black)
                                    .onTapGesture {
                                        showCountryCode.toggle()
                                        withAnimation (.spring()) {
                                            self.y = 0
                                        }
                                        
                                    }.accessibilityLabel("Country Code")
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .padding()
                                    .frame(width: 240, height: 50)
                                    .keyboardType(.phonePad)
                                    .onReceive(Just(phoneNumber)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.phoneNumber = filtered
                                        }
                                    }.accessibilityLabel("Phone Number")
                            }.padding()
                            
                            
                            
                            RoundedRectangle(cornerRadius: 10).stroke()
                                .frame(width: 340, height: 50)
                        }
                        
                        
                    }
                    .padding()
                    ZStack{
                    Button(action:{
                        if !phoneNumber.isEmpty
                        {
                            ShareBtn()
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
                    //.padding(.bottom, 300)
                    .accessibilityLabel("Send")
                    if showCountryCode {
                        CountryCodes(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
                        //.offset(y: y)
                        // .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).maxY - 150)
                    }
                }
                        Spacer()
                        
                            .toolbar{
                                ToolbarItem(placement: .cancellationAction) {
                                    Button(action: { isPresented.toggle() }
                                           , label: {
                                        Image(systemName: "x.circle")
                                    })
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.theme.main)
                                }
                            }.accessibilityLabel("close")
                    }
                    .ignoresSafeArea(.container)
                    .padding(.top,15)
             //   }//End ZStack
            }
        }//End Navigation
    }//End Body
    
    func enteredValidNumber() -> Bool{
        if phoneNumber.count >= 9 {
            return true
        }
        return false
    }
    
    func ShareBtn(){
        let HouseNumber = "House Number"
        let phoneNumber = phoneNumber //Mobile number
        let link = link
        //"\(link ?? "") %0A<img src="\(photo ?? "")" alt="\(Image("logo"))" width="500" height="600">"
        

        // 1
        let urlWhats = "https://wa.me/\(countryCode)\(phoneNumber)/?text=\(link)   \(HouseNumber)  \(houseNumber)"
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
    
    func shareLocationWithPhoto() -> Photo {
        let imgToShare = Photo(image: Image(uiImage: photo), caption: link)
        return imgToShare
    }
}

//struct Share_Previews: PreviewProvider {
//    static var previews: some View {
//        Share(name: String, link: String, photo: UIImage, linkDescription: String).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
