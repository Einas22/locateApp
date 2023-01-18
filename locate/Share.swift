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
   // @State var y : CGFloat = 50
    //@State var countryCode = ""
   // @State var countryFlag = ""
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
                    
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center){
                            
                            Image(uiImage:  photo)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 60)
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
                            .padding(.horizontal)
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
                                        .accessibilityLabel("Share Link button")
                        }
                        
                        Text( link)
                            .modifier(SubTitleModifier())
                            .accessibilityLabel("Location Link")
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
                    .padding(.top)
                    
                    Button(action:{
                        if !phoneNumber.isEmpty
                        {
                            ShareBtn()
                        }
                    }
                           ,label: {
                        Text("Send")
                        //.modifier(ButtonModifier())
                            .frame(width: (frameSize - 40), height: 50)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .background(enteredValidNumber() ? Color.theme.main : Color.gray)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .shadow(radius: 2, x: 0, y: 1)
                            .padding(10)
                        
                    })
                    .disabled(!enteredValidNumber())
                    
                    .accessibilityLabel("Send")
                    
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
                    .padding(.horizontal)
             
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
        let countryCode = codeTextField.value
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

struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share(name: "Home",
              link: "https://maps.gooogle.com",
              houseNumber: "b-16",
              photo:  UIImage( systemName:"mappin.and.ellipse" )!,
              linkDescription: "test" ,
              isPresented: .constant(false))
        
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
