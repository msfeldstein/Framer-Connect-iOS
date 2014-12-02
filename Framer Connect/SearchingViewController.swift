//
//  SearchingViewController.swift
//  Framer Connect
//
//  Created by Michael Feldstein on 12/1/14.
//  Copyright (c) 2014 Michael Feldstein. All rights reserved.
//

import UIKit

class SearchingViewController: UIViewController, BonjourFinderDelegate, QRDelegate {
    var bonjour : BonjourFinder?
    var webViewController : WebViewController?
    
    override func viewDidAppear(animated: Bool) {
        print("hi")
        self.bonjour = BonjourFinder()
        self.bonjour!.delegate = self
        self.bonjour!.start()
    }

    func foundAddress(address: String!, atPort port: Int32) {
        let url = NSURL(string: "http://\(address):8000")
        print(url)
        if (self.webViewController? != nil) { return }
        self.webViewController = WebViewController()
        self.webViewController!.url = url
        self.presentViewController(self.webViewController!, animated: true) { () -> Void in }
    }
    
    func scannedQRCode(code: String!) {
        self.foundAddress(code, atPort: 8000)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "scanQR" {
            let qrvc = segue.destinationViewController as QRCodeViewController
            qrvc.qrDelegate = self
        }
    }

}
