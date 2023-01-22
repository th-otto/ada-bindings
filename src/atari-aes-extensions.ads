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


	procedure objc_wdraw(
	            tree   : OBJECT_ptr;
	            start  : int16;
	            depth  : int16;
	            clip   : in GRECT;
	            whandle: int16);

    procedure objc_wchange(
                tree     : OBJECT_ptr;
                obj      : int16;
                new_state: int16;
                clip     : access GRECT;
                whandle  : int16);

    function graf_wwatchbox(
                tree      : OBJECT_ptr;
                Obj       : int16;
                InState   : int16;
                OutState  : int16;
                whandle   : int16)
               return int16;

    function form_wbutton(
                tree      : OBJECT_ptr;
                fo_bobject: int16;
                fo_bclicks: int16;
                fo_bnxtobj: out int16;
                whandle   : int16)
               return int16;

    function form_wkeybd(
                tree         : OBJECT_ptr;
                fo_kobject   : int16;
                fo_kobnext   : int16;
                fo_kchar     : int16;
                fo_knxtobject: out int16;
                fo_knxtchar  : out int16;
                whandle      : int16)
               return int16;

	function objc_wedit(
	            tree   : OBJECT_ptr;
	            obj    : int16;
	            key    : int16;
	            idx    : in out int16;
	            kind   : int16;
	            whandle: int16)
	           return int16;

    function objc_xedit(
                tree  : OBJECT_ptr;
                obj   : int16;
                key   : int16;
                xpos  : in out int16;
                subfn : int16;
                r     : in GRECT)
               return int16;

    function form_popup(
                tree  : OBJECT_ptr;
                x     : int16;
                y     : int16)
               return int16;

    type POPUP_INIT_args is
        record
            tree     : aliased OBJECT_ptr;
            scrollpos: aliased int16;
            nlines   : aliased int16;
            param    : aliased System.Address;
        end record;

    type init_proc_ptr is access procedure(p1: POPUP_INIT_args);
    pragma Convention(C, init_proc_ptr);

    function xfrm_popup(
                tree       : OBJECT_ptr;
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
                tree    : OBJECT_ptr;
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
