#pragma once

#include <X11/Xlib.h>
#include <X11/Xutil.h>

class OWindow;

extern Display* GlobalDisplay;
extern int GlobalScreenId;
extern Window GlobalWindowRoot;
extern Visual *GlobalVisual;
extern Colormap GlobalColorMap;

extern void X11CheckEvent(OWindow* window,void* event);

