package Atari.Aes.Event is

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

    EDC_INQUIRE          : constant boolean := false;           -- *< inquire double-clic rate, see mt_evnt_dclick()
    EDC_SET              : constant boolean := true;            -- *< set double-clic rate, see mt_evnt_dclick()

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


    function Keybd return int16;
    function Button(
                Clicks     : int16;
                WhichButton: int16;
                WhichState : int16;
                Mx         : out int16;
                My         : out int16;
                ButtonState: out int16;
                KeyState   : out int16)
               return int16;
    procedure Mouse(
                EnterExit  : int16;
                InX        : int16;
                InY        : int16;
                InW        : int16;
                InH        : int16;
                OutX       : out int16;
                OutY       : out int16;
                ButtonState: out int16;
                KeyState   : out int16);
    function Message(
                MesagBuf  : out short_array)
               return int16;
    function Message(
                MesagBuf  : out Message_Buffer)
               return int16;
    procedure Timer(
                Interval  : uint32);
    function Timer(
                locount  : int16;
                hicount  : int16)
               return int16;
    function Multi(
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
    function Multi(
                em_i       : in EVMULT_IN;
                MesagBuf   : out Message_Buffer;
                em_o       : out EVMULT_OUT)
               return int16;
    function Double_Click(
                ToSet     : int16;
                SetGet    : boolean)
               return int16;


	
	--  old C-style names
    function evnt_keybd return int16 renames Keybd;
    function evnt_button(
                Clicks     : int16;
                WhichButton: int16;
                WhichState : int16;
                Mx         : out int16;
                My         : out int16;
                ButtonState: out int16;
                KeyState   : out int16)
               return int16 renames Button;
    procedure evnt_mouse(
                EnterExit  : int16;
                InX        : int16;
                InY        : int16;
                InW        : int16;
                InH        : int16;
                OutX       : out int16;
                OutY       : out int16;
                ButtonState: out int16;
                KeyState   : out int16) renames Mouse;
    function evnt_mesag(
                MesagBuf  : out short_array)
               return int16 renames Message;
    function evnt_mesag(
                MesagBuf  : out Message_Buffer)
               return int16 renames Message;
    procedure evnt_timer(
                Interval  : uint32) renames Timer;
    function evnt_timer(
                locount  : int16;
                hicount  : int16)
               return int16 renames Timer;
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
               return int16 renames Multi;
    function evnt_multi(
                em_i       : in EVMULT_IN;
                MesagBuf   : out Message_Buffer;
                em_o       : out EVMULT_OUT)
               return int16 renames Multi;
    function evnt_dclick(
                ToSet     : int16;
                SetGet    : boolean)
               return int16 renames Double_Click;


end Atari.Aes.Event;
