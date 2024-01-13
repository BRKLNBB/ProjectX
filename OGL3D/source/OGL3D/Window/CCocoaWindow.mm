#include <OGL3D/Window/OWindow.h>
#import <Cocoa/Cocoa.h>
#include <glad/glad.h>
#include <assert.h>
#include <stdexcept>



@interface View : NSOpenGLView <NSWindowDelegate> {
      @public
      OWindow* window;
}
@end

@implementation View
- (id) initWithFrame: (NSRect) frame {
    return self;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

-(void)windowWillClose:(NSNotification *)notification {
    [NSApp terminate:self];
}

- (void) dealloc {
    [super dealloc];
}
@end



OWindow::OWindow()
{
    NSUInteger windowStyle = NSTitledWindowMask  | NSClosableWindowMask ;

    NSRect screenRect = [[NSScreen mainScreen] frame];
    NSRect viewRect = NSMakeRect(0, 0, 1024, 768);
    NSRect windowRect = NSMakeRect(NSMidX(screenRect) - NSMidX(viewRect),
                                   NSMidY(screenRect) - NSMidY(viewRect),
                                   viewRect.size.width,
                                   viewRect.size.height);

    NSWindow * window = [[NSWindow alloc] initWithContentRect:windowRect
                                                              styleMask:windowStyle
                                                              backing:NSBackingStoreBuffered
                                                              defer:NO];
    assert(window);
    NSOpenGLPixelFormatAttribute windowedAttrs[] =
    {
        NSOpenGLPFAMultisample,
        NSOpenGLPFASampleBuffers, 0,
        NSOpenGLPFASamples, 0,
        NSOpenGLPFAAccelerated,
        NSOpenGLPFADoubleBuffer,
        NSOpenGLPFAColorSize, 32,
        NSOpenGLPFADepthSize, 24,
        NSOpenGLPFAAlphaSize, 8,
        NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion4_1Core,
        0
    };

    NSOpenGLPixelFormat* pf = [[NSOpenGLPixelFormat alloc] initWithAttributes:windowedAttrs];
    assert(pf);
    NSOpenGLContext*  _context = [[NSOpenGLContext alloc] initWithFormat: pf shareContext: NULL];
    m_context = _context;
    assert(_context);

    makeCurrentContext();

    View* view = [[View alloc] initWithFrame:windowRect];
    view->window = this;
    [view setAutoresizingMask:  (NSViewWidthSizable | NSViewHeightSizable) ];
    [view setOpenGLContext:_context];
    [view setWantsBestResolutionOpenGLSurface: NO];


    [window setAcceptsMouseMovedEvents:YES];
    [window setContentView:view];
    [window setDelegate:view];
    [window setTitle:@"Project X – Cube"];
    [window orderFrontRegardless];

    m_handle = window;

    [pf release];
}



OWindow::~OWindow()
{
    NSOpenGLContext*  _context = (NSOpenGLContext*)m_context;
    [_context release];
    NSWindow* win= (NSWindow*) m_handle;
    [win release];
}

ORect OWindow::getInnerSize()
{
    NSWindow* win = (NSWindow*)m_handle;
    return ORect(win.contentView.frame.size.width,win.contentView.frame.size.height);
}

void OWindow::makeCurrentContext()
{
    NSOpenGLContext*  _context = (NSOpenGLContext*)m_context;
    [_context makeCurrentContext];
}

void OWindow::present(bool vsync)
{
    NSOpenGLContext*  _context = (NSOpenGLContext*)m_context;
    [_context flushBuffer];
}

