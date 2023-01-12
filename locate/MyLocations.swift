//
//  home.swift
//  locate
//
//  Created by Einas Alturki on 15/06/1444 AH.
//

import SwiftUI

struct MyLocations: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isShowingAddView = false
    @State private var isShowingShare = false
    @State private var isEditing = false
    @State private var isPresented = false
    @State private var numberOfLocations : Int = 0
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
  
    @State var selectedItem : Item?
    
    var body: some View {
        
        NavigationView {
            ZStack{
                Image("bg")
                    .accessibilityHidden(true)
                
                ScrollView {
                    
                    listView
                        .padding(.top,20)
                        .padding(.leading)
                    
                    
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(isEditing ? "Done" : "Edit") {
                                    withAnimation { isEditing.toggle() }
                                    
                                }
                                .accessibilityLabel ("\(isEditing ? "Done From Editing" : "Button to Edit the locations you have")")
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button{
                                    isShowingAddView.toggle()
                                } label: {
                                    Image(systemName: "plus.circle")
                                }
                                .accessibilityLabel("Add a new Location Button")
                            }
                        }
                    
                        .foregroundColor(Color.theme.main)
                        .navigationTitle("My Locations")
                        .navigationBarTitleDisplayMode(.inline)
                    
                    
                }//End scroll view
                .padding(.top,20)
               
                
            } //End ZStack Background
            
        }//End Navigation
        
        .sheet(isPresented: $isPresented, content: {
            Share(name: selectedItem?.name ?? "", link: selectedItem?.link ?? "", photo: selectedItem?.photo ?? UIImage(named: "logo")!, linkDescription: selectedItem?.linkDescription ?? "")
        })
        .sheet(isPresented: $isShowingAddView, content: {
            AddLocationView(onAdd: { LocationName, LocationLink, LocationDescription, image , time in
                isShowingAddView = false
                addContact(LocationName: LocationName, LocationLink: LocationLink, LocationDescription: LocationDescription, photo: image , time: time)
            }, onCancel: { isShowingAddView = false })
        })
       
    }//End Body
    
    private var listView: some View {
       
        ForEach(items) { contact in
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 350, height: 150)
                    .foregroundColor(Color.theme.white)
                    .overlay(
                        RoundedRectangle(cornerRadius:25)
                            .stroke(Color.theme.black)
                    )
                    .shadow(radius: 2, x: 0, y: 1)
                
                VStack(alignment: .leading) {
                    
                    HStack{
                        Image(uiImage: contact.photo ?? UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .accessibilityLabel("photo of the Location")
                        
                        Image("line")
                            .resizable()
                            .frame( height: 80)
                            .scaledToFit()
                            .padding(.top)
                            .accessibilityHidden(true)
                        
                        
                        VStack(alignment: .leading){
                            Text(contact.name ?? "None")
                                .modifier(HeaderTitleModifier())
                                .padding(.bottom,3)
                            Text(contact.link ?? "None")
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("Location Link")
                            
                        }
                        //.padding()
                        
                        Button {
                            isPresented.toggle()
                            selectedItem = contact
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .accessibilityLabel("Share this Location")
                        }
                        if isEditing {
                            
                            Button {
                                withAnimation {
                                    let index = items.firstIndex(of: contact)!
                                    items.map{_ in items[index]}.forEach(viewContext.delete)
                                    
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        let nsError = error as NSError
                                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    }
                                }
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width: 30.0, height: 30.0)
                                    .foregroundColor(Color.red)
                            } //    .offset(x: 70, y: -75)
                        }
                    }//HStack
                    
                    Text(contact.linkDescription ?? "None")
                        .modifier(SubTitleModifier())
                    
                        
                    
                }
                .accessibilityElement()
                .accessibilityLabel ("Location List")
                //print(items.count)
                .accessibilityValue("Location \(numberOfLocations + 1)")
                
                
            }//End ZStack
            
        } // End For Each
        //.accessibilityLabel("List of your locations")
        
    }
    
    private func addContact(LocationName: String, LocationLink: String, LocationDescription: String, photo: UIImage? , time: Date) {
        let newContact = Item(context: viewContext)
        newContact.name = LocationName
        newContact.link = LocationLink
        newContact.linkDescription = LocationDescription
        newContact.photo = photo
        newContact.time = time
        
        do {
            try viewContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    
    
    private func deleteContacts(offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}//End View

struct MyLocations_Previews: PreviewProvider {
    static var previews: some View {
        MyLocations().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
