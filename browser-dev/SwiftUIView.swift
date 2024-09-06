//
//  SwiftUIView.swift
//  browser-dev
//
//  Created by hoangtv on 08/01/2024.
//

import SwiftUI

struct SwiftUIView: View {
  typealias ViewTappedAction = (_ shouldOpenSettings: Bool) -> Void
  
  var commonText: String
  var highlightText: String
  var viewTappedAction: ViewTappedAction
  
  init(
    commonText: String,
    highlightText: String,
    viewTappedAction: @escaping ViewTappedAction
  ) {
    self.commonText = commonText
    self.highlightText = highlightText
    self.viewTappedAction = viewTappedAction
  }
  
  var body: some View {
//    VStack(alignment: .leading, spacing: 0) {
      HStack(alignment: .center) {
        VStack(alignment: .leading, spacing: 6, content: {
          Image("recap_logo")
            .frame(width: 40, height: 10)
          Group {
            Text(commonText)
              .foregroundColor(Color.white)
            + Text(" ")
            + Text(highlightText)
              .bold()
              .foregroundColor(Color.yellow)
          }
          .font(Font(UIFont.systemFont(ofSize: 15)))
        })
        .padding(.vertical, 12)
        .padding(.leading, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        
        ZStack(alignment: .topTrailing) {
//          VStack {
//            Spacer()
//            Image("recap_image")
//              .resizable()
//              .aspectRatio(contentMode: .fit)
//          }
//          .fixedSize()
          
          Rectangle()
            .foregroundColor(.clear)
            .background(
              Image("recap_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 121)
                .clipped()
            )
            .fixedSize(horizontal: true, vertical: true)
            
          Button {
            viewTappedAction(false)
          } label: {
            Image(systemName: "xmark")
              .resizable()
              .padding(2)
              .frame(width: 12, height: 12)
              .foregroundColor(Color.white)
          }
          .padding(.top, 4)
          .padding(.trailing, 4)
        }
        
//      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color(hex: "#BD161D"))
    .cornerRadius(8)
    .padding(.horizontal, 16)
    .clipped()
    .onTapGesture {
      viewTappedAction(true)
    }
  }
}

#Preview {
  SwiftUIView(commonText: "Khám phá Nhật ký 2023 của bạn với Cốc Cốc.", highlightText: "Xem ngay ›") { shouldOpenSettings in
    print("Tapped")
  }
}

extension Color {
  public init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)
    let a: UInt64
    let r: UInt64
    let g: UInt64
    let b: UInt64
    switch hex.count {
    case 3:  // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6:  // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8:  // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (1, 1, 1, 0)
    }

    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: Double(a) / 255
    )
  }
}
