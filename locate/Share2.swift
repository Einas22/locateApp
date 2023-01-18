//
//  Share.swift
//  locate
//
//  Created by Einas Alturki on 18/06/1444 AH.
//

import SwiftUI
import UIKit
import Combine

struct Share2: View {
    
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
    @State var code = ""
    @ObservedObject var codeTextField = ObservableTextField()
    @StateObject var vm = CountryCode()
    @State var frameSize = UIScreen.main.bounds.width
//
   // @StateObject var vm = ShareViewModel()
    
    @Binding var isPresented : Bool

    
    var body: some View {
           
        NavigationView{
            GeometryReader { geo in
        
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
                            RoundedRectangle(cornerRadius: 10).stroke()
                                .frame(width: (frameSize - 40), height: 50)
                            HStack (spacing: 0) {
                                HStack (spacing: 0) {
                                    Text("\(vm.flag(country: vm.getCountryCode(codeTextField.value)))")
                                        .frame(width: 48, height: 50)
                                    
                                    TextField("966", text: $codeTextField.value)
                                        .keyboardType(.phonePad)
                                        .frame(width: 40, height: 50)
                                        
                                }
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(10)
                                
                                TextField("Phone Number", text: $phoneNumber)
                                    .padding()
                                    .frame(width: (frameSize - 130), height: 50)
                                    .keyboardType(.phonePad)
                                
                            }
                            
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
    
//    func shareLocationWithPhoto() -> Photo {
//        let imgToShare = Photo(image: Image(uiImage: photo), caption: link)
//        return imgToShare
//    }
}

struct Share2_Previews: PreviewProvider {
    static var previews: some View {
        Share2(name: "Home",
              link: "https://maps.gooogle.com",
              houseNumber: "b-16",
              photo:  UIImage( systemName:"mappin.and.ellipse" )!,
              linkDescription: "test" ,
              isPresented: .constant(false))
        
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
