//
//  AddLocation.swift
//  locate
//
//  Created by Einas Alturki on 16/06/1444 AH.
//

import SwiftUI

struct AddLocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var image: UIImage?
    @State private var isShowingImagePicker: Bool = false
    @State var isImageSelected: Bool?
    @State private var LocationName: String = ""
    @State private var HouseNumber: String = ""
    @State private var LocationLink: String = ""
    @State private var LocationDescription: String = ""
    
    //@State var isPresent = false
    @State var showButton: Bool = false
    
    /// Callback after user selects to add contact with given name and image.
    let onAdd: ((String, String, String, String, UIImage? , Date) -> Void)?
    /// Callback after user cancels.
    let onCancel: (() -> Void)?

    let Currenttime = Date()
    
    var body: some View {
       
        NavigationView{
            ZStack{
                
                Image("bg")
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                
                VStack(alignment: .leading){
                    
                    
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
                        
                    }.accessibilityLabel("Choose Photo From Library")
                    
                    // 1- Location Name
                    Text("Location Name:")
                        .modifier(SubTitleModifier())
                    TextField("Location Name",text: $LocationName)
                        .modifier(TextFieldModifier())
                        .accessibilityLabel("Enter Location Name")
                    
                    // 2- Location Link
                    Text("*Location Link:")
                        .modifier(SubTitleModifier())
                    TextField("Location Link",text: $LocationLink)
                        .modifier(TextFieldModifier())
                        .accessibilityLabel("Enter Location Link")
                    
                    // 3- House Number
                    Text("House Number:")
                        .modifier(SubTitleModifier())
                    TextField("House Number",text: $HouseNumber)
                        .modifier(TextFieldModifier())
                        .accessibilityLabel("Enter House Number")
                    
                    // 4- Location Description
                    Text("Description:")
                        .modifier(SubTitleModifier())
                    TextField("Neighborhood name - City",
                              text: $LocationDescription)
                    .modifier(TextFieldModifier())
                    .accessibilityLabel("Enter Description Neighborhood name - city")
                    
                    
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel", action: { onCancel?() })
                                .fontWeight(.bold)
                                .foregroundColor(Color.theme.main)
                        }
                    }.accessibilityLabel("Cancel")
                    
                    .toolbar{
                        ToolbarItem(placement: .confirmationAction) {
                            Button(action: {
                                if !LocationLink.isEmpty {
                                    onAdd?(LocationName,
                                           LocationLink,
                                           HouseNumber,
                                           LocationDescription,
                                           image ?? UIImage(named: "logo")!, Currenttime)
                                }
                            } ,label: {
                                Text("Add")
                                .fontWeight(.bold)
                                .foregroundColor(enteredValidLink() ? Color.theme.main : Color.gray)
                            })
                            .disabled(!enteredValidLink())
                                
                        }
                    }.accessibilityLabel("Add Location")
                    
                    
                    .navigationTitle("Add New Location")
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .accessibilityLabel("Add New Location")
                    Spacer()
                    
                }//End VStack
                
                .padding(.leading, 55)
                .padding(.trailing,55)
                
                
            }
        }//End Navigation
        
        
    }//End Body
    
    func enteredValidLink() -> Bool {
        if LocationLink.count >= 10{
            return true
        }
        return false
    }
    
    
}//End View


//struct AddLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLocationView(onAdd: <#((String, String, String, UIImage?, Date) -> Void)?#>, onCancel: <#(() -> Void)?#>).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//
//    }
//}
