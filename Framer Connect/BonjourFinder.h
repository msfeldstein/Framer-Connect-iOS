//
//  BonjourFinder.h
//  Framer Connect
//
//  Created by Michael Feldstein on 12/1/14.
//  Copyright (c) 2014 Michael Feldstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BonjourFinderDelegate <NSObject>

- (void)foundAddress:(NSString*)address atPort:(int)port;

@end

@interface BonjourFinder : NSObject <NSNetServiceDelegate, NSNetServiceBrowserDelegate>

@property id<BonjourFinderDelegate> delegate;
@property NSString* address;
@property int port;
- (void) start;

@end
