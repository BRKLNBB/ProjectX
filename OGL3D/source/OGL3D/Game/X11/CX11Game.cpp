#include <OGL3D/Game/OGame.h>
#include <OGL3D/Window/OWindow.h>
#include <OGL3D/Graphics/OGraphicsEngine.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <OGL3D/Graphics/X11/CX11Globals.h>


void OGame::run()
{
    onCreate();

    while (m_isRunning)
    {
        //Retrieve the next X11 event from the events queue
        if (XPending((Display*)GlobalDisplay)) {
            XEvent xev;
            XNextEvent((Display*)GlobalDisplay, &xev);

            X11CheckEvent(m_display.get(),&xev);

            if (xev.type == ClientMessage) {
                if (xev.xclient.format == 32) {
                   m_isRunning = false;
                   continue;
                }
            }       
        }
        onUpdate();
    }

    onQuit();
}
