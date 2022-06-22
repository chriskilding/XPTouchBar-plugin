//
// Imports the X-Plane SDK's public headers that we want to expose to Swift.
//

#include "XPLMDataAccess.h"
#include "XPLMPlugin.h"
#include "XPLMProcessing.h"
#include "XPLMMenus.h"

#ifndef XPLM300
    #error This is made to be compiled against the XPLM300 SDK
#endif
