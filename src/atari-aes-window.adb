pragma No_Strict_Aliasing;

package body Atari.Aes.Window is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

function Draw(
            WindowHandle: int16;
            startob     : int16)
           return int16 is
begin
    aes_control.opcode := 99;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := startob;
    aes_trap;
    return aes_intout(0);
end;


function Create(
            Parts     : int16;
            Wx        : int16;
            Wy        : int16;
            Ww        : int16;
            Wh        : int16)
           return int16 is
begin
    aes_control.opcode := 100;
    aes_control.num_intin := 5;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := Parts;
    aes_intin(1) := Wx;
    aes_intin(2) := Wy;
    aes_intin(3) := Ww;
    aes_intin(4) := Wh;
    aes_trap;
    return aes_intout(0);
end;


function Create(
            Parts     : int16;
            r         : in Rectangle)
           return int16 is
begin
    return wind_create(Parts, r.g_x, r.g_y, r.g_w, r.g_h);
end;


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
           return int16 is
begin
    aes_control.opcode := 100;
    aes_control.num_intin := 5;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := Parts;
    aes_intin(1) := Wx;
    aes_intin(2) := Wy;
    aes_intin(3) := Ww;
    aes_intin(4) := Wh;
    aes_trap;
    OutX := aes_intout(1);
    OutY := aes_intout(2);
    OutW := aes_intout(3);
    OutH := aes_intout(4);
    return aes_intout(0);
end;


-- wind_xcreate
function Create(
            Parts     : int16;
            r         : in Rectangle;
            ret       : out Rectangle)
           return int16 is
begin
    return Create(Parts, r.g_x, r.g_y, r.g_w, r.g_h, ret.g_x, ret.g_y, ret.g_w, ret.g_h);
end;


function Open(
            WindowHandle: int16;
            Wx          : int16;
            Wy          : int16;
            Ww          : int16;
            Wh          : int16)
           return int16 is
begin
    aes_control.opcode := 101;
    aes_control.num_intin := 5;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := Wx;
    aes_intin(2) := Wy;
    aes_intin(3) := Ww;
    aes_intin(4) := Wh;
    aes_trap;
    return aes_intout(0);
end;


function Open(
            WindowHandle: int16;
            r           : in Rectangle)
           return int16 is
begin
    return wind_open(WindowHandle, r.g_x, r.g_y, r.g_w, r.g_h);
end;


function Close(
            WindowHandle: int16)
           return int16 is
begin
    aes_control.opcode := 102;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_trap;
    return aes_intout(0);
end;


function Delete(
            WindowHandle: int16)
           return int16 is
begin
    aes_control.opcode := 103;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_trap;
    return aes_intout(0);
end;



--        WF_KIND              => 1,                      -- get      int16
--        WF_NAME              => 2,                      -- get/set  string
--        WF_INFO              => 3,                      -- get/set  string
--        WF_WORKXYWH          => 4,                      -- get      Rectangle
--        WF_CURRXYWH          => 5,                      -- get/set  Rectangle
--        WF_PREVXYWH          => 6,                      -- get      Rectangle
--        WF_FULLXYWH          => 7,                      -- get      Rectangle
--        WF_HSLIDE            => 8,                      -- get/set  int16
--        WF_VSLIDE            => 9,                      -- get/set  int16
--        WF_TOP               => 10,                     -- get/set  int16
--        WF_FIRSTXYWH         => 11,                     -- get      Rectangle
--        WF_NEXTXYWH          => 12,                     -- get      Rectangle
--        WF_FIRSTAREAXYWH     => 13,                     -- get      Rectangle
--        WF_NEWDESK           => 14,                     -- get/set  OBJECT_ptr, int16
--        WF_HSLSIZE           => 15,                     -- get/set  int16
--        WF_VSLSIZE           => 16,                     -- get/set  int16
--        WF_SCREEN            => 17,                     -- get      void_ptr
--        WF_COLOR             => 18,                     -- get/set  int16
--        WF_DCOLOR            => 19,                     -- get/set  int16
--        WF_OWNER             => 20,                     -- get      int16/int16/int16/int16
--        WF_BEVENT            => 24,                     -- get/set  int16
--        WF_BOTTOM            => 25,                     -- get/set  int16/int16/int16/int16
--        WF_ICONIFY           => 26,                     -- get/set  int16/int16/int16
--        WF_UNICONIFY         => 27,                     -- get/set  Rectangle
--        WF_UNICONIFYXYWH     => 28,                     --     set  Rectangle
--        WF_TOOLBAR           => 30,                     -- get/set  void_ptr, int16
--        WF_FTOOLBAR          => 31,                     -- get      Rectangle
--        WF_NTOOLBAR          => 32,                     -- get      Rectangle
--        WF_MENU              => 33,                     -- get/set  void_ptr
--        WF_WHEEL             => 40,                     -- get/set  int16/int16
--        WF_OPTS              => 41,                     -- get/set  get: void_ptr; set: int16/void_ptr
--        WF_CALCF2W           => 42,                     -- get      Rectangle
--        WF_CALCW2F           => 43,                     -- get      Rectangle
--        WF_CALCF2U           => 44,                     -- get      Rectangle
--        WF_CALCU2F           => 45,                     -- get      Rectangle
--        WF_MAXWORKXYWH       => 46,                     -- get      Rectangle
--        WF_M_BACKDROP        => 100,                    -- get/set  int16/int16
--        WF_M_OWNER           => 101,                    -- get      int16/int16/int16/int16
--        WF_M_WINDLIST        => 102,                    -- get      void_ptr
--        WF_MINXYWH           => 103,                    -- get/set  Rectangle
--        WF_INFOXYWH          => 104,                    -- get      Rectangle
--        WF_WIDGETS           => 200,                    -- get/set  int16/int16/int16/int16
--        WF_USER_POINTER      => 230,                    -- get/set  void_ptr
--        WF_TOPMOST           => 232,                    --     set  int16
--        WF_BITMAP            => 233,                    -- get      void_ptr
--        WF_OPTIONS           => 234,                    --     set  int16
--        WF_FULLSCREEN        => 235,                    --     set  int16
--        WF_WINX              => 22360,                  -- get      int16
--        WF_WINXCFG           => 22361,                  -- get/set  int16
--        WF_DDELAY            => 22362,                  -- get/set  int16
--        WF_SHADE             => 22365,                  -- get/set  int16
--        WF_STACK             => 22366,                  --     set  int16
--        WF_TOPALL            => 22367,                  --     set  int16
--        WF_BOTTOMALL         => 22368,                  --     set  int16
--        WF_XAAES             => 16#5841#                -- get      int16



function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : out int16;
            W2          : out int16;
            W3          : out int16;
            W4          : out int16)
           return int16 is
    ptr: void_ptr;
begin
    aes_control.opcode := 104;
    aes_control.num_intin := 2;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    case What is
       when WF_DCOLOR | WF_COLOR =>
          aes_control.num_intin := 3;
          --
          -- strange binding for WF_DCOLOR & WF_COLOR use
          -- output parameters also as input;
          -- suppress warnings about it
          --
Pragma Warnings(off);
          aes_intin(2) := W1;
Pragma Warnings(on);
       when WF_INFO | WF_NAME =>
          aes_control.num_intin := 4;
          ptr := aes_intin(2)'Address;
          void_ptr'Deref(ptr) := W1'Address;
          raise Standard'Abort_Signal with "use Window.Get(String) instead";
       when others =>
           null;
    end case;
    aes_intout(3) := 0;
    aes_intout(4) := 0;

    aes_trap;

    case What is
       when WF_INFO | WF_NAME =>
           --  special case where W1 shall not be overwritten
           null;
       when others =>
           W1 := aes_intout(1);
           W2 := aes_intout(2);
           W3 := aes_intout(3);
           W4 := aes_intout(4);
    end case;
    return aes_intout(0);
end;




function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : chars_ptr)
           return int16 is
    ptr: void_ptr;
begin
    aes_control.opcode := 104;
    aes_control.num_intin := 4;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    case What is
       when WF_INFO | WF_NAME =>
          aes_control.num_intin := 4;
          ptr := aes_intin(2)'Address;
          void_ptr'Deref(ptr) := W1.all'Address;
       when others =>
          raise Standard'Abort_Signal with "illegal mode for Window.Get(String)";
    end case;
    aes_intout(3) := 0;
    aes_intout(4) := 0;

    aes_trap;

    case What is
       when WF_INFO | WF_NAME =>
           --  special case where W1 shall not be overwritten
           null;
       when others =>
           null;
    end case;
    return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            r           : out Rectangle)
           return int16 is
begin
    aes_control.opcode := 104;
    aes_control.num_intin := 2;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;

    aes_trap;

    r.g_x := aes_intout(1);
    r.g_y := aes_intout(2);
    r.g_w := aes_intout(3);
    r.g_h := aes_intout(4);
    return aes_intout(0);
end;


-- wind_xget
function Get(
            WindowHandle: int16;
            What        : Action_Type;
            clip        : in Rectangle;
            r           : out Rectangle)
           return int16 is
begin
    aes_control.opcode := 104;
    aes_control.num_intin := 6;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    aes_intin(2) := clip.g_x;
    aes_intin(3) := clip.g_y;
    aes_intin(4) := clip.g_w;
    aes_intin(5) := clip.g_h;

    aes_trap;

    r.g_x := aes_intout(1);
    r.g_y := aes_intout(2);
    r.g_w := aes_intout(3);
    r.g_h := aes_intout(4);
    return aes_intout(0);
end;


function Get(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : out int16)
           return int16 is
    dummy: int16;
    dummy2: int16;
    dummy3: int16;
begin
    return wind_get(WindowHandle, what, W1, dummy, dummy2, dummy3);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : int16;
            W2          : int16;
            W3          : int16;
            W4          : int16)
           return int16 is
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    aes_intin(2) := W1;
    aes_intin(3) := W2;
    aes_intin(4) := W3;
    aes_intin(5) := W4;

    aes_trap;

    return aes_intout(0);
end;



function Set(
            WindowHandle: int16;
            What        : Action_Type;
            r           : in Rectangle)
           return int16 is
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    aes_intin(2) := r.g_x;
    aes_intin(3) := r.g_y;
    aes_intin(4) := r.g_w;
    aes_intin(5) := r.g_h;

    aes_trap;

    return aes_intout(0);
end;


-- wind_xset
function Set(
            WindowHandle: int16;
            What        : Action_Type;
            s           : in Rectangle;
            r           : out Rectangle)
           return int16 is
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    aes_intin(2) := s.g_x;
    aes_intin(3) := s.g_y;
    aes_intin(4) := s.g_w;
    aes_intin(5) := s.g_h;

    aes_trap;

    r.g_x := aes_intout(1);
    r.g_y := aes_intout(2);
    r.g_w := aes_intout(3);
    r.g_h := aes_intout(4);
    return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            str         : const_chars_ptr)
           return int16 is
    ptr: void_ptr;
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    const_chars_ptr'Deref(ptr) := str;
    aes_intin(4) := 0;
    aes_intin(5) := 0;

    aes_trap;

    return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            W1          : int16 := 0)
           return int16 is
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    aes_intin(2) := W1;
    aes_intin(3) := 0;
    aes_intin(4) := 0;
    aes_intin(5) := 0;

    aes_trap;

    return aes_intout(0);
end;


function Set(
            WindowHandle: int16;
            What        : Action_Type;
            v           : void_ptr;
            W3          : int16 := 0)
           return int16 is
    ptr: void_ptr;
begin
    aes_control.opcode := 105;
    aes_control.num_intin := 6;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := WindowHandle;
    aes_intin(1) := What'Enum_Rep;
    ptr := aes_intin(2)'Address;
    void_ptr'Deref(ptr) := v;
    aes_intin(4) := W3;
    aes_intin(5) := 0;

    aes_trap;

    return aes_intout(0);
end;


function Find(
            X         : int16;
            Y         : int16)
           return int16 is
begin
    aes_control.opcode := 106;
    aes_control.num_intin := 2;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := X;
    aes_intin(1) := Y;

    aes_trap;

    return aes_intout(0);
end;


function Update(
            Code      : int16)
           return int16 is
begin
    aes_control.opcode := 107;
    aes_control.num_intin := 1;
    aes_control.num_intout := 1;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := Code;

    aes_trap;

    return aes_intout(0);
end;


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
            OutH      : out int16)
           is
begin
    aes_control.opcode := 108;
    aes_control.num_intin := 6;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := c_Type;
    aes_intin(1) := Parts;
    aes_intin(2) := InX;
    aes_intin(3) := InY;
    aes_intin(4) := InW;
    aes_intin(5) := InH;

    aes_trap;

    OutX := aes_intout(1);
    OutY := aes_intout(2);
    OutW := aes_intout(3);
    OutH := aes_intout(4);
end;


procedure Calc(
            c_Type    : int16;
            Parts     : int16;
            c_In      : in Rectangle;
            c_Out     : out Rectangle)
           is
begin
    aes_control.opcode := 108;
    aes_control.num_intin := 6;
    aes_control.num_intout := 5;
    aes_control.num_addrin := 0;
    aes_control.num_addrout := 0;
    aes_intin(0) := c_Type;
    aes_intin(1) := Parts;
    aes_intin(2) := c_In.g_x;
    aes_intin(3) := c_In.g_y;
    aes_intin(4) := c_In.g_w;
    aes_intin(5) := c_In.g_h;

    aes_trap;

    c_Out.g_x := aes_intout(1);
    c_Out.g_y := aes_intout(2);
    c_Out.g_w := aes_intout(3);
    c_Out.g_h := aes_intout(4);
end;


--  procedure New is
--  begin
--      aes_control.opcode := 109;
--      aes_control.num_intin := 0;
--      aes_control.num_intout := 0;
--      aes_control.num_addrin := 0;
--      aes_control.num_addrout := 0;
--
--      aes_trap;
--  end;



end Atari.Aes.Window;
