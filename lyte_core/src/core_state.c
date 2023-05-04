//

#include "lyte_core.h"

lyte_State lyte_state = {0};

void lyte_core_state_init(bool vsync, lyte_BlendMode default_blendmode, lyte_FilterMode default_filtermode) {
    lyte_state.vsync = vsync;
    lyte_state.default_blendmode = default_blendmode;
    lyte_state.default_filtermode = default_filtermode;

    lyte_state.blendmode = default_blendmode;
    lyte_state.filtermode = default_filtermode;
}