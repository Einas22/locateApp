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
    //@State var code = ""
    //@ObservedObject var codeTextField = ObservableTextField()
    //@StateObject var vm = CountryCode()
    @State var frameSize = UIScreen.main.bounds.width
//
   // @StateObject var vm = ShareViewModel()
    
    @Binding var isPresented : Bool

    
    var body: some View {
           
        NavigationView{
            GeometryReader { geo in
                 
                VStack{
                    //Sheet Title
                    HStack{
                        Text("Share")
                        Text( name)
                        Text("Location")
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.main)
                    .accessibilityLabel("Share \( name) Location")
                    
                    VStack(alignment: .leading) {
                        
                        HStack{
                            //image of the location
                            Image(uiImage:  photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 60)
                                .accessibilityLabel("\( name) Photo")
                       
                            //divider for design
                            Image("line")
                                .resizable()
                                .frame( height: 80)
                                .scaledToFit()
                                .accessibilityHidden(true)
                            
                            //Location Title
                            //house number
                            //location Description
                            VStack(alignment: .leading){
                                
                                Text(name)
                                    .modifier(HeaderTitleModifier())
                                    .padding(.bottom, 3)
                                    .accessibilityLabel("\(name) Location")
                                
                                Text(houseNumber)
                                    .modifier(SubTitleModifier())
                                    .accessibilityLabel("House Number \(houseNumber)")
                                
                                Text(linkDescription)
                                    .modifier(SubTitleModifier())
                                    .accessibilityLabel(linkDescription)
                                
                            }
                            .padding(.horizontal)
                            
                            //IOS Share Button
                            
                            //message: Text("\(link)"),
                            
                            //                            ShareLink(item: Image(uiImage: photo) ,message: Text("\(link)"),
                            //                                      preview:
                            //                                        SharePreview (link, image: Image(uiImage: photo))){
                            //                                Label("",systemImage:"square.and.arrow.up")
                            ShareLink(item: Image(uiImage:  photo), subject: Text("\( link)\(houseNumber)"), preview:
                                        SharePreview ( link, image: Image(uiImage:  photo))){
                                Label("",systemImage:"square.and.arrow.up")
                            }
                                        .foregroundColor(Color.theme.main)
                                        .fontWeight(.bold)
                                        .accessibilityLabel("Share Link")
                        }//End HStack for location card
                       
                        //Location Link
                        VStack(alignment: .leading){
                            
                            Text("Location Link:")
                                .foregroundColor(Color.theme.main)
                            
                            Text( link)
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("Location Link")
                        }
                    }
                    .frame(width: (frameSize - 40), height: 180)
                    .foregroundColor(Color.theme.white)
                    .overlay(
                        RoundedRectangle(cornerRadius:25)
                            .stroke(Color.theme.black)
                    )
                    .shadow(color:Color.theme.main.opacity(0.3),
                        radius: 3, x: 0, y: 3)
                
                .accessibilityElement(children: .combine)
                    
                    
                    VStack{
                        Text("Enter number to send location by WhatsApp:")
                            .padding(.bottom)
                        
                        //Phone NUmber
                        //flag + CountryCode + textfield for number
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
                    .padding(.top)
                    
                    //the ZStack for the button and the calling of the menu of the flag and country code
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
        let countryCode = countryCode
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
    
//    func shareLocationWithPhoto() -> Photo {
//        let imgToShare = Photo(image: Image(uiImage: photo), caption: link)
//        return imgToShare
//    }
}

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(name: "Home",
              link: "https://maps.gooogle.com",
              houseNumber: "b-16",
              photo:  UIImage( systemName:"mappin.and.ellipse" )!,
              linkDescription: "test",
              isPresented: .constant(false))
        
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
