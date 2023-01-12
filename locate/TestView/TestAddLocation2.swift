//
//  TestAddLocation2.swift
//  locate
//
//  Created by Einas Alturki on 19/06/1444 AH.
//

import SwiftUI

struct TestAddLocation2: View {
    
    @State private var image: UIImage?
    @State private var isShowingImagePicker: Bool = false
    @State var isImageSelected: Bool?
    @State private var LocationName: String = ""
    @State private var LocationLink: String = ""
    @State private var LocationDescription: String = ""
    
    //@State var isPresent = false
    @State var showButton: Bool = false
    
    var body: some View {
        NavigationView{
           
            VStack(alignment: .leading){
                
//                HStack{
//
//                    Text("Add New Location")
//                        .modifier(HeaderTitleModifier())
//                    Spacer()
//
//                    Button{
//                        presentationMode.wrappedValue.dismiss()
//                    } label: {
//                        Image(systemName: "x.circle")
//                            .imageScale(.large)
//                            .foregroundColor(Color.theme.main)
//                    }
//
//                }//End of HStack Create new
//                .padding(.leading)
//                Divider()
               
                HStack{
                    Text("Location Photo")
                    
                        .foregroundColor(Color.theme.main)
                    
                        .sheet(isPresented: $isShowingImagePicker, onDismiss: nil){
                            ImagePicker(image: $image, isImageSelected: $isImageSelected)
                        }
                    
                    ZStack{
                        VStack{
                            if isImageSelected == true {
                                Image(uiImage: image!)
                                    .resizable()
                                    .frame(width:150, height: 100)
                                    .cornerRadius(10)
                            }
                            
                            else {
                                Button{
                                    
                                    isShowingImagePicker = true
                                }label: {
                                    
                                    VStack {
                                        
                                        Image(systemName:"photo.on.rectangle")
                                            .font(.largeTitle)
                                            .foregroundColor(.gray)
                                            .padding(.bottom)
                                        
                                        
                                        Text("Select a Photo")
                                            .foregroundColor(.gray)
                                        
                                    }
                                }
                            }
                            
                        }
                        //Location Photo
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.black, lineWidth:3)
                            .foregroundColor(Color.init(UIColor.lightGray).opacity(0.55))
                            .frame(width:150, height: 100)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        
                    }//End of ZStack for photo picker
                }
                
                Text("Location Name:")
                    .modifier(SubTitleModifier())
                
                TextField("Location Name:",text: $LocationName)
                    .modifier(TextFieldModifier())
                
                Text("Location Link:")
                    .modifier(SubTitleModifier())
                
                
                
                TextField("Location Link:",text: $LocationLink)
                    .modifier(TextFieldModifier())
                
                
                Text("Description:")
                    .modifier(SubTitleModifier())
               
                
                
                TextField("Neighborhood name - City - House number",
                          text: $LocationDescription)
                .modifier(TextFieldModifier())
                

                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel", action: { print("Cancel") })
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add", action: { print("Add") })
                            .disabled(LocationLink.count <= 10)
                    }
                }
                
                .foregroundColor(Color.theme.main)
                .navigationTitle("Add New Location")
                .navigationBarTitleDisplayMode(.inline)
                Spacer()
                
            }//End VStack
            
            .padding(.leading, 55)
            .padding(.trailing,55)
            
            
         
           
        }//End Navigation
    }
}

struct TestAddLocation2_Previews: PreviewProvider {
    static var previews: some View {
        TestAddLocation2()
    }
}
