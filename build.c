#include "cpm.h"

void embed_dsk();
void mkdsk();
void fmt_dsk();

#define BUILDDIR "./build/"
#define IMGPATH "./dsk.img"

void bld(Arguments args){
   cpm_submodule("./bootloader", 0);

    mkdsk();
    fmt_dsk();
    embed_dsk();
}

void embed_dsk(){
    Cmd dd = cpm_cmd_new("dd");
    cpm_cmd_append(&dd, "if="BUILDDIR "boot.bin", "of="IMGPATH, "conv=notrunc" );
    cpm_cmd_exec(dd);

    Cmd stg2 = cpm_cmd_new("dd");
    cpm_cmd_append(&stg2, "if="BUILDDIR"main.bin", "of="IMGPATH, );
}

void mkdsk(){
    Cmd dd = cpm_cmd_new("dd");
    cpm_cmd_append(&dd, "if=/dev/zero", "of="IMGPATH, "count=31MB" );
    cpm_cmd_exec(dd);
}

void fmt_dsk(){
    Cmd mkfs = cpm_cmd_new("mkfs.fat");
    cpm_cmd_append(&mkfs, "-F16", IMGPATH);
    cpm_cmd_exec(mkfs);
}

CliCommand build = {.name = "build", .desc = "build project", .function = bld};

int main(int argc, char** argv){
    CPM_REBUILD_SELF(argc, argv);
    CliEnv env = cpm_create_cliEnv_Cargs(argc, argv);
    cpm_append_env_commands(&env, build);
    cpm_CLI(env);
}
