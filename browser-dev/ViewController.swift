//
//  ViewController.swift
//  browser-dev
//
//  Created by hoangtv on 07/03/2023.
//

import UIKit
import MediaPlayer
import SwiftUI
import AVKit
import WebKit

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .yellow
    let webView = WKWebView()
    if let url = URL(string: "https://www.apple.com") {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
}
