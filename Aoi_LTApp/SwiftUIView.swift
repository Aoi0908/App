//
//  SwiftUIView.swift
//  Aoi_LTApp
//
//  Created by ひがしもとあおい on 2023/02/08.
//

import SwiftUI

struct SwiftUIView: View {
    @State var onAlert = false
    @State var text = ""
    var body: some View {
        ZStack {
            Button(action: {
                self.onAlert.toggle()
            }) {
                Text("ボタン")
            }
            
            if onAlert {
                ZStack() {
                    Rectangle()
                        .foregroundColor(.gray)
                    VStack {
                        Text("100円を入れてね！☆")
                        TextField("テキスト",text: $text)
                        HStack {
                            Button("OK") {
                                self.onAlert.toggle()
                            }
                        }
                    }.padding()
                }
                .frame(width: 300, height: 180,alignment: .center)
                .cornerRadius(20).shadow(radius: 20)
            }
        }
    }
    
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

