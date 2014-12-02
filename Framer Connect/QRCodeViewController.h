//
//  QRCodeViewController.h
//  AirFramer
//
//  Created by Michael Feldstein on 8/13/14.
//  Copyright (c) 2014 Macromeez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol QRDelegate <NSObject>
- (void)scannedQRCode:(NSString*)code;

@end

@interface QRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property id<QRDelegate> qrDelegate;

@property AVCaptureDevice* device;
@property AVCaptureDeviceInput* input;
@property AVCaptureSession* session;
@property AVCaptureMetadataOutput* output;
@property AVCaptureVideoPreviewLayer* preview;

@property IBOutlet UIView* videoContainer;
@end
