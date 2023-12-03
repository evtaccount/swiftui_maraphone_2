//
//  ContentView.swift
//  Maraphon_2
//
//  Created by Evgeny Evtushenko on 03/12/2023.
//

import SwiftUI

struct ContentView: View {
  @State var width: CGFloat = 300
  
  var body: some View {
    VStack {
      Group {
        Text("Марафон ")
          .foregroundColor(.gray)
        + Text("**по SwiftUI** ")
        + Text("\"Отцовский пинок\"")
          .font(.system(size: 24))
          .foregroundColor(.blue)
          .fontWeight(.bold)
      }
      .frame(width: width, height: 200)
      .border(.red)
      
      Slider(value: $width, in: 100...300)
    }
    .padding()
  }
}

#Preview {
    ContentView()
}
