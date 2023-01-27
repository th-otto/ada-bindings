with Atari.Aes.Objects;
use Atari;

package Atari.Aes.Extensions is

    type XEDITINFO is private;
    type XEDITINFO_ptr is access all XEDITINFO;

    type SCANX is
        record
            scancode: aliased uint8;
            nclicks : aliased uint8;
            objnr   : aliased int16;
        end record;
    type SCANX_ptr is access all SCANX;

    type XDO_INF is
        record
            unsh : aliased SCANX_ptr;
            shift: aliased SCANX_ptr;
            ctrl : aliased SCANX_ptr;
            alt  : aliased SCANX_ptr;
            resvd: aliased System.Address;
        end record;
    type XDO_INF_ptr is access all XDO_INF;

    type AESVARS is
        record
            magic: int32;                           -- Must be $87654321
            membot: void_ptr;                       -- End of the AES-variables
            aes_start: void_ptr;                    -- Start address
            magic2: int32;                          -- Is 'MAGX'
            date: uint32;                           -- Creation date ddmmyyyy
            chgres: void_ptr;                       -- Change resolution
            shel_vector: void_ptr;                  -- Resident desktop
            aes_bootdrv: uint8_ptr;                 -- Booting took place from here
            vdi_device: short_ptr;                  -- VDI-driver used by AES
            nvdi_workstation: void_ptr_ptr;         -- workstation used by AES
            shelw_doex: short_ptr;                  -- last <doex> for APP #0
            shelw_isgr: short_ptr;                  -- last <isgr> for APP #0
            version: int16;                         -- e.g. $0201 is V2.1
            release: int16;                         -- 0=alpha..3=release
        end record;
    type AESVARS_ptr is access all AESVARS;

    type MAGX_COOKIE is
        record
            config_status: int32;
            dosvars: void_ptr;
            aesvars: AESVARS_ptr;
            res1: void_ptr;
            hddrv_functions: void_ptr;
            status_bits: uint32;
        end record;
    type MAGX_COOKIE_ptr is access all MAGX_COOKIE;

    procedure objc_wdraw(
                tree   : Objects.Object_Ptr;
                start  : int16;
                depth  : int16;
                clip   : in GRECT;
                whandle: int16);

    procedure objc_wchange(
                tree     : Objects.Object_Ptr;
                obj      : int16;
                new_state: int16;
                clip     : access GRECT;
                whandle  : int16);

    function graf_wwatchbox(
                tree      : Objects.Object_Ptr;
                Obj       : int16;
                InState   : int16;
                OutState  : int16;
                whandle   : int16)
               return int16;

    function form_wbutton(
                tree      : Objects.Object_Ptr;
                fo_bobject: int16;
                fo_bclicks: int16;
                fo_bnxtobj: out int16;
                whandle   : int16)
               return int16;

    function form_wkeybd(
                tree         : Objects.Object_Ptr;
                fo_kobject   : int16;
                fo_kobnext   : int16;
                fo_kchar     : int16;
                fo_knxtobject: out int16;
                fo_knxtchar  : out int16;
                whandle      : int16)
               return int16;

    function objc_wedit(
                tree   : Objects.Object_Ptr;
                obj    : int16;
                key    : int16;
                idx    : in out int16;
                kind   : int16;
                whandle: int16)
               return int16;

    function objc_xedit(
                tree  : Objects.Object_Ptr;
                obj   : int16;
                key   : int16;
                xpos  : in out int16;
                subfn : int16;
                r     : in GRECT)
               return int16;

    function form_popup(
                tree  : Objects.Object_Ptr;
                x     : int16;
                y     : int16)
               return int16;

    type POPUP_INIT_args is
        record
            tree     : aliased Objects.Object_Ptr;
            scrollpos: aliased int16;
            nlines   : aliased int16;
            param    : aliased System.Address;
        end record;

    type init_proc_ptr is access procedure(p1: POPUP_INIT_args);
    pragma Convention(C, init_proc_ptr);

    function xfrm_popup(
                tree       : Objects.Object_Ptr;
                x          : int16;
                y          : int16;
                firstscrlob: int16;
                lastscrlob : int16;
                nlines     : int16;
                init       : init_proc_ptr;
                param      : System.Address;
                lastscrlpos: in out int16)
               return int16;

    function form_xdo(
                tree    : Objects.Object_Ptr;
                startob : int16;
                lastcrsr: out int16;
                tabs    : XDO_INF_ptr;
                flydial : void_ptr_ptr)
               return int16;

    function form_xdial(
                fo_diflag  : int16;
                fo_dilittlx: int16;
                fo_dilittly: int16;
                fo_dilittlw: int16;
                fo_dilittlh: int16;
                fo_dibigx  : int16;
                fo_dibigy  : int16;
                fo_dibigw  : int16;
                fo_dibigh  : int16;
                flydial    : void_ptr_ptr)
               return int16;

    function form_xdial(
                fo_diflag : int16;
                fo_dilittl: in GRECT;
                fo_dibig  : in GRECT;
                flydial   : void_ptr_ptr)
               return int16;

    function appl_options(
                mode: int16;
                aopts0: int16;
                aopts1: int16;
                aopts2: int16;
                aopts3: int16;
                out0: out int16;
                out1: out int16;
                out2: out int16;
                out3: out int16)
               return int16;



private
    type XEDITINFO is record null; end record;

end Atari.Aes.Extensions;
