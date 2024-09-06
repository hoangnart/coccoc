//
//  SaveProgressView.swift
//  browser-dev
//
//  Created by hoangtv on 05/09/2024.
//

import SwiftUI

struct SaveProgressMainView: View {
  @Environment(\.horizontalSizeClass) private var horizontalSizeClass
  @Environment(\.verticalSizeClass) private var verticalSizeClass
  
  let currentTime: String = "15:23"
  
  var body: some View {
    if verticalSizeClass == .regular && horizontalSizeClass == .compact {
      SaveProgressView(currentTime: currentTime) {
        VStack {
          RectagleButton(
            backgroundColor: .white,
            foregroundColor: .black,
            iconName: "save_progess_play_icon",
            title: "Xem tiếp từ \(currentTime)") {
              print("Xem tiếp từ \(currentTime)")
            }
            .frame(height: 50)
          RectagleButton(
            backgroundColor: Color(hex: "#242425"),
            foregroundColor: .white,
            iconName: "save_progess_replay_icon",
            title: "Xem từ đầu") {
              print("Xem từ đầu")
            }
            .frame(height: 50)
        }
      }
    } else {
      SaveProgressView(currentTime: currentTime) {
        HStack {
          RectagleButton(
            backgroundColor: .white,
            foregroundColor: .black,
            iconName: "save_progess_play_icon",
            title: "Xem tiếp từ \(currentTime)") {
              print("Xem tiếp từ \(currentTime)")
            }
            .frame(width: 242, height: 50)
          RectagleButton(
            backgroundColor: Color(hex: "#242425"),
            foregroundColor: .white,
            iconName: "save_progess_replay_icon",
            title: "Xem từ đầu") {
              print("Xem từ đầu")
            }
            .frame(width: 242, height: 50)
        }
      }
    }
  }
}
