#include <OGL3D/Game/OGame.h>
#include <OGL3D/Window/OWindow.h>
#include <OGL3D/Graphics/OGraphicsEngine.h>
#import <Cocoa/Cocoa.h>

@interface CocoaAppDelegate : NSObject <NSApplicationDelegate>
{
@public
  OGame *app;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
@end

@implementation CocoaAppDelegate
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    app->quit();
    return NSTerminateCancel;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (void)applicationWillUpdate:(NSNotification *)aNotification
{
}

@end

void OGame::run()
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    [NSApplication sharedApplication];

    CocoaAppDelegate* delegate = [[CocoaAppDelegate new]autorelease];
    delegate->app = this;
    [NSApp setDelegate: delegate ];

    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    id menubar = [[NSMenu new] autorelease];
    id appMenuItem = [[NSMenuItem new] autorelease];
    [menubar addItem:appMenuItem];
    [NSApp setMainMenu:menubar];

    onCreate();

    while (m_isRunning)
    {
        NSEvent *event = [ NSApp
                nextEventMatchingMask:NSAnyEventMask
                untilDate:[NSDate distantPast]
                inMode:NSDefaultRunLoopMode
                dequeue: YES];
        if (event)
        {
            [NSApp sendEvent: event];
        }

        onUpdate();
    }

    onQuit();

    [pool drain];
}
