//
//  test.swift
//  locate
//
//  Created by Einas Alturki on 17/06/1444 AH.
//

import SwiftUI

struct test: View {
    
    @State private var isShowingAddView = false
    @State private var isShowingShare = false
    @State private var isEditing = false
    let photo = Image("logo")
    
    var body: some View {
        NavigationStack{
//            ZStack{
//                Image("bg")
//                    .ignoresSafeArea()
                Text("My Locations")
                .modifier(HeaderTitleModifier())
                .font(.title)
            
                ScrollView{
                    
                    ForEach (0..<3) { n in
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 350, height: 150)
                                .foregroundColor(Color.theme.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius:25)
                                        .stroke(Color.theme.black)
                                )
                                .shadow(radius: 2, x: 0, y: 1)
                            
                            VStack(alignment: .leading){
                                
                                HStack{
                                    Image("logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                    
                                    Image("line")
                                        .resizable()
                                        .frame( height: 90)
                                        .scaledToFit()
                                        .padding(.top)
                                    
                                    
                                    VStack(alignment: .leading){
                                        Text("Location Name ///////")
                                            .foregroundColor(Color.theme.black)
                                            
                                        Text("Location Link ///////")
                                            .foregroundColor(Color.theme.black)
                                    }
                                   // .padding()
                                    
                                    ShareLink(item: photo, preview:
                                                SharePreview ("photo.caption", image: photo)){
                                        Label("",systemImage:"square.and.arrow.up")
                                    }
                                    
                                }
                                Text("Description //////////////")
                                    .padding(.bottom)
                                    .foregroundColor(Color.theme.black)
                            }
                        }
                    }
                    .padding(.top,30)

                    .padding(.leading, 45)

                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(isEditing ? "Done" : "Edit") {
                                withAnimation { isEditing.toggle() }
                            }
                        }
                    
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button{
                                isShowingAddView.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                            }
                        }
                    }
                    .fontWeight(.bold)
//                    .navigationBarTitle("My Locations")
//                    .navigationBarTitleDisplayMode(.inline)
                    .font(.headline)
                    .foregroundColor(Color.theme.main)
//                    .navigationBarHidden(false)
//                    .foregroundColor(Color.theme.main)
                   
                    
                }
            //}
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
