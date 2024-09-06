//
//  RectagleButton.swift
//  browser-dev
//
//  Created by hoangtv on 05/09/2024.
//

import SwiftUI

struct RectagleButton: View {
  let backgroundColor: Color
  let foregroundColor: Color
  let iconName: String
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      ZStack {
        Rectangle()
          .cornerRadius(4)
          .foregroundColor(backgroundColor)
        Label {
          Text(title)
            .bold()
        } icon: {
          Image(iconName)
        }
        .foregroundColor(foregroundColor)
      }
    }
    
  }
}
