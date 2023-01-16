////
////  MyLocationViewModel.swift
////  locate
////
////  Created by Einas Alturki on 23/06/1444 AH.
////
//
import Foundation
import SwiftUI
import CoreData

class MyLocationViewModel : ObservableObject {
    
    @Published var isShowingAddView = false
    @Published var isShowingShare = false
    @Published var isEditing = false
    @Published var isPresented = false
    @Published var numberOfLocations : Int = 0
    @Published var savedEntity: [Item] = []
    @Published var selectedItem : Item?
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "locate")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        FetchRequest()
    }
    
    func FetchRequest(){
        let request = NSFetchRequest<Item>(entityName: "Item")
        do{
           savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addItem(LocationName: String, LocationLink: String, HouseNumber: String, LocationDescription: String, photo: UIImage? , time: Date) {
        let newContact = Item(context: container.viewContext)
        newContact.name = LocationName
        newContact.link = LocationLink
        newContact.houseNumber = HouseNumber
        newContact.linkDescription = LocationDescription
        newContact.photo = photo
        newContact.time = time
        SaveData()
        
    }
    
    func SaveData(){
        do {
            try container.viewContext.save()
            FetchRequest()
        } catch {
          print("Error Saving..\(error) ")
        }
    }
    
    func deleteItem(index: Array<Item>.Index){
       // guard let index = indexSet.first else {return}
//        let entity = savedEntity[index]
//        container.viewContext.delete(entity)
        savedEntity.map{_ in savedEntity[index]}.forEach(container.viewContext.delete)
        
        SaveData()
    }
//    func deleteContacts(offsets: IndexSet) {
//        offsets.map { items[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
}
