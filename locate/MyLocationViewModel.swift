////
////  MyLocationViewModel.swift
////  locate
////
////  Created by Einas Alturki on 23/06/1444 AH.
////
//
//import Foundation
//import SwiftUI
//
//class MyLocationViewModel : ObservableObject {
//    
//    @Environment(\.managedObjectContext) var viewContext
//    
//    @Published var isShowingAddView = false
//    @Published var isShowingShare = false
//    @Published var isEditing = false
//    @Published var isPresented = false
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.time, ascending: true)],
//        animation: .default)
//    
//    var items: FetchedResults<Item>
//  
//    @Published var selectedItem : Item?
//    
//    func addContact(LocationName: String, LocationLink: String, HouseNumber: String, LocationDescription: String, photo: UIImage? , time: Date) {
//        let newContact = Item(context: viewContext)
//        newContact.name = LocationName
//        newContact.link = LocationLink
//        newContact.houseNumber = HouseNumber
//        newContact.linkDescription = LocationDescription
//        newContact.photo = photo
//        newContact.time = time
//        
//        do {
//            try viewContext.save()
//        } catch {
//            fatalError("Error: \(error)")
//        }
//    }
//    
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
//}
