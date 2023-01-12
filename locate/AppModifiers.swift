//
//  AppModifier.swift
//  locate
//
//  Created by Einas Alturki on 15/06/1444 AH.
//

import SwiftUI

//Color Theme for the project
extension Color {
    static let theme = ColorTheme ()
}

struct ColorTheme{
    
    let main = Color ("Main")
    let black = Color ("Black")
    let bg = Color ("Background")
    let white = Color ("White")
//    let sub2 = Color ("subText2")
//    let textField = Color ("textfield")
   
}

//Modifier for all the header Titles in the app
struct HeaderTitleModifier : ViewModifier {
func body(content: Content) -> some View {
    content
        //.font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(Color.theme.main)
}
}

//Modifier for all Sub titles in the app
struct SubTitleModifier: ViewModifier {
func body(content: Content) -> some View {
    content
        //.font(.title)
        .foregroundColor(Color.theme.black)
}
}

//Modifier for all the App Buttons
struct ButtonModifier:  ViewModifier {
func body(content: Content) -> some View {
    content
        .frame(minWidth: 0, maxWidth:300)
        .fontWeight(.bold)
        .font(.system(size: 20))
        .padding()
        .background(Color.theme.main)
        .cornerRadius(10)
    
        .foregroundColor(.white)
        .padding(10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 40)
//                .stroke(Color.theme.black, lineWidth: 2)
//        )
        .shadow(radius: 2, x: 0, y: 1)
    
}
}

//Modifier for App textField
struct TextFieldModifier: ViewModifier{
func body(content: Content) -> some View {
    content
        .padding()
        .foregroundColor(Color.theme.black)
        .background(Color.theme.white)
        .frame(width: 320,height: 38)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius:10)
                .stroke(Color.theme.black)
        )
        .shadow(radius: 4, x: 0, y: 2)
}
}


