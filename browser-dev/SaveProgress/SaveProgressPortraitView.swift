//
//  SaveProgressPortraitView.swift
//  browser-dev
//
//  Created by hoangtv on 05/09/2024.
//

import SwiftUI

struct SaveProgressView<ContentView: View>: View {
  let mediaTitle: String = "Royal Blood Drum Show.mp4"
  var mediaSubTitle: String? = nil
  let currentTime: String
  var buttonsView: ContentView
  
  init(currentTime: String, @ViewBuilder buttonsView: () -> ContentView) {
    self.currentTime = currentTime
    self.buttonsView = buttonsView()
  }
  
  var body: some View {
    ZStack {
      VStack {
        HStack {
          Button {
            // Close button
          } label: {
            Image("save_progess_close_icon")
          }
          .frame(width: 44, height: 44)
          .background {
            Color(hex: "#0D0E0E")
          }
          .cornerRadius(12)
          Spacer()
        }
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      VStack(spacing: 24) {
        VStack {
          Image("video_thumb_image")
          HStack {
            Text(mediaTitle)
              .foregroundColor(.white)
            Spacer()
          }
          if let mediaSubTitle {
            HStack {
              Text(mediaSubTitle)
                .foregroundColor(Color(hex: "#B2B2B2"))
              Spacer()
            }
          }
          HStack {
            GeometryReader { proxy in
              ZStack {
                Color(hex: "#252525")
                Color(hex: "#B7B7B7")
                  .padding(.trailing, proxy.size.width*2/3)
              }
            }
            .frame(height: 4)
            .cornerRadius(2)
          }
          .frame(height: 12)
        }
        .frame(width: 280)
        
        Group {
          Text("Bạn đang xem đến ") +
          Text(currentTime)
            .fontWeight(.bold) +
          Text(". Bạn có muốn xem tiếp?")
        }
        .foregroundColor(.white)
        
        buttonsView
      }
    }
    .padding(16)
    .background {
      Color.black
    }
  }
}
