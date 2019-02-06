//
//  AboutViewController.swift
//  bullseye
//
//  Created by Kimberley Holmes on 2019-01-22.
//  Copyright © 2019 Taylor Fraser. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "BullsEye",
                                     withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}

