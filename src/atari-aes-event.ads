package Atari.Aes.Event is

    function Keybd return int16 renames evnt_keybd;
    function Button(
                Clicks     : int16;
                WhichButton: int16;
                WhichState : int16;
                Mx         : out int16;
                My         : out int16;
                ButtonState: out int16;
                KeyState   : out int16)
               return int16 renames evnt_button;
    procedure Mouse(
                EnterExit  : int16;
                InX        : int16;
                InY        : int16;
                InW        : int16;
                InH        : int16;
                OutX       : out int16;
                OutY       : out int16;
                ButtonState: out int16;
                KeyState   : out int16) renames evnt_mouse;
    function Mesag(
                MesagBuf  : out short_array)
               return int16 renames evnt_mesag;
    function Mesag(
                MesagBuf  : out Message_Buffer)
               return int16 renames evnt_mesag;
    procedure Timer(
                Interval  : uint32) renames evnt_timer;
    function Timer(
                locount  : int16;
                hicount  : int16)
               return int16 renames evnt_timer;
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
               return int16 renames evnt_multi;
    function Multi(
                em_i       : in EVMULT_IN;
                MesagBuf   : out Message_Buffer;
                em_o       : out EVMULT_OUT)
               return int16 renames evnt_multi;
    function Dclick(
                ToSet     : int16;
                SetGet    : int16)
               return int16 renames evnt_dclick;

end Atari.Aes.Event;
