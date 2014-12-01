//
//  SearchingViewController.swift
//  Framer Connect
//
//  Created by Michael Feldstein on 12/1/14.
//  Copyright (c) 2014 Michael Feldstein. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController, BonjourFinderDelegate {
    var bonjour = BonjourFinder()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bonjour.delegate = self
        self.bonjour.start()
    }

    func foundAddress(address: String!, atPort port: Int32) {
        print("Address \(address) Port \(port)")
        let url = NSURL(string: "http://\(address):8000")
        let webViewController = WebViewController()
        webViewController.url = url
        self.presentViewController(webViewController, animated: true) { () -> Void in }
    }

}
