//
//  WebViewController.swift
//  Framer Connect
//
//  Created by Michael Feldstein on 12/1/14.
//  Copyright (c) 2014 Michael Feldstein. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIGestureRecognizerDelegate {
    var webView : WKWebView?
    var url : NSURL?
    let threeFingerGesture = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaPlaybackRequiresUserAction = false
        self.webView = WKWebView(frame: CGRectZero, configuration: config)
        self.view.addSubview(self.webView!)
        let request = NSURLRequest(URL: self.url!)
        self.webView?.loadRequest(request)
        self.webView?.addGestureRecognizer(self.threeFingerGesture)
        self.threeFingerGesture.numberOfTouchesRequired = 3
        self.threeFingerGesture.addTarget(self, action: "pop")
        self.threeFingerGesture.delegate = self
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func pop() {
        if (self.webView!.canGoBack) {
            self.webView?.goBack()
        } else {
            self.webView?.reload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        self.webView?.frame = self.view.bounds
    }    
}
