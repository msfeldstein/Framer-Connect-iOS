//
//  BonjourFinder.m
//  Framer Connect
//
//  Created by Michael Feldstein on 12/1/14.
//  Copyright (c) 2014 Michael Feldstein. All rights reserved.
//

#import "BonjourFinder.h"
#include <arpa/inet.h>

@interface BonjourFinder () {
    NSNetServiceBrowser* _browser;
    NSNetService* _service;
}

@end

@implementation BonjourFinder

- (id) init {
    self = [super init];
    _browser = [[NSNetServiceBrowser alloc] init];
    _browser.delegate = self;
    return self;
}

- (void)start {
    [_browser searchForServicesOfType:@"_framerconnect._tcp" inDomain:@""];
}

- (void) netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing {
    _service = aNetService;
    if (!moreComing) {
        aNetService.delegate = self;
        [aNetService resolveWithTimeout:30];
    }
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender {
    char addressBuffer[INET6_ADDRSTRLEN];
    
    int port;
    for (NSData *data in sender.addresses)
    {
        memset(addressBuffer, 0, INET6_ADDRSTRLEN);
        
        typedef union {
            struct sockaddr sa;
            struct sockaddr_in ipv4;
            struct sockaddr_in6 ipv6;
        } ip_socket_address;
        
        ip_socket_address *socketAddress = (ip_socket_address *)[data bytes];
        
        if (socketAddress && (socketAddress->sa.sa_family == AF_INET))
        {
            const char *addressStr = inet_ntop(
                                               socketAddress->sa.sa_family,
                                               (socketAddress->sa.sa_family == AF_INET ? (void *)&(socketAddress->ipv4.sin_addr) : (void *)&(socketAddress->ipv6.sin6_addr)),
                                               addressBuffer,
                                               sizeof(addressBuffer));
            
            port = ntohs(socketAddress->sa.sa_family == AF_INET ? socketAddress->ipv4.sin_port : socketAddress->ipv6.sin6_port);
            
            if (addressStr && port)
            {
                self.address = [NSString stringWithCString:addressStr encoding:NSASCIIStringEncoding];
                self.port = port;
                break;
            }
        }
    }
    [self.delegate foundAddress:self.address atPort:self.port];
}

@end
