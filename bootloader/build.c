#include "../cpm.h"
#define BUILD_DIR "../build"


int main(){
    Cmd stage1 = cpm_cmd_new("fasm");
    cpm_cmd_append(&stage1, "stage1/boot.s", BUILD_DIR"/boot.bin");
    cpm_cmd_exec(stage1);

    Cmd stage2 = cpm_cmd_new("fasm");
    cpm_cmd_append(&stage2, "stage2/main.s", BUILD_DIR"/main.bin");
    cpm_cmd_exec(stage2);
}
