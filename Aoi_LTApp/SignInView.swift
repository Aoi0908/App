//
//  SignInView.swift
//  Aoi_LTApp
//
//  Created by ひがしもとあおい on 2023/02/08.
//

import SwiftUI

struct SignInView: View {
    @State private var show: Bool = false
    var body: some View {
        Text("teeeete")
        Button(action: { self.show.toggle() }) {
            Text("画面遷移Present").fontWeight(.bold).font(.largeTitle)
        }
        .sheet(isPresented: self.$show) {
            // trueになれば下からふわっと表示
            LoginView()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
