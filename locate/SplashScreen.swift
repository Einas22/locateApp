//
//  SplashScreen.swift
//  locate
//
//  Created by Einas Alturki on 19/06/1444 AH.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            MyLocations()
        } else {
            ZStack {
                Color("WHITE")
                    .ignoresSafeArea()
                HStack{
                    Image("𝕝𝕠𝕔𝕒𝕥𝕖")
                        .padding(.leading,150)
                        .padding(.trailing,-55)
                    
                    Image("Splash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 270)
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 0.8)) {
                                self.size = 1.00
                                self.opacity = 1.00
                            }
                        }
                        .accessibilityHidden(true)
                }
                .padding(.trailing,143)
                
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
            
            
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
