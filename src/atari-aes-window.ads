package Atari.Aes.Window is

    DESKTOP_HANDLE      : constant  := 0;
    DESK                : constant  := 0;

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
    type Action_Type is (
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
    for Action_Type use (
        WF_KIND              => 1,                      -- *< get     the actual window attributes (set supported by N.Aes only)
        WF_NAME              => 2,                      -- *< get/set title name of the window
        WF_INFO              => 3,                      -- *< get/set info line of the window
        WF_WORKXYWH          => 4,                      -- *< get     the work area coordinates of the work area
        WF_CURRXYWH          => 5,                      -- *< get/set current coordinates of the window (external area)
        WF_PREVXYWH          => 6,                      -- *< get     the previous coordinates of the window (external area)
        WF_FULLXYWH          => 7,                      -- *< get     the coordinates of the window when "fulled" the screen
        WF_HSLIDE            => 8,                      -- *< get/set position of the horizontal slider
        WF_VSLIDE            => 9,                      -- *< get/set position of the vertical slider
        WF_TOP               => 10,                     -- *< get/set top window
        WF_FIRSTXYWH         => 11,                     -- *< get     the first rectangle in the list of rectangles for this window
        WF_NEXTXYWH          => 12,                     -- *< get     the next rectangle in the list of rectangles for this window
        WF_FIRSTAREAXYWH     => 13,                     -- *< get     the first rectangle in the list of rectangles for this window
        WF_NEWDESK           => 14,                     -- *< get/set OBJECT tree installed as desktop
        WF_HSLSIZE           => 15,                     -- *< get/set size of the horizontal slider
        WF_VSLSIZE           => 16,                     -- *< get/set size of the vertical slider
        WF_SCREEN            => 17,                     -- *< get     current AES menu/alert buffer and its size
        WF_COLOR             => 18,                     -- *< get/set current color of widget
        WF_DCOLOR            => 19,                     -- *< get/set default color of widget
        WF_OWNER             => 20,                     -- *< get     the owner of the window
        WF_BEVENT            => 24,                     -- *< get/set window feature on mouse button event
        WF_BOTTOM            => 25,                     -- *< get/set bottom window
        WF_ICONIFY           => 26,                     -- *< get/set iconification of the window
        WF_UNICONIFY         => 27,                     -- *< get/set un-iconification of the window
        WF_UNICONIFYXYWH     => 28,                     -- *<     set window coordinates when uniconified
        WF_TOOLBAR           => 30,                     -- *< get/set tool bar attached to a window
        WF_FTOOLBAR          => 31,                     -- *< get     the first rectangle of the toolbar area
        WF_NTOOLBAR          => 32,                     -- *< get     the next rectangle of the toolbar area
        WF_MENU              => 33,                     -- *< get/set TODO (XaAES)
        WF_WHEEL             => 40,                     -- *< get/set window feature on mouse wheel event
        WF_OPTS              => 41,                     -- *< get/set window options
        WF_CALCF2W           => 42,                     -- *< get     Convert FULL coordinates to WORK coordinates
        WF_CALCW2F           => 43,                     -- *< get     Convert WORK coordinates to FULL coordinates
        WF_CALCF2U           => 44,                     -- *< get     Convert FULL coordinates to USER coordinates
        WF_CALCU2F           => 45,                     -- *< get     Convert USER coordinates to FULL coordinates
        WF_MAXWORKXYWH       => 46,                     -- *< get     MAX coordinates for this window - WCOWORK mode only
        WF_M_BACKDROP        => 100,                    -- *< get/set TODO (KAOS 1.4)
        WF_M_OWNER           => 101,                    -- *< get     (KAOS 1.4), same as WF_OWNER
        WF_M_WINDLIST        => 102,                    -- *< get     TODO (KAOS 1.4)
        WF_MINXYWH           => 103,                    -- *< get/set TODO (MagiC 6)
        WF_INFOXYWH          => 104,                    -- *< get     TODO (MagiC 6.10)
        WF_WIDGETS           => 200,                    -- *< get/set actual positions of the slider widgets
        WF_USER_POINTER      => 230,                    -- *< get/set MyAES - attach a 32 bit value to window
        WF_WIND_ATTACH       => 231,                    -- *<     set MyAES - attach a window to another
        WF_TOPMOST           => 232,                    -- *<     set MyAES    set actual window at TOPMOST level
        WF_BITMAP            => 233,                    -- *< get     MyAES 0.96    get bitmap of the window
        WF_OPTIONS           => 234,                    -- *<     set MyAES 0.96 at this time use only to request automaticaly close if application lost focus and appear when focus is back
        WF_FULLSCREEN        => 235,                    -- *<     set MyAES 0.96 set window in fullscreen without widget
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
        WF_WINX              => 22360,                  -- *< get     TODO
        WF_WINXCFG           => 22361,                  -- *< get/set TODO
        WF_DDELAY            => 22362,                  -- *< get/set TODO
        WF_SHADE             => 22365,                  -- *< get/set TODO (WINX 2.3)
        WF_STACK             => 22366,                  -- *<     set TODO (WINX 2.3)
        WF_TOPALL            => 22367,                  -- *<     set TODO (WINX 2.3)
        WF_BOTTOMALL         => 22368,                  -- *<     set TODO (WINX 2.3)
        WF_XAAES             => 16#5841#                -- *< get     TODO (XaAES) : 'XA'
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


    type MOBLK is
        record
            m_out: aliased int16;
            m_x  : aliased int16;
            m_y  : aliased int16;
            m_w  : aliased int16;
            m_h  : aliased int16;
        end record;


    function Draw(
                WindowHandle: int16;
                startob     : int16)
               return int16;

    function Create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16)
               return int16;

    function Create(
                Parts     : int16;
                r         : in Rectangle)
               return int16;

    -- wind_xcreate
    function Create(
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
    function Create(
                Parts     : int16;
                r         : in Rectangle;
                ret       : out Rectangle)
               return int16;

    function Open(
                WindowHandle: int16;
                Wx          : int16;
                Wy          : int16;
                Ww          : int16;
                Wh          : int16)
               return int16;

    function Open(
                WindowHandle: int16;
                r           : in Rectangle)
               return int16;

    function Close(
                WindowHandle: int16)
               return int16;

    function Delete(
                WindowHandle: int16)
               return int16;

    --
    -- possible Action_Type:
    --    WF_INFO,
    --    WF_NAME:          => error, use Get(String)
    --    WF_WORKXYWH,
    --    WF_CURRXYWH,
    --    WF_PREVXYWH,
    --    WF_FULLXYWH,
    --    WF_FIRSTXYWH,
    --    WF_NEXTXYWH,
    --    WF_FIRSTAREAXYWH,
    --    WF_UNICONIFY,
    --    WF_FTOOLBAR,
    --    WF_NTOOLBAR,
    --    WF_CALCF2W,
    --    WF_CALCW2F,
    --    WF_CALCF2U,
    --    WF_CALCU2F,
    --    WF_MAXWORKXYWH,
    --    WF_MINXYWH,
    --    WF_INFOXYWH:      => Rectangle in W1, W2, W3, W4
    --    WF_KIND,
    --    WF_HSLIDE,
    --    WF_VSLIDE,
    --    WF_HSLSIZE,
    --    WF_VSLSIZE,
    --    WF_COLOR,
    --    WF_DCOLOR,
    --    WF_OWNER,
    --    WF_M_OWNER,
    --    WF_BEVENT,
    --    WF_M_BACKDROP,
    --    WF_WINX,
    --    WF_WINXCFG,
    --    WF_DDELAY,
    --    WF_SHADE,
    --    WF_XAAES:         => value in W1
    --    WF_BOTTOM:        => Appl ID in W1, open flag in W2, window above in W3, window below in W4
    --    WF_NEWDESK,
    --    WF_SCREEN,
    --    WF_TOOLBAR,
    --    WF_MENU,
    --    WF_OPTS,
    --    WF_M_WINDLIST,
    --    WF_USER_POINTER,
    --    WF_BITMAP:        => hi(ptr) in W1, lo(ptr) in W2
    --    WF_ICONIFY:       => flag in W1, width in W2, height in W3
    --    WF_UNICONIFY,
    --    WF_TOPMOST,
    --    WF_OPTIONS,
    --    WF_STACK,
    --    WF_TOPALL,
    --    WF_BOTTOMALL:     => error, not supported by AES
    --    WF_WHEEL:         => flag in W1, mode in W2
    --    WF_WIDGETS:       => positions in W1, W2, W3, W4
    --
    --    others:           => error, not supported by AES
    --
    function Get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : out int16;
                W2          : out int16;
                W3          : out int16;
                W4          : out int16)
               return int16;

    function Get(
                WindowHandle: int16;
                What        : Action_Type;
                r           : out Rectangle)
               return int16;

    function Get(
                WindowHandle: int16;
                What        : Action_Type;
                clip        : in Rectangle;
                r           : out Rectangle)
               return int16;

    function Get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : out int16)
               return int16;

    function Get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : chars_ptr)
               return int16;

    --
    -- possible Action_Type:
    --    WF_INFO,
    --    WF_NAME:          => error, use Set(String)
    --    WF_CURRXYWH,
    --    WF_UNICONIFY,
    --    WF_FTOOLBAR,
    --    WF_NTOOLBAR,
    --    WF_UNICONIFY,
    --    WF_MINXYWH,
    --    WF_ICONIFY:      => Rectangle in W1, W2, W3, W4
    --    WF_HSLIDE,
    --    WF_VSLIDE,
    --    WF_HSLSIZE,
    --    WF_VSLSIZE,
    --    WF_COLOR,
    --    WF_DCOLOR,
    --    WF_BEVENT,
    --    WF_M_BACKDROP,
    --    WF_WINXCFG,
    --    WF_DDELAY,
    --    WF_TOPMOST,
    --    WF_OPTIONS,
    --    WF_STACK,
    --    WF_TOPALL,
    --    WF_BOTTOMALL,
    --    WF_SHADE:         => value in W1
    --    WF_WHEEL:         => flag in W1, mode in W2
    --    WF_BOTTOM:        => Appl ID in W1, open flag in W2, window above in W3, window below in W4
    --    WF_NEWDESK,
    --    WF_TOOLBAR,
    --    WF_MENU,
    --    WF_OPTS,
    --    WF_USER_POINTER:  => hi(ptr) in W1, lo(ptr) in W2
    --    WF_KIND,
    --    WF_WORKXYWH,
    --    WF_PREVXYWH,
    --    WF_FULLXYWH,
    --    WF_FIRSTXYWH,
    --    WF_NEXTXYWH,
    --    WF_FIRSTAREAXYWH,
    --    WF_SCREEN,
    --    WF_OWNER,
    --    WF_M_OWNER,
    --    WF_M_WINDLIST,
    --    WF_CALCF2W,
    --    WF_CALCW2F,
    --    WF_CALCF2U,
    --    WF_CALCU2F
    --    WF_INFOXYWH,
    --    WF_MAXWORKXYWH,
    --    WF_BITMAP,
    --    WF_INFOXYWH,
    --    WF_WINX,
    --    WF_XAAES:         => error, not supported by AES
    --    WF_WIDGETS:       => positions in W1, W2, W3, W4
    --
    --    others:           => error, not supported by AES
    --
    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : int16;
                W2          : int16;
                W3          : int16;
                W4          : int16)
               return int16;

    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                r           : in Rectangle)
               return int16;

    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                s           : in Rectangle;
                r           : out Rectangle)
               return int16;

    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                str         : const_chars_ptr)
               return int16;

    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : int16 := 0)
               return int16;

    function Set(
                WindowHandle: int16;
                What        : Action_Type;
                v           : System.Address;
                W3          : int16 := 0)
               return int16;

    function Find(
                X         : int16;
                Y         : int16)
               return int16;

    function Update(
                Code      : int16)
               return int16;

    procedure Calc(
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

    procedure Calc(
                c_Type    : int16;
                Parts     : int16;
                c_In      : in Rectangle;
                c_Out     : out Rectangle);

    -- procedure New renames;



    function wind_draw(
                WindowHandle: int16;
                startob     : int16)
               return int16 renames Draw;

    function wind_create(
                Parts     : int16;
                Wx        : int16;
                Wy        : int16;
                Ww        : int16;
                Wh        : int16)
               return int16 renames Create;

    function wind_create(
                Parts     : int16;
                r         : in Rectangle)
               return int16 renames Create;

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
               return int16 renames Create;

    -- wind_xcreate
    function wind_create(
                Parts     : int16;
                r         : in Rectangle;
                ret       : out Rectangle)
               return int16 renames Create;

    function wind_open(
                WindowHandle: int16;
                Wx          : int16;
                Wy          : int16;
                Ww          : int16;
                Wh          : int16)
               return int16 renames Open;

    function wind_open(
                WindowHandle: int16;
                r           : in Rectangle)
               return int16 renames Open;

    function wind_close(
                WindowHandle: int16)
               return int16 renames Close;

    function wind_delete(
                WindowHandle: int16)
               return int16 renames Delete;

    function wind_get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : out int16;
                W2          : out int16;
                W3          : out int16;
                W4          : out int16)
               return int16 renames Get;

    function wind_get(
                WindowHandle: int16;
                What        : Action_Type;
                r           : out Rectangle)
               return int16 renames Get;

    function wind_get(
                WindowHandle: int16;
                What        : Action_Type;
                clip        : in Rectangle;
                r           : out Rectangle)
               return int16 renames Get;

    function wind_get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : out int16)
               return int16 renames Get;

    function wind_get(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : chars_ptr)
               return int16 renames Get;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : int16;
                W2          : int16;
                W3          : int16;
                W4          : int16)
               return int16 renames Set;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                r           : in Rectangle)
               return int16 renames Set;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                s           : in Rectangle;
                r           : out Rectangle)
               return int16 renames Set;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                str         : const_chars_ptr)
               return int16 renames Set;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                W1          : int16 := 0)
               return int16 renames Set;

    function wind_set(
                WindowHandle: int16;
                What        : Action_Type;
                v           : void_ptr;
                W3          : int16 := 0)
               return int16 renames Set;

    function wind_find(
                X         : int16;
                Y         : int16)
               return int16 renames Find;

    function wind_update(
                Code      : int16)
               return int16 renames Update;

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
                OutH      : out int16) renames Calc;

    procedure wind_calc(
                c_Type    : int16;
                Parts     : int16;
                c_In      : in Rectangle;
                c_Out     : out Rectangle) renames Calc;

    --  procedure wind_new renames New;


end Atari.Aes.Window;
