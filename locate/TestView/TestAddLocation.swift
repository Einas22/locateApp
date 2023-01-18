//
//  TestAddLocation.swift
//  locate
//
//  Created by Einas Alturki on 18/06/1444 AH.
//

import SwiftUI

struct TestAddLocation: View {
    @Environment(\.managedObjectContext) var moc
       @Environment(\.dismiss) var dismiss
       
    @State private var image: UIImage?
    @State private var isShowingImagePicker: Bool = false
    @State var isImageSelected: Bool?
       @State private var title = ""
       @State private var img: Data? = nil
   //    @State private var img = UIImage?
     //  let book: Book = Book()

       
       //    @State private var coverimg : UIImage
       
       //for img picker
       @State private var ispickerShowing = false
       @State private var selectedImage: UIImage?
       
   //    let imageData = img.jpegData(compressionQuality: 0.1)

    var body: some View {
        NavigationView {
                   
                   
                   VStack{
                       Text("Add New Location")
                           .foregroundColor(Color.red)
                           .font(.system(size: 40))
                           //.fontDesign(.serif)
                           .padding()
                           .padding(.top, 30)
                       
                       
                       HStack{
                           VStack{
                               
                               if selectedImage != nil {
                                   Image(uiImage: selectedImage! )
                                       .resizable()
                                       .frame(width: 106, height: 150)
                                       .padding(.trailing, 2.0)
                                       .shadow(radius: 4, x: 0, y: 2)

                                   
                                   
                               }
                               else {
                                   
                                   
                                   Image("logo")
                                       .resizable()
                                       .frame(width: 106, height: 150)
                                       .shadow(radius: 4, x: 0, y: 2)
                                       .padding()
                               }
                           }
                           
                           VStack {
                               
                               
                               TextField("Name your book", text: $title)
                                   .foregroundColor(Color.black)
                                   .frame(width: 200,height: 45)
                                   .background(Color.blue)
                                   .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                   .shadow(radius: 4, x: 0, y: 2)
                               
                               Button {
                                   ispickerShowing = true
                                   
                                   
                               } label: {
                                   
                                   
                                   Text("Cover")
                                       .font(.headline)
                                       .foregroundColor(Color.black)
                                       .frame(width: 200,height: 45)
                                       .background(Color.orange)
                                   
                                   
                                       .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                   
                                   //imgPicker
                                       .sheet(isPresented: $isShowingImagePicker, onDismiss: nil){
                                           ImagePicker(image: $image, isImageSelected: $isImageSelected)
                                       }
                                   
                               }
                               
                               
                           }
                       }
                       
                       VStack{
                           
                           Button("Create") {
                               print("test")
                           }
                           .foregroundColor(Color.red)
                           .frame(width: 200,height: 45)
                           .background(Color.blue)
                           .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                           .shadow(radius: 4, x: 0, y: 2)
                           .padding()
                           
                       }
                       Spacer()
                       
                   }
               }
    }
}

struct TestAddLocation_Previews: PreviewProvider {
    static var previews: some View {
        TestAddLocation()
    }
}
