package Atari.Aes.Application is

    APC_SYSTEM          : constant  := 2;
    APC_HIDE            : constant  := 10;                      -- *< Hide application -- see mt_appl_control()
    APC_SHOW            : constant  := 11;                      -- *< Show application -- see mt_appl_control()
    APC_TOP             : constant  := 12;                      -- *< Bring application to front -- see
    APC_HIDENOT         : constant  := 13;                      -- *< Hide all applications except the
    APC_INFO            : constant  := 14;                      -- *< Get the application parameter -
    APC_MENU            : constant  := 15;                      -- *< The last used menu tree is returned
    APC_WIDGETS         : constant  := 16;                      -- *< Inquires or sets the 'default'
    APC_APP_CONFIG      : constant  := 17;                      -- *< Change some way to manage application
    APC_INFORM_MESAG    : constant  := 18;                      -- *< Request/Remove the sent an user

    APCI_HIDDEN         : constant  := 16#1#;                   -- *< the application is hidden -- subopcode
    APCI_HASMBAR        : constant  := 16#2#;                   -- *< the application has a menu bar
    APCI_HASDESK        : constant  := 16#4#;                   -- *< the application has a own desk


    AES_LARGEFONT       : constant  := 0;                       -- *< see  mt_appl_getinfo()
    AES_SMALLFONT       : constant  := 1;                       -- *< see  mt_appl_getinfo()
    AES_SYSTEM          : constant  := 2;                       -- *< see  mt_appl_getinfo()
    AES_LANGUAGE        : constant  := 3;                       -- *< see  mt_appl_getinfo()
    AES_PROCESS         : constant  := 4;                       -- *< see  mt_appl_getinfo()
    AES_PCGEM           : constant  := 5;                       -- *< see  mt_appl_getinfo()
    AES_INQUIRE         : constant  := 6;                       -- *< see  mt_appl_getinfo()
    AES_WDIALOG         : constant  := 7;                       -- *< see  mt_appl_getinfo()
    AES_MOUSE           : constant  := 8;                       -- *< see  mt_appl_getinfo()
    AES_MENU            : constant  := 9;                       -- *< see  mt_appl_getinfo()
    AES_SHELL           : constant  := 10;                      -- *< see  mt_appl_getinfo()
    AES_WINDOW          : constant  := 11;                      -- *< see  mt_appl_getinfo()
    AES_MESSAGE         : constant  := 12;                      -- *< see  mt_appl_getinfo()
    AES_OBJECT          : constant  := 13;                      -- *< see  mt_appl_getinfo()
    AES_FORM            : constant  := 14;                      -- *< see  mt_appl_getinfo()
    AES_EXTENDED        : constant  := 64;                      -- *< see  mt_appl_getinfo()
    AES_NAES            : constant  := 65;                      -- *< see  mt_appl_getinfo()
    AES_VERSION         : constant  := 96;                      -- *< see  mt_appl_getinfo() and  mt_appl_getinfo_str()
    AES_WOPTS           : constant  := 97;                      -- *< see  mt_appl_getinfo()
    AES_WFORM           : constant  := 98;                      -- *< see  mt_appl_getinfo()
    AES_FUNCTIONS       : constant  := 98;                      -- *< see  mt_appl_getinfo()
    AES_AOPTS           : constant  := 99;                      -- *< see  mt_appl_getinfo()
    AES_APPL_OPTION     : constant  := 99;                      -- *< see  mt_appl_getinfo()
    AES_WINX            : constant  := 22360;                   -- *< AES WINX information, see  mt_appl_getinfo()

    SYSTEM_FONT         : constant  := 0;                       -- *< see  mt_appl_getinfo()
    OUTLINE_FONT        : constant  := 1;                       -- *< see  mt_appl_getinfo()

    AESLANG_ENGLISH     : constant  := 0;                       -- *< see  mt_appl_getinfo()
    AESLANG_GERMAN      : constant  := 1;                       -- *< see  mt_appl_getinfo()
    AESLANG_FRENCH      : constant  := 2;                       -- *< see  mt_appl_getinfo()
    AESLANG_SPANISH     : constant  := 4;                       -- *< see  mt_appl_getinfo()
    AESLANG_ITALIAN     : constant  := 5;                       -- *< see  mt_appl_getinfo()
    AESLANG_SWEDISH     : constant  := 6;                       -- *< see  mt_appl_getinfo()

    AES_DEVSTATUS_ALPHA : constant  := 0;                       -- *< see  mt_appl_getinfo()
    AES_DEVSTATUS_BETA  : constant  := 1;                       -- *< see  mt_appl_getinfo()
    AES_DEVSTATUS_RELEASE: constant  := 2;                      -- *< see  mt_appl_getinfo()
    AES_FDEVSTATUS_STABLE: constant  := 16#100#;                -- *< see  mt_appl_getinfo()

    AES_ARCH_M68000      : constant  := 0;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M68010      : constant  := 1;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M68020      : constant  := 2;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M68030      : constant  := 3;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M68040      : constant  := 4;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M68060      : constant  := 5;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_M6802060    : constant  := 6;                      -- *< see  mt_appl_getinfo()
    AES_ARCH_COLDFIRE    : constant  := 7;                      -- *< see  mt_appl_getinfo()

    AGI_WFORM            : constant  := 1;                      -- *< see  mt_appl_getinfo()
    AGI_AOPTS            : constant  := 2;                      -- *< see  mt_appl_getinfo()

    AO0_WF_SLIDE         : constant  := 1;                      -- *< see  mt_appl_options()
    AO0_OBJC_EDIT        : constant  := 2;                      -- *< see  mt_appl_options()

    --  appl_read modes
    APR_NOWAIT           : constant  := -1;                     -- *< Do not wait for message -- see mt_appl_read()

    --  appl_search modes
    APP_FIRST            : constant  := 0;                      -- *< see mt_appl_search()
    APP_NEXT             : constant  := 1;                      -- *< see mt_appl_search()
    APP_DESK             : constant  := 2;                      -- *< see mt_appl_search()
    X_APS_CHILD0         : constant  := 16#7100#; -- Geneva
    X_APS_CHILD          : constant  := 16#7101#; -- Geneva
    X_APS_CHEXIT         : constant  := -1;       -- Geneva

    --  application type (appl_search return values)
    APP_SYSTEM           : constant  := 16#1#;                  -- *< see mt_appl_search()
    APP_APPLICATION      : constant  := 16#2#;                  -- *< see mt_appl_search()
    APP_ACCESSORY        : constant  := 16#4#;                  -- *< see mt_appl_search()
    APP_SHELL            : constant  := 16#8#;                  -- *< see mt_appl_search()
    APP_AESSYS           : constant  := 16#10#;                 -- *< see mt_appl_search()
    APP_AESTHREAD        : constant  := 16#20#;                 -- *< see mt_appl_search()
    APP_TASKINFO         : constant  := 16#100#; -- XaAES extension for taskbar applications.
    APP_HIDDEN           : constant  := 16#100#; -- Task is disabled; XaAES only for APP_TASKINFO
    APP_FOCUS            : constant  := 16#200#; -- Active application; XaAES only for APP_TASKINFO

	--  EVNTREC.ap_event types
    APPEVNT_TIMER        : constant  := 0;
    APPEVNT_BUTTON       : constant  := 1;
    APPEVNT_MOUSE        : constant  := 2;
    APPEVNT_KEYBOARD     : constant  := 3;

    type EVNTREC is
        record
            ap_event: aliased int32;
            ap_value: aliased int32;
        end record;

    --  extended appl_write structure
    type XAESMSG is record
        dst_apid: int16;
        unique_flg: int16;
        attached_mem: void_ptr;
        msgbuf: short_ptr;
    end record;


    function Version return int16 with Inline;
    function Num_Apps return int16 with Inline;
    function Id return int16 with Inline;

    function Is_Application return boolean with inline;
	function Is_MultiTask return boolean with inline;

    function Init return int16;
    procedure AExit;
    function Read(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : void_ptr)
               return int16;
    function Write(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : void_ptr)
               return int16;
    function Write(
                ap_id     : int16;
                ap_pbuff  : Message_Buffer)
               return int16;
    function Find(name: const_chars_ptr) return int16;
    function Find(name: in String) return int16;
    procedure Tplay(
                mem       : System.Address;
                num       : int16;
                scale     : int16);
    function Trecord(
                mem       : System.Address;
                count     : int16)
               return int16;
    function Bitvector_Set(
                bvdisk    : int16;
                bvhard    : int16)
               return int16;
    procedure Yield with Inline;
    function Search(
                mode      : int16;
                fname     : chars_ptr;
                c_type    : out int16;
                ap_id     : out int16)
               return int16;
    function Search(
                mode      : int16;
                fname     : in out String;
                c_type    : out int16;
                ap_id     : out int16)
               return int16;
    function Control(
                ap_cid    : int16;
                ap_cwhat  : int16;
                ap_cout   : System.Address)
               return int16;
    function Get_Info(
                c_type    : int16;
                out1      : out int16;
                out2      : out int16;
                out3      : out int16;
                out4      : out int16)
               return boolean;
    function Get_Info(
                c_type    : int16;
                out1      : chars_ptr;
                out2      : chars_ptr;
                out3      : chars_ptr;
                out4      : chars_ptr)
               return boolean;

	--  old C-style names
    function appl_init return int16 renames Init;
    procedure appl_exit renames AExit;

    function appl_read(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : void_ptr)
               return int16 renames Read;

    function appl_write(
                ap_id     : int16;
                length    : int16;
                ap_pbuff  : void_ptr)
               return int16 renames Write;
    function appl_write(
                ap_id     : int16;
                ap_pbuff  : Message_Buffer)
               return int16 renames Write;
    function appl_find(name: const_chars_ptr) return int16 renames Find;
    function appl_find(name: in String) return int16 renames Find;
    procedure appl_tplay(
                mem       : void_ptr;
                num       : int16;
                scale     : int16) renames Tplay;
    function appl_trecord(
                mem       : void_ptr;
                count     : int16)
               return int16 renames Trecord;
    function appl_bvset(
                bvdisk    : int16;
                bvhard    : int16)
               return int16 renames Bitvector_Set;
    procedure appl_yield renames Yield;
    function appl_search(
                mode      : int16;
                fname     : chars_ptr;
                c_type    : out int16;
                ap_id     : out int16)
               return int16 renames Search;
    function appl_search(
                mode      : int16;
                fname     : in out String;
                c_type    : out int16;
                ap_id     : out int16)
               return int16 renames Search;
    function appl_control(
                ap_cid    : int16;
                ap_cwhat  : int16;
                ap_cout   : void_ptr)
               return int16 renames Control;
    function appl_getinfo(
                c_type    : int16;
                out1      : out int16;
                out2      : out int16;
                out3      : out int16;
                out4      : out int16)
               return boolean renames Get_Info;
    function appl_getinfo(
                c_type    : int16;
                out1      : chars_ptr;
                out2      : chars_ptr;
                out3      : chars_ptr;
                out4      : chars_ptr)
               return boolean renames Get_Info;

end Atari.Aes.Application;
