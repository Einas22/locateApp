//
//  home.swift
//  locate
//
//  Created by Einas Alturki on 15/06/1444 AH.
//

import SwiftUI

struct MyLocations: View {
    
    @StateObject var vm = MyLocationViewModel()


    var body: some View {
        
        NavigationView {
            ZStack{
                Image("bg")
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                
                ScrollView {
                    
                    listView
                       // .accessibilityLabel("List of Locations you have")
                        .padding(.top,30)
                        .padding(.leading)
                    
                    
                    
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(vm.isEditing ? "Done" : "Edit")
                                {
                                    withAnimation { vm.isEditing.toggle() }
                                    
                                }
                                .fontWeight(.bold)
                                .accessibilityLabel ("\(vm.isEditing ? "Done From Editing" : "Edit the locations you have")")
                            }
                        }
                        .toolbar {
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
                        .navigationTitle("My Locations")
                        .navigationBarTitleDisplayMode(.inline)
                    
                    
                }//End scroll view
                //.padding(.top,20)
               
                
            } //End ZStack Background
            
        }//End Navigation
        
        .sheet(isPresented: $vm.isPresented, content: {
            Share(name: vm.selectedItem?.name ?? "", link: vm.selectedItem?.link ?? "", houseNumber: vm.selectedItem?.houseNumber ?? "", photo: vm.selectedItem?.photo ?? UIImage(named: "logo")!, linkDescription: vm.selectedItem?.linkDescription ?? "")
        })
        .sheet(isPresented: $vm.isShowingAddView, content: {
            AddLocationView(onAdd: { LocationName, LocationLink, houseNumber, LocationDescription, image , time in
                vm.isShowingAddView = false
                vm.addItem(LocationName: LocationName, LocationLink: LocationLink, HouseNumber: houseNumber,  LocationDescription: LocationDescription, photo: image , time: time)
            }, onCancel: { vm.isShowingAddView = false })
        })
       
    }//End Body
    
    private var listView: some View {
        
        ForEach(vm.savedEntity) { entity in
            
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
                    
                    let numberOfLocations = vm.savedEntity.firstIndex(of: entity)! + 1
                    
                    HStack{
                        Image(uiImage: entity.photo ?? UIImage(named: "logo")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .accessibilityLabel("\(entity.name ?? "None") Photo")
                            
                            
                            
                        
                        Image("line")
                            .resizable()
                            .frame( height: 80)
                            .scaledToFit()
                            .padding(.top)
                            .accessibilityLabel("\(entity.name ?? "None") Photo")
                        
                        
                        VStack(alignment: .leading){
                            Text(entity.name ?? "Location \(numberOfLocations)")
                                .modifier(HeaderTitleModifier())
                                .accessibilityLabel("Location \(numberOfLocations)\(entity.name ?? "None")")
                                
                            
                                .padding(.bottom,3)
                            Text(entity.link ?? "None")
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("\(entity.name ?? "None") location link")
                            Text(entity.houseNumber ?? "")
                                .modifier(SubTitleModifier())
                                .accessibilityLabel("House Number \(entity.houseNumber ?? " None") ")
                            
                        }
                        //.padding()
                        
                        Button {
                            vm.isPresented.toggle()
                            vm.selectedItem = entity
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                
                        }.accessibilityLabel("Share button")
                        
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
                            } //    .offset(x: 70, y: -75)
                        }
                    }//HStack
                    
                    
                    Text(entity.linkDescription ?? "")
                        .modifier(SubTitleModifier())
                        .accessibilityLabel(" \(entity.linkDescription ?? "None")")
                    
                        
                    
                }
                
                
            }//End ZStack
            .accessibilityElement(children: .combine)
            
            
        } // End For Each
        //.accessibilityLabel("List of your locations")
        
    }
    
}//End View

struct MyLocations_Previews: PreviewProvider {
    static var previews: some View {
        MyLocations().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
