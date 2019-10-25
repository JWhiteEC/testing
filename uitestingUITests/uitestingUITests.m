//
//  uitestingUITests.m
//  uitestingUITests
//
//  Created by User on 2019-09-25.
//
//

#import <XCTest/XCTest.h>

@interface uitestingUITests : XCTestCase

@end

@implementation uitestingUITests
XCUIApplication *springboard, *app;


-(int)waitForElement:(XCUIElement *)element withTimeout:(NSTimeInterval)timeout {
    NSTimeInterval s = [NSDate timeIntervalSinceReferenceDate];
    while (!element.exists) {
        if ([NSDate timeIntervalSinceReferenceDate] - s > timeout) return 0;
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.25, false);
    }
    return 1;
}

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    app = [[XCUIApplication alloc] init];
    NSLog(@"Setup system alert monitor");
    id systemAlertMonitor = [self addUIInterruptionMonitorWithDescription:@"Alert Handler" handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        NSLog(@"Got system alert");
        if (interruptingElement.buttons[@"Allow"].exists) {
            NSLog(@"System alert Allow");
            [interruptingElement.buttons[@"Allow"] tap];
            return YES;
        }
        if (interruptingElement.buttons[@"OK"].exists) {
            NSLog(@"System alert OK");
            [interruptingElement.buttons[@"OK"] tap];
            return YES;
        }
        return NO;
    }];
    [app launch];
    [app swipeLeft];
    [app swipeRight];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    for (int i=0; i<60; i++){
        NSLog(@"Test index %d", i);
        XCUIElement *ok = app.buttons[@"OK"];
        if([self waitForElement:ok withTimeout:1.0f])
                [ok tap];
        else if((i%10)==9)
                [app swipeLeft];
        else if((i%10)==5)
                [app swipeRight];
    }
    [app terminate];
}

@end
