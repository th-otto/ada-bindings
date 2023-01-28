--
-- NOT YET IMPLEMENTED:
-- edit_*

-- Geneva functions



package Atari.Aes is
    --
    -- AES
    --

    NIL                 : constant  := -1;                      -- *< Value for no more object in object
    DESKTOP_HANDLE      : constant  := 0;
    DESK                : constant  := 0;
    ROOT                : constant  := 0;                       -- *< index of the root object of a formular
    MAX_DEPTH           : constant  := 8;                       -- max depth of search or draw

    -- AES standard object colors
    G_WHITE              : constant int16 := 0;
    G_BLACK              : constant int16 := 1;
    G_RED                : constant int16 := 2;
    G_GREEN              : constant int16 := 3;
    G_BLUE               : constant int16 := 4;
    G_CYAN               : constant int16 := 5;
    G_YELLOW             : constant int16 := 6;
    G_MAGENTA            : constant int16 := 7;
    G_LWHITE             : constant int16 := 8;
    G_LBLACK             : constant int16 := 9;
    G_LRED               : constant int16 := 10;
    G_LGREEN             : constant int16 := 11;
    G_LBLUE              : constant int16 := 12;
    G_LCYAN              : constant int16 := 13;
    G_LYELLOW            : constant int16 := 14;
    G_LMAGENTA           : constant int16 := 15;

    LEFT_BUTTON          : constant  := 16#1#;                  -- *< mask for left mouse button, see mt_evnt_button()
    RIGHT_BUTTON         : constant  := 16#2#;                  -- *< mask for right mouse button, see mt_evnt_button()
    MIDDLE_BUTTON        : constant  := 16#4#;                  -- *< mask for middle mouse button, see mt_evnt_button()

    --  keyboard states (same as in bios)
    K_RSHIFT             : constant  := 16#1#;                  -- *< mask for right shift key, see mt_evnt_button()
    K_LSHIFT             : constant  := 16#2#;                  -- *< mask for left shift key, see mt_evnt_button()
    K_SHIFT              : constant  := K_LSHIFT + K_RSHIFT;
    K_CTRL               : constant  := 16#4#;                  -- *< mask for control key, see mt_evnt_button()
    K_ALT                : constant  := 16#8#;                  -- *< mask for alternate key, see mt_evnt_button()
    K_CAPSLOCK           : constant  := 16#10#;

    EDC_INQUIRE          : constant  := 0;                      -- *< inquire double-clic rate, see mt_evnt_dclick()
    EDC_SET              : constant  := 1;                      -- *< set double-clic rate, see mt_evnt_dclick()

    -- messages as used by evnt_mesag()
    MN_SELECTED          : constant  := 10;
    WM_REDRAW            : constant  := 20;
    WM_TOPPED            : constant  := 21;
    WM_CLOSED            : constant  := 22;
    WM_FULLED            : constant  := 23;
    WM_ARROWED           : constant  := 24;
    WM_HSLID             : constant  := 25;
    WM_VSLID             : constant  := 26;
    WM_SIZED             : constant  := 27;
    WM_MOVED             : constant  := 28;
    WM_NEWTOP            : constant  := 29;
    WM_UNTOPPED          : constant  := 30;
    WM_ONTOP             : constant  := 31;
    WM_BOTTOM            : constant  := 33;
    WM_BOTTOMED          : constant  := 33;                     -- *< see #WM_BOTTOM
    WM_ICONIFY           : constant  := 34;
    WM_UNICONIFY         : constant  := 35;
    WM_ALLICONIFY        : constant  := 36;
    WM_TOOLBAR           : constant  := 37;
    WM_REPOSED           : constant  := 38;
    AC_OPEN              : constant  := 40;
    AC_CLOSE             : constant  := 41;
    AP_TERM              : constant  := 50;
    AP_TFAIL             : constant  := 51;
    AP_RESCHG            : constant  := 57;                     -- *< indicates a resolution change, see #AP_TERM
    CT_UPDATE            : constant  := 50;
    CT_MOVE              : constant  := 51;
    CT_NEWTOP            : constant  := 52;
    CT_KEY               : constant  := 53;
    SHUT_COMPLETED       : constant  := 60;
    RESCHG_COMPLETED     : constant  := 61;
    RESCH_COMPLETED      : constant  := RESCHG_COMPLETED;
    AP_DRAGDROP          : constant  := 63;
    SH_WDRAW             : constant  := 72;
    SC_CHANGED           : constant  := 80;
    PRN_CHANGED          : constant  := 82;
    FNT_CHANGED          : constant  := 83;
    THR_EXIT             : constant  := 88;
    PA_EXIT              : constant  := 89;
    CH_EXIT              : constant  := 90;
    WM_M_BDROPPED        : constant  := 100;                    -- KAOS 1.4
    SM_M_SPECIAL         : constant  := 101;
    SM_M_RES2            : constant  := 102;                    -- *< MAG!X screen manager extension
    SM_M_RES3            : constant  := 103;                    -- *< MAG!X screen manager extension
    SM_M_RES4            : constant  := 104;                    -- *< MAG!X screen manager extension
    SM_M_RES5            : constant  := 105;                    -- *< MAG!X screen manager extension
    SM_M_RES6            : constant  := 106;                    -- *< MAG!X screen manager extension
    SM_M_RES7            : constant  := 107;                    -- *< MAG!X screen manager extension
    SM_M_RES8            : constant  := 108;                    -- *< MAG!X screen manager extension
    SM_M_RES9            : constant  := 109;                    -- *< MAG!X screen manager extension
    WM_SHADED            : constant  := 22360;                  -- [WM_SHADED apid 0 win 0 0 0 0]
    WM_UNSHADED          : constant  := 22361;                  -- [WM_UNSHADED apid 0 win 0 0 0 0]
    WM_WHEEL             : constant  := 345;

    --  MAG!X screen manager extension
    SMC_TIDY_UP          : constant  := 0;                      -- MagiC 2
    SMC_TERMINATE        : constant  := 1;                      -- MagiC 2
    SMC_SWITCH           : constant  := 2;                      -- MagiC 2
    SMC_FREEZE           : constant  := 3;                      -- MagiC 2
    SMC_UNFREEZE         : constant  := 4;                      -- MagiC 2
    SMC_RES5             : constant  := 5;                      -- MagiC 2
    SMC_UNHIDEALL        : constant  := 6;                      -- MagiC 3.1
    SMC_HIDEOTHERS       : constant  := 7;                      -- MagiC 3.1
    SMC_HIDEACT          : constant  := 8;                      -- MagiC 3.1

    --  evnt_mouse modes
    MO_ENTER             : constant  := 0;                      -- *< Wait for mouse to enter rectangle, see mt_evnt_mouse()
    MO_LEAVE             : constant  := 1;                      -- *< Wait for mouse to leave rectangle, see mt_evnt_mouse()

    --  evnt_multi flags
    MU_KEYBD             : constant  := 16#1#;                  -- *< Wait for a user keypress, see mt_evnt_multi()
    MU_BUTTON            : constant  := 16#2#;                  -- *< Wait for the specified mouse button state, see mt_evnt_multi()
    MU_M1                : constant  := 16#4#;                  -- *< Wait for a mouse/rectangle event as specified, see mt_evnt_multi()
    MU_M2                : constant  := 16#8#;                  -- *< Wait for a mouse/rectangle event as specified, see mt_evnt_multi()
    MU_MESAG             : constant  := 16#10#;                 -- *< Wait for a message, see mt_evnt_multi()
    MU_TIMER             : constant  := 16#20#;                 -- *< Wait the specified amount of time, see mt_evnt_multi()
    MU_WHEEL             : constant  := 16#40#;                 -- (XaAES)
    MU_MX                : constant  := 16#80#;                 -- (XaAES)
    MU_NORM_KEYBD        : constant  := 16#100#;                -- (XaAES)
    MU_DYNAMIC_KEYBD     : constant  := 16#200#;                -- (XaAES)

    FA_NOICON            : constant String := "[0]";            -- *< display no icon, see mt_form_alert()
    FA_ERROR             : constant String := "[1]";            -- *< display Exclamation icon, see mt_form_alert()
    FA_QUESTION          : constant String := "[2]";            -- *< display Question icon, see mt_form_alert()
    FA_STOP              : constant String := "[3]";            -- *< display Stop icon, see mt_form_alert()
    FA_INFO              : constant String := "[4]";            -- *< display Info icon, see mt_form_alert()
    FA_DISK              : constant String := "[5]";            -- *< display Disk icon, see mt_form_alert()

    --  Form dialog space actions, as used by form_dial()
    FMD_START            : constant  := 0;                      -- *< reserves the screen space for a dialog, see mt_form_dial()
    FMD_GROW             : constant  := 1;                      -- *< draws an expanding box, see mt_form_dial()
    FMD_SHRINK           : constant  := 2;                      -- *< draws a shrinking box, see mt_form_dial()
    FMD_FINISH           : constant  := 3;                      -- *< releases the screen space for a dialog, see mt_form_dial()

    FERR_FILENOTFOUND    : constant  := 2;                      -- *< File Not Found (GEMDOS error -33), see mt_form_error()
    FERR_PATHNOTFOUND    : constant  := 3;                      -- *< Path Not Found (GEMDOS error -34), see mt_form_error()
    FERR_NOHANDLES       : constant  := 4;                      -- *< No More File Handles (GEMDOS error -35), see mt_form_error()
    FERR_ACCESSDENIED    : constant  := 5;                      -- *< Access Denied (GEMDOS error -36), see mt_form_error()
    FERR_LOWMEM          : constant  := 8;                      -- *< Insufficient Memory (GEMDOS error -39), see mt_form_error()
    FERR_BADENVIRON      : constant  := 10;                     -- *< Invalid Environment (GEMDOS error -41), see mt_form_error()
    FERR_BADFORMAT       : constant  := 11;                     -- *< Invalid Format (GEMDOS error -42)
    FERR_BADDRIVE        : constant  := 15;                     -- *< Invalid Drive Specification (GEMDOS error -46), see mt_form_error()
    FERR_DELETEDIR       : constant  := 16;                     -- *< Attempt To Delete Working Directory (GEMDOS error -47), see mt_form_error()
    FERR_NOFILES         : constant  := 18;                     -- *< No More Files (GEMDOS error -49), see mt_form_error()

    FSEL_CANCEL          : constant  := 0;                      -- *< the fileselector has been closed by using the CANCEL button, see mt_fsel_exinput()
    FSEL_OK              : constant  := 1;                      -- *< the fileselector has been closed by using the OK button, see mt_fsel_exinput()

    --  menu_attach modes
    ME_INQUIRE           : constant  := 0;                      -- *< inquire information on a sub-menu attached, see mt_menu_attach()
    ME_ATTACH            : constant  := 1;                      -- *< attach or change a sub-menu, see mt_menu_attach()
    ME_REMOVE            : constant  := 2;                      -- *< remove a sub-menu. see mt_menu_attach()

    --  menu_attach attributes
    SCROLL_NO            : constant  := 0;                      -- *< the menu will not scroll, see MENU::mn_scroll structure
    SCROLL_YES           : constant  := 1;                      -- *< menu may scroll if it is too high, see MENU::mn_scroll structure

    --  Menu definitions as used by menu_bar()
    MENU_INQUIRE         : constant  := -1;                     -- *< inquire the AES application ID of the process which own the displayed menu, see mt_menu_bar()
    MENU_REMOVE          : constant  := 0;                      -- *< remove a menu bar, see mt_menu_bar()
    MENU_INSTALL         : constant  := 1;                      -- *< install a menu bar, see mt_menu_bar()
    MENU_GETMODE         : constant  := 3;                      -- *< Get the menu bar mode, see mt_menu_bar()
    MENU_SETMODE         : constant  := 4;                      -- *< Set the menu bar mode, see mt_menu_bar()
    MENU_UPDATE          : constant  := 5;                      -- *< Update the system part of the menu bar, see mt_menu_bar()
    MENU_INSTL           : constant  := 100;                    -- *< Install a menu without switching the top application (Magic), see mt_menu_bar()
    MENU_HIDDEN          : constant  := 16#1#;                  -- *< menu bar only visible when needed, see #MENU_GETMODE or #MENU_SETMODE
    MENU_PULLDOWN        : constant  := 16#2#;                  -- *< Pulldown-Menus, see #MENU_GETMODE or #MENU_SETMODE
    MENU_SHADOWED        : constant  := 16#4#;                  -- *< menu bar with shadows, see #MENU_GETMODE or #MENU_SETMODE

    UNCHECK              : constant  := 0;                      -- *< remove the check mark of a menu item, see mt_menu_icheck()
    CHECK                : constant  := 1;                      -- *< set a check mark of a menu item, see mt_menu_icheck()

    DISABLE              : constant  := 0;                      -- *< disable a menu item, see mt_menu_ienable()
    ENABLE               : constant  := 1;                      -- *< enable a menu item, see mt_menu_ienable()

    MIS_GETALIGN         : constant  := 0;                      -- *< get the alignment of a parent menu item with a sub-menu item, see mt_menu_istart()
    MIS_SETALIGN         : constant  := 1;                      -- *< set the alignment of a parent menu item with a sub-menu item, see mt_menu_istart()

    --  menu_popup modes
    SCROLL_LISTBOX       : constant  := -1;                     -- *< display a drop-down list (with slider) instead of popup menu, see MENU::mn_scroll

    REG_NEWNAME          : constant  := -1;                     -- *< register your application with a new name, see mt_menu_register()

    MN_INQUIRE           : constant  := 0;                      -- *< inquire the current menu settings, see mt_menu_settings()
    MN_CHANGE            : constant  := 1;                      -- *< set the menu settings, see mt_menu_settings()

    HIGHLIGHT            : constant  := 0;                      -- *< display the title in reverse mode, see mt_menu_tnormal()
    UNHIGHLIGHT          : constant  := 1;                      -- *< display the title in normal mode, see mt_menu_tnormal()

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

    --  scrp_read return values
    SCRAP_CSV            : constant  := 16#1#;                  -- *< clipboard has a scrap.csv file, see mt_scrap_read()
    SCRAP_TXT            : constant  := 16#2#;                  -- *< clipboard has a scrap.txt file, see mt_scrap_read()
    SCRAP_GEM            : constant  := 16#4#;                  -- *< clipboard has a scrap.gem file, see mt_scrap_read()
    SCRAP_IMG            : constant  := 16#8#;                  -- *< clipboard has a scrap.img file, see mt_scrap_read()
    SCRAP_DCA            : constant  := 16#10#;                 -- *< clipboard has a scrap.dca file, see mt_scrap_read()
    SCRAP_DIF            : constant  := 16#20#;                 -- *< clipboard has a scrap.dif file, see mt_scrap_read()
    SCRAP_USR            : constant  := 16#8000#;               -- *< clipboard has a scrap.usr file, see mt_scrap_read()

    --  kinds, as used by wind_create()
    NAME                 : constant  := 16#1#;                  -- *< Window has a title bar
    CLOSER               : constant  := 16#2#;                  -- *< Window has a close box
    FULLER               : constant  := 16#4#;                  -- *< Window has a fuller box
    MOVER                : constant  := 16#8#;                  -- *< Window may be moved by the user
    INFO                 : constant  := 16#10#;                 -- *< Window has an information line
    SIZER                : constant  := 16#20#;                 -- *< Window has a sizer box
    UPARROW              : constant  := 16#40#;                 -- *< Window has an up arrow
    DNARROW              : constant  := 16#80#;                 -- *< Window has a down arrow
    VSLIDE               : constant  := 16#100#;                -- *< Window has a vertical slider
    LFARROW              : constant  := 16#200#;                -- *< Window has a left arrow
    RTARROW              : constant  := 16#400#;                -- *< Window has a right arrow
    HSLIDE               : constant  := 16#800#;                -- *< Window has a horizontal slider
    HOTCLOSEBOX          : constant  := 16#1000#;               -- *< Window has "hot close box" box (GEM 2.x)
    MENUBAR              : constant  := 16#1000#;               -- *< Window has a menu bar (XaAES)
    BACKDROP             : constant  := 16#2000#;               -- *< Window has a backdrop box
    SMALLER              : constant  := 16#4000#;               -- *< Window has an iconifier
    BORDER               : constant  := 16#8000#;               -- *< Window has border-resizable capability (XaAES newer than Nov 8 2004)
    ICONIFIER            : constant  := 16#4000#;               -- *< Window has an iconifier

    --  window calculation types as used by wind_calc()
    WC_BORDER            : constant  := 0;                      -- *< compute the extent of a window from its work area, see mt_wind_calc()
    WC_WORK              : constant  := 1;                      -- *< compute the work_area of a window from its extent, see mt_wind_calc()

    --  window flags as used by wind_set()/wind_get()
    type wind_get_set_type is (
        WF_KIND,
        WF_NAME,
        WF_INFO,
        WF_WORKXYWH,
        WF_CURRXYWH,
        WF_PREVXYWH,
        WF_FULLXYWH,
        WF_HSLIDE,
        WF_VSLIDE,
        WF_TOP,
        WF_FIRSTXYWH,
        WF_NEXTXYWH,
        WF_FIRSTAREAXYWH,
        WF_NEWDESK,
        WF_HSLSIZE,
        WF_VSLSIZE,
        WF_SCREEN,
        WF_COLOR,
        WF_DCOLOR,
        WF_OWNER,
        WF_BEVENT,
        WF_BOTTOM,
        WF_ICONIFY,
        WF_UNICONIFY,
        WF_UNICONIFYXYWH,
        WF_TOOLBAR,
        WF_FTOOLBAR,
        WF_NTOOLBAR,
        WF_MENU,
        WF_WHEEL,
        WF_OPTS,
        WF_CALCF2W,
        WF_CALCW2F,
        WF_CALCF2U,
        WF_CALCU2F,
        WF_MAXWORKXYWH,
        WF_M_BACKDROP,
        WF_M_OWNER,
        WF_M_WINDLIST,
        WF_MINXYWH,
        WF_INFOXYWH,
        WF_WIDGETS,
        WF_USER_POINTER,
        WF_WIND_ATTACH,
        WF_TOPMOST,
        WF_BITMAP,
        WF_OPTIONS,
        WF_FULLSCREEN,
        WF_OBFLAG,
        WF_OBTYPE,
        WF_OBSPEC,
        X_WF_MENU,
        X_WF_DIALOG,
        X_WF_DIALWID,
        X_WF_DIALHT,
        X_WF_DFLTDESK,
        X_WF_MINMAX,
        X_WF_HSPLIT,
        X_WF_VSPLIT,
        X_WF_SPLMIN,
        X_WF_HSLIDE2,
        X_WF_VSLIDE2,
        X_WF_HSLSIZE2,
        X_WF_VSLSIZE2,
        X_WF_DIALFLGS,
        X_WF_OBJHAND,
        X_WF_DIALEDIT,
        X_WF_DCOLSTAT,
        WF_WINX,
        WF_WINXCFG,
        WF_DDELAY,
        WF_SHADE,
        WF_STACK,
        WF_TOPALL,
        WF_BOTTOMALL,
        WF_XAAES
    );
    for wind_get_set_type use (
        WF_KIND              => 1,                      -- *< get     the actual window attributes, see mt_wind_get()
        WF_NAME              => 2,                      -- *< get/set title name of the window, see mt_wind_get() and mt_wind_set()
        WF_INFO              => 3,                      -- *< get/set info line of the window, see mt_wind_get() and mt_wind_set()
        WF_WORKXYWH          => 4,                      -- *< get     the work area coordinates of the work area, see mt_wind_get()
        WF_CURRXYWH          => 5,                      -- *< get/set current coordinates of the window (external area), see mt_wind_get() and mt_wind_set()
        WF_PREVXYWH          => 6,                      -- *< get     the previous coordinates of the window (external area), see mt_wind_get()
        WF_FULLXYWH          => 7,                      -- *< get     the coordinates of the window when "fulled" the screen, see mt_wind_get()
        WF_HSLIDE            => 8,                      -- *< get/set position of the horizontal slider, see mt_wind_get() and mt_wind_set()
        WF_VSLIDE            => 9,                      -- *< get/set position of the vertical slider, see mt_wind_get() and mt_wind_set()
        WF_TOP               => 10,                     -- *< get/set top window, see mt_wind_get() and mt_wind_set()
        WF_FIRSTXYWH         => 11,                     -- *< get     the first rectangle in the list of rectangles for this window, see mt_wind_get()
        WF_NEXTXYWH          => 12,                     -- *< get     the next rectangle in the list of rectangles for this window, see mt_wind_get()
        WF_FIRSTAREAXYWH     => 13,                     -- *< get     the first rectangle in the list of rectangles for this window, see mt_wind_xget()
        WF_NEWDESK           => 14,                     -- *< get/set OBJECT tree installed as desktop, see mt_wind_get() and mt_wind_set()
        WF_HSLSIZE           => 15,                     -- *< get/set size of the horizontal slider, see mt_wind_get() and mt_wind_set()
        WF_VSLSIZE           => 16,                     -- *< get/set size of the vertical slider, see mt_wind_get() and mt_wind_set()
        WF_SCREEN            => 17,                     -- *< get     current AES menu/alert buffer and its size, see mt_wind_get()
        WF_COLOR             => 18,                     -- *< get/set current color of widget, see mt_wind_get() and mt_wind_set()
        WF_DCOLOR            => 19,                     -- *< get/set default color of widget, see mt_wind_get() and mt_wind_set()
        WF_OWNER             => 20,                     -- *< get     the owner of the window, see mt_wind_get()
        WF_BEVENT            => 24,                     -- *< get/set window feature on mouse button event, see mt_wind_get() and mt_wind_set()
        WF_BOTTOM            => 25,                     -- *< get/set bottom window, see mt_wind_get() and mt_wind_set()
        WF_ICONIFY           => 26,                     -- *< get/set iconification of the window, see mt_wind_get() and mt_wind_set()
        WF_UNICONIFY         => 27,                     -- *< get/set un-iconification of the window, see mt_wind_get() and mt_wind_set()
        WF_UNICONIFYXYWH     => 28,                     -- *<     set window coordinates when uniconified , see mt_wind_set()
        WF_TOOLBAR           => 30,                     -- *< get/set tool bar attached to a window, see mt_wind_get() and mt_wind_set()
        WF_FTOOLBAR          => 31,                     -- *< get     the first rectangle of the toolbar area, see mt_wind_get()
        WF_NTOOLBAR          => 32,                     -- *< get     the next rectangle of the toolbar area, see mt_wind_get()
        WF_MENU              => 33,                     -- *<         TODO (XaAES)
        WF_WHEEL             => 40,                     -- *<     set window feature on mouse wheel event, see mt_wind_set()
        WF_OPTS              => 41,                     -- *< get/set window options. See mt_wind_set() and mt_wind_get() for details.
        WF_CALCF2W           => 42,                     -- *< Convert FULL coordinates to WORK coordinates
        WF_CALCW2F           => 43,                     -- *< Convert WORK coordinates to FULL coordinates
        WF_CALCF2U           => 44,                     -- *< Convert FULL coordinates to USER coordinates
        WF_CALCU2F           => 45,                     -- *< Convert USER coordinates to FULL coordinates
        WF_MAXWORKXYWH       => 46,                     -- *< Get MAX coordinates for this window - WCOWORK mode only
        WF_M_BACKDROP        => 100,                    -- *<        TODO (KAOS 1.4)
        WF_M_OWNER           => 101,                    -- *<        TODO (KAOS 1.4)
        WF_M_WINDLIST        => 102,                    -- *<        TODO (KAOS 1.4)
        WF_MINXYWH           => 103,                    -- *<        TODO (MagiC 6)
        WF_INFOXYWH          => 104,                    -- *<        TODO (MagiC 6.10)
        WF_WIDGETS           => 200,                    -- *< get/set actual positions of the slider widgets, see mt_wind_get() and mt_wind_set()
        WF_USER_POINTER      => 230,                    -- *< MyAES - attach a 32 bit value to window see  mt_wind_set() see mt_wind_get()
        WF_WIND_ATTACH       => 231,                    -- *< MyAES - attach a window to another, see mt_wind_set()
        WF_TOPMOST           => 232,                    -- *< MyAES    set actual window at TOPMOST level, see mt_wind_set()
        WF_BITMAP            => 233,                    -- *< MyAES 0.96    get bitmap of the window, see  mt_wind_get()
        WF_OPTIONS           => 234,                    -- *< MyAES 0.96 at this time use only to request automaticaly close if application lost focus and appear when focus is back, see mt_wind_set()
        WF_FULLSCREEN        => 235,                    -- *< MyAES 0.96 set window in fullscreen without widget, see mt_wind_set()
        WF_OBFLAG            => 1001,                   -- *< get/set (doc: TODO) (FreeGEM)
        WF_OBTYPE            => 1002,                   -- *< get     (doc: TODO) (FreeGEM)
        WF_OBSPEC            => 1003,                   -- *< get/set (doc: TODO) (FreeGEM)
        X_WF_MENU            => 16#1100#,               -- *<     set (doc: TODO) (Geneva)
        X_WF_DIALOG          => 16#1200#,               -- *<     set (doc: TODO) (Geneva)
        X_WF_DIALWID         => 16#1300#,               -- *<     set (doc: TODO) (Geneva)
        X_WF_DIALHT          => 16#1400#,               -- *<     set (doc: TODO) (Geneva)
        X_WF_DFLTDESK        => 16#1500#,               -- *<     set (doc: TODO) (Geneva)
        X_WF_MINMAX          => 16#1600#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_HSPLIT          => 16#1700#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_VSPLIT          => 16#1800#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_SPLMIN          => 16#1900#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_HSLIDE2         => 16#1a00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_VSLIDE2         => 16#1b00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_HSLSIZE2        => 16#1c00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_VSLSIZE2        => 16#1d00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_DIALFLGS        => 16#1e00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_OBJHAND         => 16#1f00#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_DIALEDIT        => 16#2000#,               -- *< get/set (doc: TODO) (Geneva)
        X_WF_DCOLSTAT        => 16#2100#,               -- *< get/set (doc: TODO) (Geneva)
        WF_WINX              => 22360,                  -- *<        TODO
        WF_WINXCFG           => 22361,                  -- *<        TODO
        WF_DDELAY            => 22362,                  -- *<        TODO
        WF_SHADE             => 22365,                  -- *<        TODO (WINX 2.3)
        WF_STACK             => 22366,                  -- *<        TODO (WINX 2.3)
        WF_TOPALL            => 22367,                  -- *<        TODO (WINX 2.3)
        WF_BOTTOMALL         => 22368,                  -- *<        TODO (WINX 2.3)
        WF_XAAES             => 16#5841#                -- *<        TODO (XaAES) : 'XA'
    );

    --  wind_set(WF_BEVENT)
    BEVENT_WORK          : constant  := 16#1#;                  -- *< window not topped when click on the work area, see #WF_BEVENT
    BEVENT_INFO          : constant  := 16#2#;                  -- *< window not topped when click on the info area, see #WF_BEVENT

    --  wind_set(WF_OPTS) bitmask flags
    WO0_WHEEL            : constant  := 16#1#;                  -- *< see mt_wind_set() with #WF_OPTS mode
    WO0_FULLREDRAW       : constant  := 16#2#;                  -- *< see mt_wind_set() with #WF_OPTS mode
    WO0_NOBLITW          : constant  := 16#4#;                  -- *< see mt_wind_set() with #WF_OPTS mode
    WO0_NOBLITH          : constant  := 16#8#;                  -- *< see mt_wind_set() with #WF_OPTS mode
    WO0_SENDREPOS        : constant  := 16#10#;                 -- *< see mt_wind_set() with #WF_OPTS mode
    WO0_WCOWORK          : constant  := 16#20#;                 -- *< see mt_wind_set() with #WF_OPTS mode
    WO1_NONE             : constant  := 16#0#;                  -- *< see mt_wind_set() with #WF_OPTS mode
    WO2_NONE             : constant  := 16#0#;                  -- *< see mt_wind_set() with #WF_OPTS mode

    --  wind_set(WF_WHEEL) modes
    WHEEL_MESAG          : constant  := 0;                      -- *< AES will send #WM_WHEEL messages
    WHEEL_ARROWED        : constant  := 1;                      -- *< AES will send #WM_ARROWED messages
    WHEEL_SLIDER         : constant  := 2;                      -- *< AES will convert mouse wheel events to slider events

    --  WF_DCOLOR objects
    W_BOX                : constant  := 0;                      -- *< widget index of root object, see #WF_COLOR
    W_TITLE              : constant  := 1;                      -- *< widget index of titlebar, see #WF_COLOR
    W_CLOSER             : constant  := 2;                      -- *< widget index of closer gadget, see #WF_COLOR
    W_NAME               : constant  := 3;                      -- *< widget index of window name, see #WF_COLOR
    W_FULLER             : constant  := 4;                      -- *< widget index of fuller gadget, see #WF_COLOR
    W_INFO               : constant  := 5;                      -- *< widget index of info bar, see #WF_COLOR
    W_DATA               : constant  := 6;                      -- *< widget index of ???, see #WF_COLOR
    W_WORK               : constant  := 7;                      -- *< widget index of work area, see #WF_COLOR
    W_SIZER              : constant  := 8;                      -- *< widget index of sizer gadget, see #WF_COLOR
    W_VBAR               : constant  := 9;                      -- *< widget index of vertical bar background, see #WF_COLOR
    W_UPARROW            : constant  := 10;                     -- *< widget index of up arrow, see #WF_COLOR
    W_DNARROW            : constant  := 11;                     -- *< widget index of down arrow, see #WF_COLOR
    W_VSLIDE             : constant  := 12;                     -- *< widget index of vertical slider, see #WF_COLOR
    W_VELEV              : constant  := 13;                     -- *< widget index of vertical bar, see #WF_COLOR
    W_HBAR               : constant  := 14;                     -- *< widget index of horizontal bar background, see #WF_COLOR
    W_LFARROW            : constant  := 15;                     -- *< widget index of left arrow, see #WF_COLOR
    W_RTARROW            : constant  := 16;                     -- *< widget index of right arrow, see #WF_COLOR
    W_HSLIDE             : constant  := 17;                     -- *< widget index of horizontal slider, see #WF_COLOR
    W_HELEV              : constant  := 18;                     -- *< widget index of horizontal bar, see #WF_COLOR
    W_SMALLER            : constant  := 19;                     -- *< widget index of smaller gadget, see #WF_COLOR
    W_BOTTOMER           : constant  := 20;                     -- *< widget index of bottomer widget, see #WF_COLOR
    W_HIDER              : constant  := 30;                     -- *< widget index of hide widget, see #WF_COLOR

    --  arrow message
    WA_UPPAGE            : constant  := 0;                      -- *< Page Up,      see #WM_ARROWED
    WA_DNPAGE            : constant  := 1;                      -- *< Page Down,    see #WM_ARROWED
    WA_UPLINE            : constant  := 2;                      -- *< Row Up,       see #WM_ARROWED
    WA_DNLINE            : constant  := 3;                      -- *< Row Down,     see #WM_ARROWED
    WA_LFPAGE            : constant  := 4;                      -- *< Page Left ,   see #WM_ARROWED
    WA_RTPAGE            : constant  := 5;                      -- *< Page Right,   see #WM_ARROWED
    WA_LFLINE            : constant  := 6;                      -- *< Column Left,  see #WM_ARROWED
    WA_RTLINE            : constant  := 7;                      -- *< Column Right, see #WM_ARROWED
    WA_WHEEL             : constant  := 8;                      -- *< deprecated (introduced in XaAES release 0.964)
    WA_UPSCAN            : constant  := 8;                      -- XaAES only
    WA_DNSCAN            : constant  := 9;                      -- XaAES only
    WA_LFSCAN            : constant  := 10;                     -- XaAES only
    WA_RTSCAN            : constant  := 11;                     -- XaAES only

    --  window update flags as used by wind_update()
    END_UPDATE           : constant  := 0;                      -- *< release the screen lock, see mt_wind_update()
    BEG_UPDATE           : constant  := 1;                      -- *< lock the screen, see mt_wind_update()
    END_MCTRL            : constant  := 2;                      -- *< release the mouse control to the AES, see mt_wind_update()
    BEG_MCTRL            : constant  := 3;                      -- *< mouse button message only sent to the application, see mt_wind_update()
    BEG_CHECK            : constant  := 16#100#;                -- *< prevent the application from blocking, see mt_wind_update()

    --  AES mouse cursor number
    type Mouse_Type is (
        ARROW,
        TEXT_CRSR,
        BUSYBEE,
        POINT_HAND,
        FLAT_HAND,
        THIN_CROSS,
        THICK_CROSS,
        OUTLN_CROSS,
        X_LFTRT,
        X_UPDOWN,
        USER_DEF,
        M_OFF,
        M_ON,
        M_SAVE,
        M_RESTORE,
        M_LAST,
        XACRS_BUBBLE_DISC,
        XACRS_RESIZER,
        XACRS_NE_SIZER,
        XACRS_MOVER,
        XACRS_VERTSIZER,
        XACRS_HORSIZER,
        XACRS_POINTSLIDE,
        X_MRESET,
        X_MGET,
        X_MSET_SHAPE,
        M_FORCE
    );
    for Mouse_Type use (
        ARROW                => 0,                      -- *< see mt_graf_mouse()
        TEXT_CRSR            => 1,                      -- *< see mt_graf_mouse()
        BUSYBEE              => 2,                      -- *< see mt_graf_mouse()
        POINT_HAND           => 3,                      -- *< see mt_graf_mouse()
        FLAT_HAND            => 4,                      -- *< see mt_graf_mouse()
        THIN_CROSS           => 5,                      -- *< see mt_graf_mouse()
        THICK_CROSS          => 6,                      -- *< see mt_graf_mouse()
        OUTLN_CROSS          => 7,                      -- *< see mt_graf_mouse()
        X_LFTRT              => 8,                      -- Geneva, N.AES
        X_UPDOWN             => 9,                      -- Geneva, N.AES
        USER_DEF             => 255,                    -- *< see mt_graf_mouse()
        M_OFF                => 256,                    -- *< see mt_graf_mouse()
        M_ON                 => 257,                    -- *< see mt_graf_mouse()
        M_SAVE               => 258,                    -- *< see mt_graf_mouse()
        M_RESTORE            => 259,                    -- *< see mt_graf_mouse()
        M_LAST               => 260,                    -- *< see mt_graf_mouse()
        XACRS_BUBBLE_DISC    => 270,                    -- XaAES
        XACRS_RESIZER        => 271,                    -- XaAES
        XACRS_NE_SIZER       => 272,                    -- XaAES
        XACRS_MOVER          => 273,                    -- XaAES
        XACRS_VERTSIZER      => 274,                    -- XaAES
        XACRS_HORSIZER       => 275,                    -- XaAES
        XACRS_POINTSLIDE     => 276,                    -- XaAES
        X_MRESET             => 1000,                   -- geneva
        X_MGET               => 1001,                   -- geneva
        X_MSET_SHAPE         => 1100,                   -- geneva
        M_FORCE              => 16#8000#                -- *< see mt_graf_mouse()
    );
    for Mouse_Type'Size use int16'Size;
    BEE: constant Mouse_Type := BUSYBEE;
    BUSY_BEE: constant Mouse_Type := BUSYBEE;
    HOURGLASS: constant Mouse_Type := BUSYBEE;
    M_PREVIOUS: constant Mouse_Type := M_LAST;

    --  inside patterns
    IP_HOLLOW            : constant  := 0;
    IP_1PATT             : constant  := 1;
    IP_2PATT             : constant  := 2;
    IP_3PATT             : constant  := 3;
    IP_4PATT             : constant  := 4;
    IP_5PATT             : constant  := 5;
    IP_6PATT             : constant  := 6;
    IP_SOLID             : constant  := 7;

    --  font types
    GDOS_PROP            : constant  := 0;
    GDOS_MONO            : constant  := 1;
    GDOS_BITM            : constant  := 2;
    IBM                  : constant  := 3;
    SMALL                : constant  := 5;

    --  object types
    G_BOX                : constant  := 20;
    G_TEXT               : constant  := 21;
    G_BOXTEXT            : constant  := 22;
    G_IMAGE              : constant  := 23;
    G_USERDEF            : constant  := 24;
    G_PROGDEF            : constant  := 24;
    G_IBOX               : constant  := 25;
    G_BUTTON             : constant  := 26;
    G_BOXCHAR            : constant  := 27;
    G_STRING             : constant  := 28;
    G_FTEXT              : constant  := 29;
    G_FBOXTEXT           : constant  := 30;
    G_ICON               : constant  := 31;
    G_TITLE              : constant  := 32;
    G_CICON              : constant  := 33;
    G_SWBUTTON           : constant  := 34;
    G_POPUP              : constant  := 35;
    G_WINTITLE           : constant  := 36;
    G_EDIT               : constant  := 37;
    G_SHORTCUT           : constant  := 38;
    G_SLIST              : constant  := 39;
    G_EXTBOX             : constant  := 40;
    G_OBLINK             : constant  := 41;

    --  editable text field definitions
    ED_START             : constant  := 0;                      -- *< Reserved. Do not use, see mt_objc_edit()
    ED_INIT              : constant  := 1;                      -- *< turn ON the cursor, see mt_objc_edit()
    ED_CHAR              : constant  := 2;                      -- *< insert a character in the editable field, see mt_objc_ecit()
    ED_END               : constant  := 3;                      -- *< turn OFF the cursor, see mt_objc_edit()
    EDSTART              : constant  := 0;                      -- *< alias
    EDINIT               : constant  := 1;                      -- *< alias
    EDCHAR               : constant  := 2;                      -- *< alias
    EDEND                : constant  := 3;                      -- *< alias
    ED_DISABLE           : constant  := 5;
    ED_ENABLE            : constant  := 6;
    ED_CRSRON            : constant  := 7;
    ED_CRSROFF           : constant  := 8;
    ED_MARK              : constant  := 9;
    ED_STRING            : constant  := 10;
    ED_SETPTEXT          : constant  := 11;
    ED_SETPTMPLT         : constant  := 12;
    ED_SETPVALID         : constant  := 13;
    ED_GETPTEXT          : constant  := 14;
    ED_GETPTMPLT         : constant  := 15;
    ED_GETPVALID         : constant  := 16;
    ED_CRSR              : constant  := 100;                    -- *< TO BE COMPLETED (MagiC), see mt_objc_edit()
    ED_DRAW              : constant  := 103;                    -- *< TO BE COMPLETED (MagiC), see mt_objc_edit()
    ED_REDRAW            : constant  := 200;                    -- XaAES only
    ED_XINIT             : constant  := 201;
    ED_XCHAR             : constant  := 202;
    ED_XEND              : constant  := 203;                    -- Redraw cursor, XaAES only
    ED_CHGTEXTPTR        : constant  := 204;
    ED_CHGTMPLPTR        : constant  := 205;

    --  editable text justification
    TE_LEFT              : constant  := 0;
    TE_RIGHT             : constant  := 1;
    TE_CNTR              : constant  := 2;

    -- AP_DRAGDROP return codes
    DD_OK        : constant  := 0;
    DD_NAK       : constant  := 1;
    DD_EXT       : constant  := 2;
    DD_LEN       : constant  := 3;
    DD_TRASH     : constant  := 4;
    DD_PRINTER   : constant  := 5;
    DD_CLIPBOARD : constant  := 6;

    DD_TIMEOUT  : constant  := 4000;     -- Timeout in ms

    DD_NUMEXTS  : constant  := 8;        -- Number of formats
    DD_EXTLEN   : constant  := 4;
    DD_EXTSIZE  : constant  := DD_NUMEXTS * DD_EXTLEN;

    DD_FNAME    : constant String := "U:\PIPE\DRAGDROP.AA";
    DD_NAMEMAX  : constant  := 128;      -- Maximum length of a format name
    DD_HDRMIN   : constant  := 9;            -- Minimum length of Drag&Drop headers
    DD_HDRMAX   : constant  := 8 + DD_NAMEMAX;   -- Maximum length

    type AESContrl is record
        opcode: int16;
        num_intin: int16;
        num_intout: int16;
        num_addrin: int16;
        num_addrout: int16;
    end record;

    subtype AESGlobal is short_array(0..14);
    subtype AESIntIn is short_array(0..15);
    subtype AESIntOut is short_array(0..15);
    type AESAddrIn is array(0..7) of void_ptr;
    type AESAddrOut is array(0..1) of void_ptr;

    type AESContrl_ptr is access AESContrl;
    type AESGlobal_ptr is access AESGlobal;

    type AESPB is record
        control: access AESContrl;
        global: access AESGlobal;
        intin: access AESIntIn;
        intout: access AESIntOut;
        addrin: access AESAddrIn;
        addrout: access AESAddrOut;
    end record;
    type AESPB_ptr is access all AESPB;

    --  AES/VDI mouse form structure

    type MFORM is record
       mf_xhot: int16;          -- X-position hot-spot
       mf_yhot: int16;          -- Y-position hot-spot
       mf_nplanes: int16;       -- Number of planes
       mf_fg: int16;            -- Mask colour
       mf_bg: int16;            -- Pointer colour
       mf_mask: aliased short_array(0..15);       -- Mask form
       mf_data: aliased short_array(0..15);       -- Pointer form
    end record;
    pragma Convention (C, MFORM);
    type MFORM_ptr is access all MFORM;
    type MFORM_const_ptr is access constant MFORM;

    --  tail for default shell
    type SHELTAIL is
        record
            dummy  : aliased int16;
            magic  : aliased int32;
            isfirst: aliased int16;
            lasterr: aliased int32;
            wasgr  : aliased int16;
        end record;

    type Rectangle is
        record
            g_x: aliased int16;
            g_y: aliased int16;
            g_w: aliased int16;
            g_h: aliased int16;
        end record;
    type Rectangle_ptr is access all Rectangle;

    type MOBLK is
        record
            m_out: aliased int16;
            m_x  : aliased int16;
            m_y  : aliased int16;
            m_w  : aliased int16;
            m_h  : aliased int16;
        end record;


    type PXY is
        record
            p_x : aliased int16;
            p_y : aliased int16;
        end record;


    type EVMULT_IN is
        record
            emi_flags  : aliased int16;
            emi_bclicks: aliased int16;
            emi_bmask  : aliased uint16;
            emi_bstate : aliased uint16;
            emi_m1leave: aliased int16;
            emi_m1     : aliased Rectangle;
            emi_m2leave: aliased int16;
            emi_m2     : aliased Rectangle;
            emi_tlow   : aliased int16;
            emi_thigh  : aliased int16;
        end record;
    type EVMULT_IN_const_ptr is access constant EVMULT_IN;


    type EVMULT_OUT is
        record
            emo_events : aliased uint16;
            emo_mouse  : aliased PXY;
            emo_mbutton: aliased uint16;
            emo_kmeta  : aliased uint16;
            emo_kreturn: aliased int16;
            emo_mclicks: aliased int16;
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


    type aes_msg_simple is
        record
            msgtype: int16;
            from: int16;
            size: int16;
            handle: int16;
            menu_id: int16;
        end record;
    type aes_msg_rect is
        record
            msgtype: int16;
            from: int16;
            size: int16;
            handle: int16;
            rect: Rectangle;
        end record;
    type aes_msg_select is
        record
            msgtype: int16;
            from: int16;
            size: int16;
            title: int16;
            item: int16;
        end record;
    type Message_Buffer (Which: int16 := 0) is
        record
            case Which is
                when 0 => simple: aes_msg_simple;
                when 1 => rect: aes_msg_rect;
                when 2 => selected: aes_msg_select;
                when others => arr: short_array(0..7);
            end case;
        end record;
    pragma Convention(C, Message_Buffer);
    pragma Unchecked_Union(Message_Buffer);
    type Message_Buffer_ptr is access all Message_Buffer;

    aes_global: aliased AESglobal;

    -- FIXME: how to make private to sub-packages?
    aes_control: aliased AESContrl;
    aes_intin: aliased AESIntIn;
    aes_intout: aliased AESIntOut;
    aes_addrin: aliased AESAddrIn;
    aes_addrout: aliased AESAddrOut;

    procedure crystal(pb: AESPB_ptr) with Inline;
    procedure aes_trap with Inline;

    function vq_aes return int16;
    function vq_aes return boolean;


    --  old C-style names
	subtype GRECT is Rectangle;



    function evnt_keybd return int16;
    function evnt_button(
                Clicks     : int16;
                WhichButton: int16;
                WhichState : int16;
                Mx         : out int16;
                My         : out int16;
                ButtonState: out int16;
                KeyState   : out int16)
               return int16;
    procedure evnt_mouse(
                EnterExit  : int16;
                InX        : int16;
                InY        : int16;
                InW        : int16;
                InH        : int16;
                OutX       : out int16;
                OutY       : out int16;
                ButtonState: out int16;
                KeyState   : out int16);
    function evnt_mesag(
                MesagBuf  : out short_array)
               return int16;
    function evnt_mesag(
                MesagBuf  : out Message_Buffer)
               return int16;
    procedure evnt_timer(
                Interval  : uint32);
    function evnt_timer(
                locount  : int16;
                hicount  : int16)
               return int16;
    function evnt_multi(
                c_Type     : int16;
                Clicks     : int16;
                WhichButton: int16;
                WhichState : int16;
                EnterExit1 : int16;
                In1X       : int16;
                In1Y       : int16;
                In1W       : int16;
                In1H       : int16;
                EnterExit2 : int16;
                In2X       : int16;
                In2Y       : int16;
                In2W       : int16;
                In2H       : int16;
                MesagBuf   : out Message_Buffer;
                Interval   : uint32;
                OutX       : out int16;
                OutY       : out int16;
                ButtonState: out int16;
                KeyState   : out int16;
                Key        : out int16;
                ReturnCount: out int16)
               return int16;
    function evnt_multi(
                em_i       : in EVMULT_IN;
                MesagBuf   : out Message_Buffer;
                em_o       : out EVMULT_OUT)
               return int16;
    function evnt_dclick(
                ToSet     : int16;
                SetGet    : int16)
               return int16;





    function scrp_read(
                Scrappath : chars_ptr)
               return int16;

    function scrp_write(
                Scrappath : const_chars_ptr)
               return int16;

    function scrp_clear return int16;



    function fsel_input(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16)
               return int16;

    function fsel_exinput(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr)
               return int16;

    --  callback function used by BoxKite file selector. See fsel_boxinput()
    type FSEL_CALLBACK is access procedure(msg: access int16);
    pragma Convention(C, FSEL_CALLBACK);

    function fsel_boxinput(
                path       : chars_ptr;
                file       : chars_ptr;
                exit_button: out int16;
                title      : const_chars_ptr;
                callback   : FSEL_CALLBACK)
               return int16;




    function wind_draw(
                WindowHandle: int16;
                startob     : int16)
               return int16;

    function wind_create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16)
               return int16;

    function wind_create(
                Parts     : int16;
                r         : in Rectangle)
               return int16;

    -- wind_xcreate
    function wind_create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16;
                OutX      : out int16;
                OutY      : out int16;
                OutW      : out int16;
                OutH      : out int16)
               return int16;

    -- wind_xcreate
    function wind_create(
                Parts     : int16;
                r         : in Rectangle;
                ret       : out Rectangle)
               return int16;

    function wind_open(
                WindowHandle: int16;
                Wx          : int16;
                Wy          : int16;
                Ww          : int16;
                Wh          : int16)
               return int16;

    function wind_open(
                WindowHandle: int16;
                r           : in Rectangle)
               return int16;

    function wind_close(
                WindowHandle: int16)
               return int16;

    function wind_delete(
                WindowHandle: int16)
               return int16;

    function wind_get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : out int16;
                W2          : out int16;
                W3          : out int16;
                W4          : out int16)
               return int16;

    function wind_get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                r           : out Rectangle)
               return int16;

    function wind_get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                clip        : in Rectangle;
                r           : out Rectangle)
               return int16;

    function wind_get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : out int16)
               return int16;

    function wind_get(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : chars_ptr)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : int16;
                W2          : int16;
                W3          : int16;
                W4          : int16)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                r           : in Rectangle)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                s           : in Rectangle;
                r           : out Rectangle)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                str         : const_chars_ptr)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                W1          : int16 := 0)
               return int16;

    function wind_set(
                WindowHandle: int16;
                What        : wind_get_set_type;
                v           : void_ptr;
                W3          : int16 := 0)
               return int16;

    function wind_find(
                X         : int16;
                Y         : int16)
               return int16;

    function wind_update(
                Code      : int16)
               return int16;

    procedure wind_calc(
                c_Type    : int16;
                Parts     : int16;
                InX       : int16;
                InY       : int16;
                InW       : int16;
                InH       : int16;
                OutX      : out int16;
                OutY      : out int16;
                OutW      : out int16;
                OutH      : out int16);

    procedure wind_calc(
                c_Type    : int16;
                Parts     : int16;
                c_In      : in Rectangle;
                c_Out     : out Rectangle);

    procedure wind_new;




    function shel_read(
                Command   : chars_ptr;
                Tail      : chars_ptr)
               return int16;

    function shel_write(
                c_Exit    : int16;
                Graphic   : int16;
                Aes       : int16;
                Command   : void_ptr;
                Tail      : chars_ptr)
               return int16;

    function shel_get(
                Buf       : chars_ptr;
                Len       : int16)
               return int16;

    function shel_put(
                Buf       : chars_ptr;
                Len       : int16)
               return int16;

    function shel_find(
                buf       : chars_ptr)
               return int16;

    function shel_envrn(
                result    : out chars_ptr;
                param     : chars_ptr)
               return int16;

    procedure shel_rdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr);

    procedure shel_wdef(
                lpcmd     : chars_ptr;
                lpdir     : chars_ptr);

    function shel_help(
                sh_hmode  : int16;
                sh_hfile  : chars_ptr;
                sh_hkey   : chars_ptr)
               return int16;





    procedure rc_copy(
                src: in Rectangle;
                dst: out Rectangle);

    function rc_equal(
                r1: in Rectangle;
                r2: in Rectangle)
               return boolean;

    function rc_intersect(
                src: in Rectangle;
                dst: in out Rectangle)
               return boolean;

    procedure array_to_grect(
                c_array: short_array;
                area   : out Rectangle);

    procedure grect_to_array(
                area   : in Rectangle;
                c_array: out short_array);

end Atari.Aes;
