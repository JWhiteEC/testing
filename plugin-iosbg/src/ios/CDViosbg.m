#import "CDViosbg.h"
#import <Cordova/CDVPlugin.h>

@implementation CDViosbg

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

static UIView * view = nil;


- (void)wvupdate:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    int webhidden = [[command.arguments objectAtIndex:0] intValue];
    int viewhidden = [[command.arguments objectAtIndex:1] intValue];
    int webparenthidden = [[command.arguments objectAtIndex:2] intValue];
    int webparentparenthidden = [[command.arguments objectAtIndex:3] intValue];
        int p=self.webView.superview?1:0;
        int q=p?(self.webView.superview.superview?1:0):0;
    self.webView.hidden = webhidden ? YES:NO;
    if(p)self.webView.superview.hidden = webparenthidden ? YES:NO;
    if(q)self.webView.superview.superview.hidden = webparentparenthidden ? YES:NO;
    if(view) view.hidden = viewhidden ? YES:NO;
        NSLog(@"wvupdate [ %d %d %d %d ] s [ %d %d %d ]", webhidden, viewhidden, webparenthidden, webparentparenthidden, view?1:0,p,q);
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)update:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    int color = [[command.arguments objectAtIndex:0] intValue];
    int zindex = [[command.arguments objectAtIndex:1] intValue];
    [self.webView setBackgroundColor:[UIColor clearColor]];
    [self.webView setOpaque:NO];
    int w=[[UIScreen mainScreen] bounds].size.width, h= [[UIScreen mainScreen] bounds].size.height, m=w>h?w:h;
    if(!view) view = [[UIView alloc] initWithFrame:CGRectMake(0,0,m,m)];
    view.backgroundColor = UIColorFromRGB(color);
    view.layer.zPosition = zindex;

    [self.webView.superview insertSubview:view belowSubview:self.webView];

    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
