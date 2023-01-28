package Atari.Aes.Shell is

    SHEL_BUFSIZE         : constant  := -1;                     -- *< return the size of AES shell buffer, see mt_shel_read()

    SHP_HELP             : constant  := 0;                      -- *< see mt_shel_help()

    --  shel_write modes for parameter "doex"
    SWM_LAUNCH           : constant  := 0;
    SWM_LAUNCHNOW        : constant  := 1;
    SWM_LAUNCHACC        : constant  := 3;                      -- *< Launch a GEM desk accessory, see mt_shel_write()
    SWM_SHUTDOWN         : constant  := 4;                      -- *< Manipulate 'Shutdown' mode, see mt_shel_write()
    SWM_REZCHANGE        : constant  := 5;                      -- *< Change screen resolution, see mt_shel_write()
    SWM_BROADCAST        : constant  := 7;                      -- *< Broadcast an AES message to all processes, see mt_shel_write()
    SWM_ENVIRON          : constant  := 8;                      -- *< Manipulate the AES environment, see mt_shel_write()
    SWM_NEWMSG           : constant  := 9;
    SWM_AESMSG           : constant  := 10;                     -- *< Send a message to the AES, see mt_shel_write()
    SWM_THRCREATE        : constant  := 20;                     -- *< create a new thread, see mt_shel_write()
    SWM_THREXIT          : constant  := 21;                     -- *< thread terminates itself, see mt_shel_write()
    SWM_THRKILL          : constant  := 22;                     -- *< parent kills a thread, see mt_shel_write()

    SHW_NOEXEC           : constant  := 0;                      -- *< alias
    SHW_EXEC             : constant  := 1;                      -- *< alias
    SHW_EXEC_ACC         : constant  := 3;                      -- *< alias
    SHW_SHUTDOWN         : constant  := 4;                      -- *< alias
    SHW_RESCHNG          : constant  := 5;                      -- *< alias
    SHW_BROADCAST        : constant  := 7;                      -- *< alias
    SHW_INFRECGN         : constant  := 9;                      -- *< alias
    SHW_AESSEND          : constant  := 10;                     -- *< alias
    SHW_THR_CREATE       : constant  := 20;                     -- *< alias
    SHW_THR_EXIT         : constant  := 21;                     -- *< alias
    SHW_THR_KILL         : constant  := 22;                     -- *< alias

    --  shel_write, parameter wisgr
    TOSAPP               : constant  := 0;                      -- *< application launched as TOS application, see mt_shel_write()
    GEMAPP               : constant  := 1;                      -- *< application launched as GEM application, see mt_shel_write()

    --  shel_write modes for parameter "isover"
    SHW_IMMED            : constant  := 0;                      -- *< unsupported (PC-GEM  2.x)
    SHW_CHAIN            : constant  := 1;                      -- *< TOS way, see mt_shel_write()
    SHW_DOS              : constant  := 2;                      -- *< unsupported (PC-GEM  2.x)
    SHW_PARALLEL         : constant  := 100;                    -- *< create a new application to be ran in parallel, see mt_shel_write()
    SHW_SINGLE           : constant  := 101;                    -- *< run an application in single mode (all other applications but apid 0 and 1 are frozen), see mt_shel_write()

    --  command line parser (shel_write: parameter "wiscr")
    CL_NORMAL            : constant  := 0;                      -- *< command line passed normaly, see mt_shel_write()
    CL_PARSE             : constant  := 1;                      -- *< command line passed in ARGV environment string, see mt_shel_write()

    --  shutdown action (shel_write: mode SWM_SHUTDOWN, parameter "wiscr")
    SD_ABORT             : constant  := 0;                      -- *< Abort shutdown mode, see mt_shel_write()
    SD_PARTIAL           : constant  := 1;                      -- *< Partial shutdown mode, see mt_shel_write()
    SD_COMPLETE          : constant  := 2;                      -- *< Complete shutdown mode, see mt_shel_write()

    --  shel_write: mode SWM_ENVIRON, parameter 'wisgr'
    ENVIRON_SIZE         : constant  := 0;                      -- *< returns the current size of the environment string, see mt_shel_write()
    ENVIRON_CHANGE       : constant  := 1;                      -- *< modify an environment variable, see mt_shel_write()
    ENVIRON_COPY         : constant  := 2;                      -- *< copy the evironment string in a buffer, see mt_shel_write()

    NM_APTERM            : constant  := 16#1#;                  -- *< the application understands #AP_TERM messages, see mt_shel_write() and #SWM_NEWMSG
    NM_INHIBIT_HIDE      : constant  := 16#2#;                  -- *< the application won't be hidden, see mt_shel_write() and #SWM_NEWMSG

    AP_AESTERM           : constant  := 52;                     -- Mode 10: N.AES komplett terminieren.

    --  shel_write sh_wdoex parameter flags in MSB
    SW_PSETLIMIT         : constant  := 16#100#;                -- *< Initial Psetlimit() , see SHELW::psetlimit
    SW_PRENICE           : constant  := 16#200#;                -- *< Initial Prenice() , see SHELW::prenice
    SW_DEFDIR            : constant  := 16#400#;                -- *< Default Directory , see SHELW::defdir
    SW_ENVIRON           : constant  := 16#800#;                -- *< Environment , see SHELW::env
    SW_UID               : constant  := 16#1000#;               -- *< Set user id of launched child, see SHELW::uid
    SW_GID               : constant  := 16#2000#;               -- *< Set group id of launched child, see SHELW::gid
    SHW_XMDFLAGS         : constant  := 16#1000#;               -- *< magiC 6 extension, see XSHW_COMMAND::flags
    SHW_XMDLIMIT         : constant  := 16#100#;                -- *< alias
    SHW_XMDNICE          : constant  := 16#200#;                -- *< alias
    SHW_XMDDEFDIR        : constant  := 16#400#;                -- *< alias
    SHW_XMDENV           : constant  := 16#800#;                -- *< alias


    --  tail for default shell
    type SHELTAIL is
        record
            dummy  : aliased int16;
            magic  : aliased int32;
            isfirst: aliased int16;
            lasterr: aliased int32;
            wasgr  : aliased int16;
        end record;

    --  shel_write alternative structure for sh_wpcmd parameter
    type SHELW is
        record
            newcmd   : aliased chars_ptr;
            psetlimit: aliased int32;
            prenice  : aliased int32;
            defdir   : aliased chars_ptr;
            env      : aliased chars_ptr;
            uid      : aliased int16;
            gid      : aliased int16;
        end record;


    type XSHW_COMMAND is
        record
            command: aliased chars_ptr;
            limit  : aliased int32;
            nice   : aliased int32;
            defdir : aliased chars_ptr;
            env    : aliased chars_ptr;
            flags  : aliased int32;
        end record;

    type proc_func_ptr is access function(
                par: void_ptr)
               return int32;
    pragma Convention(C, proc_func_ptr);

    type THREADINFO is
        record
            proc      : aliased proc_func_ptr;
            user_stack: aliased void_ptr;
            stacksize : aliased uint32;
            mode      : aliased int16;
            res1      : aliased int32;
        end record;



    function Read(Command: chars_ptr; Tail: chars_ptr) return int16;

    function Write(
                c_Exit    : int16;
                Graphic   : int16;
                Aes       : int16;
                Command   : void_ptr;
                Tail      : chars_ptr)
               return int16;

    function Get(
                Buf       : chars_ptr;
                Len       : int16)
               return int16;

    function Put(
                Buf       : chars_ptr;
                Len       : int16)
               return int16;

    function Find(
                buf       : chars_ptr)
               return int16;

    function Environ(
                result    : out chars_ptr;
                param     : chars_ptr)
               return int16;

    procedure Read_Default(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr);

    procedure Write_Default(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr);

    function Help(
                sh_hmode  : int16;
                sh_hfile  : chars_ptr;
                sh_hkey   : chars_ptr)
               return int16;

    --  old C-style names
    function shel_read(Command: chars_ptr; Tail: chars_ptr) return int16 renames Read;

    function shel_write(
                c_Exit    : int16;
                Graphic   : int16;
                Aes       : int16;
                Command   : void_ptr;
                Tail      : chars_ptr)
               return int16 renames Write;

    function shel_get(
                Buf       : chars_ptr;
                Len       : int16)
               return int16 renames Get;

    function shel_put(
                Buf       : chars_ptr;
                Len       : int16)
               return int16 renames Put;

    function shel_find(
                buf       : chars_ptr)
               return int16 renames Find;

    function shel_envrn(
                result    : out chars_ptr;
                param     : chars_ptr)
               return int16 renames Environ;

    procedure shel_rdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr) renames Read_Default;

    procedure shel_wdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr) renames Write_Default;

    function shel_help(
                sh_hmode  : int16;
                sh_hfile  : chars_ptr;
                sh_hkey   : chars_ptr)
               return int16 renames Help;


end Atari.Aes.Shell;
