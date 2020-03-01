/**
 * Cordova (iOS) plugin for accessing the power-management functions of the device
 */
#import "PowerManagement.h"

/**
 * Actual implementation of the interface
 */
@implementation PowerManagement

- (void) acquire:(CDVInvokedUrlCommand*)command {
NSLog(@"PowerManagement: acquire");

    // Acquire a reference to the local UIApplication singleton
    UIApplication* app = [UIApplication sharedApplication];
    
    if( ![app isIdleTimerDisabled] ) {
NSLog(@"PowerManagement: acquire-1");
        [app setIdleTimerDisabled:true];
        
        CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        //[pr setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
        //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        //[pr setKeepCallbackAsBool:YES];
        //[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
        
    }
    else {
NSLog(@"PowerManagement: acquire-2");
        //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        //[pr setKeepCallbackAsBool:YES];
        //[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
        CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"IdleTimer already disabled"];
        //[pr setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
    }
}


- (void) release:(CDVInvokedUrlCommand*)command {
    // Acquire a reference to the local UIApplication singleton
NSLog(@"PowerManagement: release");
    UIApplication* app = [UIApplication sharedApplication];
    
    if( [app isIdleTimerDisabled] ) {
NSLog(@"PowerManagement: release-1");
        [app setIdleTimerDisabled:false];
        
        CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        //[pr setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
        //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        //[pr setKeepCallbackAsBool:YES];
        //[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
    }
    else {
NSLog(@"PowerManagement: release-2");
        //CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        //[pr setKeepCallbackAsBool:YES];
        //[self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
        CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"IdleTimer not disabled"];
        //[pr setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:pr callbackId:command.callbackId];
    }
}
@end
