//
//  home.swift
//  locate
//
//  Created by Einas Alturki on 15/06/1444 AH.
//

import SwiftUI

struct MyLocations: View {
    
    @StateObject var vm = MyLocationViewModel()
    @State var isPresented = false
    @State var frameSize = UIScreen.main.bounds.width
    var body: some View {
        
        NavigationView {
           
            VStack{
//
//                Text("My Locations")
//                .modifier(HeaderTitleModifier())
//                .font(.title)
                
                ScrollView {
                    
                    //separate view for displaying the Saved Location
                    
                    listView
                       // .accessibilityLabel("List of Locations you have")
                        .padding(.top,30)
                        .padding(.horizontal)
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(vm.isEditing ? "Done" : "Edit")
                                {
                                    withAnimation { vm.isEditing.toggle() }
                                    
                                }
                                .fontWeight(.bold)
                                .accessibilityLabel ("\(vm.isEditing ? "Done From Editing" : "Edit the locations you have")")
                            }
                            
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button{
                                    vm.isShowingAddView.toggle()
                                } label: {
                                    Image(systemName: "plus.circle")
                                        .fontWeight(.bold)
                                }
                                .accessibilityLabel("Add a new Location")
                            }
                        }
                    
                        .foregroundColor(Color.theme.main)
                        .navigationBarTitle("My Locations")
                        .navigationBarTitleDisplayMode(.inline)
                    
                    
                }//End scroll view
                
            } //End ZStack Background
            
        }//End Navigation
        
        .sheet(isPresented: $isPresented, content: {
            Share(name: vm.selectedItem?.name ?? "", link: vm.selectedItem?.link ?? "", houseNumber: vm.selectedItem?.houseNumber ?? "", photo: vm.selectedItem?.photo ?? UIImage(named: "logo")!, linkDescription: vm.selectedItem?.linkDescription ?? "",isPresented: $isPresented)
        })
        .sheet(isPresented: $vm.isShowingAddView, content: {
            AddLocationView(onAdd: { LocationName, LocationLink, houseNumber, LocationDescription, image , time in
                vm.isShowingAddView = false
                vm.addItem(LocationName: LocationName, LocationLink: LocationLink, HouseNumber: houseNumber,  LocationDescription: LocationDescription, photo: image , time: time)
            }, onCancel: { vm.isShowingAddView = false })
        })
       
    }//End Body
    
    private var listView: some View {
        
        //loop to show all the Saved locations
        
        ForEach(vm.savedEntity) { entity in
            
                VStack(alignment: .leading) {
                    
                    let numberOfLocations = vm.savedEntity.firstIndex(of: entity)! + 1
                    
                    HStack{
                        //image of the location
                        Image(uiImage: entity.photo ?? UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 60)
                            .accessibilityLabel("\(entity.name ?? "None") Photo")
                         
                        //divider for design
                        Image("line")
                            .resizable()
                            .frame( height: 80)
                            .scaledToFit()
                            .accessibilityLabel("\(entity.name ?? "None") Photo")
                        
                        //Location Title
                        //house number
                        //location Description
                        VStack(alignment: .leading){
                          
                            Text(entity.name ?? "Location \(numberOfLocations)")
                                .modifier(HeaderTitleModifier())
                                .accessibilityLabel("Location \(numberOfLocations)\(entity.name ?? "None")")
                                .padding(.bottom,1)
                            
                            Text(entity.houseNumber ?? "")
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("House Number \(entity.houseNumber ?? " None") ")
                            
                            Text(entity.linkDescription ?? "")
                                .modifier(SubTitleModifier())
                                .accessibilityLabel(" \(entity.linkDescription ?? "None")")
                            
                        }
                        .padding(.horizontal)
                        //Share Button
                        Button {
                            isPresented.toggle()
                            vm.selectedItem = entity
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                
                        }.accessibilityLabel("Share button")
                            .foregroundColor(Color.theme.main)
                            //.fontWeight(.bold)
                        
                        
                        //Delete button only shows when the users clicks Edit
                        if vm.isEditing {
                            
                            Button {
                                withAnimation {
                                    let index = vm.savedEntity.firstIndex(of: entity)!
                                    vm.deleteItem(index: index)
                                }
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width: 30.0, height: 30.0)
                                    .foregroundColor(Color.red)
                            } 
                        }
                    }//HStack
                    
                    //Location Link
                    VStack(alignment: .leading){
                        
                        Text("Location Link:")
                            .foregroundColor(Color.theme.main)
                        
                        Text(entity.link ?? "None")
                            .modifier(SubTitleModifier())
                            .accessibilityLabel("\(entity.name ?? "None") location link")
                            
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
            
            
        } // End For Each
        //.accessibilityLabel("List of your locations")
        
    }
    
}//End View

struct MyLocations_Previews: PreviewProvider {
    static var previews: some View {
        MyLocations()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
