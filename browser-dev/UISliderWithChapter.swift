//
//  UISliderWithChapter.swift
//  browser-dev
//
//  Created by hoangtv on 21/06/2024.
//

import SwiftUI

struct UISliderWithChapter: View {
  static let barHeight: CGFloat = 4
  static let chapterSpacing: CGFloat = 4
  static let knobSize: CGFloat = 12
  
  init() {
    self.knobDraggingOffset = -Self.knobSize/2
  }
  
  @State var knobDraggingOffset: CGFloat {
    didSet {
      if seekBarWidth > 0 {
        let offSet = (knobDraggingOffset+Self.knobSize/2)/seekBarWidth
        
        self.currentKnobPositon = offSet * videoDuration
        print("hoangtv knobDraggingOffset: \(knobDraggingOffset)")
      }
    }
  }
  
  let sectionCount: Int = 4
  
  @State var seekBarWidth: CGFloat = 0.0 {
    didSet {
      print("hoangtv seekbarWidth: \(seekBarWidth)")
    }
  }
  
  var realSeekBarWidth: CGFloat {
    seekBarWidth - (CGFloat((sectionCount - 1)) * Self.chapterSpacing)
  }
  
  let videoDuration: Double = 300
  @State var currentKnobPositon: Double = 0.0 {
    didSet {
      print("hoangtv currentKnobPositon: \(currentKnobPositon)")
    }
  }
  @State var downloadedRange: Double = 150.0
  
  @State var isDragging: Bool = false
  
  var knobStartOffset: CGFloat {
    -Self.knobSize/2
  }
  var knobEndOffset: CGFloat {
    seekBarWidth-Self.knobSize
  }
  
  var body: some View {
      VStack(spacing: 4) {
        ZStack(alignment: .leading) {
          SeekBar
          KnobView
        }
        HStack {
          Text("00:00")
          Text("•")
          Text("First Ep")
          Image("Angle_Icon")
            .resizable()
            .frame(width: 14, height: 14)
          Spacer()
          Text("05:00")
        }
        .font(.footnote)
        .foregroundColor(.white)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(16)
      .background {
        Color.black
      }
//      .ignoresSafeArea()
  }
  
  @ViewBuilder
  var KnobView: some View {
      Image("Knob_Icon")
        .resizable()
        .frame(width: Self.knobSize, height: Self.knobSize)
        .gesture(DragGesture(minimumDistance: 0)
          .onChanged { value in
            self.isDragging = true
            var knobDraggingPosition = knobDraggingOffset
            knobDraggingPosition += value.location.x - value.startLocation.x
            knobDraggingPosition = max(knobStartOffset, min(knobDraggingPosition, knobEndOffset))
            self.knobDraggingOffset = knobDraggingPosition
          }
          .onEnded({ _ in
            self.isDragging = false
          })
        )
        .offset(x: self.knobDraggingOffset, y: 0)
  }
  
  @ViewBuilder
  var SeekBar: some View {
    let barHeight = isDragging ? Self.barHeight*2:Self.barHeight
    GeometryReader { geometry in
      HStack(alignment: .center, spacing: Self.chapterSpacing) {
        chapterSection(startTime: 0, endTime: 60)
          .cornerRadius(forHorizontal: .leading, Self.barHeight/2)
        chapterSection(startTime: 61, endTime: 200)
        chapterSection(startTime: 201, endTime: 250)
        chapterSection(startTime: 251, endTime: 300)
          .cornerRadius(forHorizontal: .trailing, Self.barHeight/2)
      }
      .onAppear(perform: {
        self.seekBarWidth = geometry.size.width
      })
    }
    .frame(height: barHeight)
  }
  
  @ViewBuilder
  func chapterSection(startTime: Double, endTime: Double) -> some View {
    let isDraggingInSide: Bool = isDragging && startTime <= currentKnobPositon && currentKnobPositon <= endTime
    let barHeight = isDraggingInSide ? Self.barHeight*2:Self.barHeight
    
    let width: CGFloat = realSeekBarWidth/videoDuration * (endTime - startTime)
    
    let playingWidth: CGFloat = (min(max(startTime, currentKnobPositon), endTime) - startTime) * realSeekBarWidth/videoDuration
    let downloadWidth: CGFloat = (min(max(startTime, downloadedRange), endTime) - startTime) * realSeekBarWidth/videoDuration
    
    ZStack(alignment: .leading) {
      Rectangle()
        .foregroundColor(.white)
        .opacity(0.25)
        .frame(height: barHeight)
      Rectangle()
        .foregroundColor(.white)
        .opacity(0.2)
        .frame(width: downloadWidth)
        .frame(height: barHeight)
      Rectangle()
        .foregroundColor(.white)
        .frame(width: playingWidth)
        .frame(height: barHeight)
    }
    .frame(width: width)
  }
}

extension View {
  func cornerRadius(forHorizontal edge: HorizontalEdge,_ radius: CGFloat) -> some View {
    switch edge {
    case .leading:
      cornerRadius(radius, corners: [.topLeft, .bottomLeft])
    case .trailing:
      cornerRadius(radius, corners: [.topRight, .bottomRight])
    }
  }
  
  @ViewBuilder
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    if #unavailable(iOS 16.0) {
      clipShape(RoundedCorner(radius: radius, corners: corners))
    } else {
      let topLeadingRadius = corners.contains(.topLeft) ? radius:0
      let bottomLeadingRadius = corners.contains(.bottomLeft) ? radius:0
      let bottomTrailingRadius = corners.contains(.bottomRight) ? radius:0
      let topTrailingRadius = corners.contains(.topRight) ? radius:0
      clipShape(
        .rect(
          topLeadingRadius: topLeadingRadius,
          bottomLeadingRadius: bottomLeadingRadius,
          bottomTrailingRadius: bottomTrailingRadius,
          topTrailingRadius: topTrailingRadius
        )
      )
    }
  }
}

struct RoundedCorner: Shape {
  let radius: CGFloat
  let corners: UIRectCorner
  
  init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
    self.radius = radius
    self.corners = corners
  }
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}

#Preview {
  UISliderWithChapter()
}
