with Ada.Unchecked_Conversion;
with Atari.Bios;
with Atari.Gemdos;
with Atari.Aes.Application;
with Atari.Aes.Extensions; use Atari.Aes.Extensions;
with Atari.Aes.Resource;
with Interfaces; use Interfaces;
with System;
with System.Storage_Elements; use System.Storage_Elements;
with Atari.Vdi; use Atari.Vdi;
use Atari.Aes;
with Atari.Aes.Objects; use Atari.Aes.Objects;

package body adaptrsc is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);

radio_bgcol: int16;
magic_version: int16;

type long_ptr is access all int32;

-- function to_address is new Ada.Unchecked_Conversion(Integer, System.Address);

-- jarptr: long_ptr;
-- for jarptr'Address use to_address(16#5a0#);

-- function get_jarptr return int32 is
--  function to_long is new Ada.Unchecked_Conversion(long_ptr, int32);
-- begin
--  return to_long(jarptr);
-- end;

function strlen(str: const_chars_ptr) return int16
    with Import => True,
         Convention => C,
         External_Name => "strlen";

-- **********************************************************************
-- ----------------------------------------------------------------------
-- **********************************************************************

RADIOBUTTONS_DIALOG: constant int16 :=                 0; -- unknown form
RADIO_LARGE_SELECTED: constant int16 :=                1; -- IMAGE in tree RADIOBUTTONS_DIALOG
RADIO_LARGE_DESELECTED: constant int16 :=              2; -- IMAGE in tree RADIOBUTTONS_DIALOG
RADIO_SMALL_DESELECTED: constant int16 :=              3; -- IMAGE in tree RADIOBUTTONS_DIALOG
RADIO_SMALL_SELECTED: constant int16 :=                4; -- IMAGE in tree RADIOBUTTONS_DIALOG

Num_Bitblks: constant int16 := 4;
Num_Objects: constant int16 := 5;
Num_Trees: constant int16 := 1;

-- data of RADIO_LARGE_SELECTED
adaptrsc_IMAGE0: array(0..31) of uint8 := (
    16#00#, 16#00#, 16#03#, 16#C0#, 16#0C#, 16#30#, 16#10#, 16#08#, 16#23#, 16#C4#, 16#27#, 16#E4#, 16#4F#, 16#F2#, 16#4F#, 16#F2#,
    16#4F#, 16#F2#, 16#4F#, 16#F2#, 16#27#, 16#E4#, 16#23#, 16#C4#, 16#10#, 16#08#, 16#0C#, 16#30#, 16#03#, 16#C0#, 16#00#, 16#00#
);

-- data of RADIO_LARGE_DESELECTED
adaptrsc_IMAGE1: array(0..31) of uint8 := (
    16#00#, 16#00#, 16#03#, 16#C0#, 16#0C#, 16#30#, 16#10#, 16#08#, 16#20#, 16#04#, 16#20#, 16#04#, 16#40#, 16#02#, 16#40#, 16#02#,
    16#40#, 16#02#, 16#40#, 16#02#, 16#20#, 16#04#, 16#20#, 16#04#, 16#10#, 16#08#, 16#0C#, 16#30#, 16#03#, 16#C0#, 16#00#, 16#00#
);

-- data of RADIO_SMALL_DESELECTED
adaptrsc_IMAGE2: array(0..15) of uint8 := (
    16#00#, 16#00#, 16#07#, 16#E0#, 16#18#, 16#18#, 16#20#, 16#04#, 16#20#, 16#04#, 16#20#, 16#04#, 16#18#, 16#18#, 16#07#, 16#E0#
);

-- data of RADIO_SMALL_SELECTED
adaptrsc_IMAGE3: array(0..15) of uint8 := (
    16#00#, 16#00#, 16#07#, 16#E0#, 16#18#, 16#18#, 16#23#, 16#C4#, 16#27#, 16#E4#, 16#23#, 16#C4#, 16#18#, 16#18#, 16#07#, 16#E0#
);

rs_bitblk: array(0..Num_Bitblks-1) of aliased Bitblk := (
    ( adaptrsc_IMAGE0'Address, 2, 16, 0, 0, 1 ),
    ( adaptrsc_IMAGE1'Address, 2, 16, 0, 0, 1 ),
    ( adaptrsc_IMAGE2'Address, 2, 8, 0, 0, 1 ),
    ( adaptrsc_IMAGE3'Address, 2, 8, 0, 0, 1 )
);

rs_object: constant array(0..Num_Objects-1) of aliased Object := (
    -- RADIOBUTTONS_DIALOG
    ( -1, 1, 4, G_BOX, OF_NONE, OS_OUTLINED, (which => 0, index => 16#21100#), 0,0, 52,9 ),
    ( 2, -1, -1, G_IMAGE, OF_NONE, OS_NORMAL, (which => G_IMAGE, bitblk => rs_bitblk(0)'Access), 5,1, 4096,4096 ), -- RADIO_LARGE_SELECTED
    ( 3, -1, -1, G_IMAGE, OF_NONE, OS_NORMAL, (which => G_IMAGE, bitblk => rs_bitblk(1)'Access), 2,1, 4096,4096 ), -- RADIO_LARGE_DESELECTED
    ( 4, -1, -1, G_IMAGE, OF_NONE, OS_NORMAL, (which => G_IMAGE, bitblk => rs_bitblk(2)'Access), 2,3, 4096,2048 ), -- RADIO_SMALL_DESELECTED
    ( 0, -1, -1, G_IMAGE, OF_LASTOB, OS_NORMAL, (which => G_IMAGE, bitblk => rs_bitblk(3)'Access), 5,3, 4096,2048 ) -- RADIO_SMALL_SELECTED
);

function to_pointer is new Ada.Unchecked_Conversion(System.Address, Object_Ptr);

rs_trindex: constant array(0..Num_Trees-1) of Object_Ptr := (
    RADIOBUTTONS_DIALOG => to_pointer(rs_object(0)'Address)
);

procedure rsrc_load is
begin
    for Obj in 0 .. Num_Objects - 1 loop
        Resource.Obfix(to_pointer(rs_object(0)'Address), Obj);
    end loop;
end;

-- **********************************************************************
-- ----------------------------------------------------------------------
-- **********************************************************************

cookie_magic: constant int32 := 16#4D616758#;

function get_cookie(id: int32) return void_ptr is
    jarptr: long_ptr;
    proc: void_ptr;
    function to_proc is new Ada.Unchecked_Conversion(Integer, void_ptr);
    query: constant void_ptr := to_proc(-1);

    function to_long_ptr is new Ada.Unchecked_Conversion(void_ptr, long_ptr);

    function "+" (Left : long_ptr; Right: Integer) return long_ptr is
    pragma Inline ("+");
	    function to_address is new Ada.Unchecked_Conversion (long_ptr, void_ptr);
    begin
        return to_long_ptr(to_address(Left) + Storage_Offset(Right) * 4);
    end "+";

    function to_address is new Ada.Unchecked_Conversion (int32, System.Address);

begin
    proc := Bios.Setexc(16#5a0# / 4, query);
    jarptr := to_long_ptr(proc);
    if jarptr /= null then
        loop
            exit when jarptr.all = 0;
            if jarptr.all = id then
                jarptr := jarptr + 1;
                return to_address(jarptr.all);
            end if;
            jarptr := jarptr + 2;
        end loop;
    end if;
    return System.null_address;
end;

-- ----------------------------------------------------------------------

procedure get_aes_info is
    magic: MAGX_COOKIE_ptr;
    flags: uint16;
    pens: int16;
    function to_pointer is new Ada.Unchecked_Conversion(void_ptr, MAGX_COOKIE_ptr);
    work_out: vdi_workout_array;
    ag1, ag2, ag3, ag4: int16;
    dummy: int16;

begin
    flags := 0;
    vq_extnd(vdi_handle, 0, work_out);
    pens := work_out(13);
    hor_3d := 0;
    ver_3d := 0;
    radio_bgcol := G_WHITE;

    if (Application.Find("?AGI") = 0) then -- appl_getinfo() vorhanden?
        flags := flags or GAI_INFO;
    end if;

    if (Application.Version >= 16#0401#) then -- mindestens AES 4.01?
        flags := flags or GAI_INFO;
    end if;

    magic := to_pointer(get_cookie(cookie_magic));
    magic_version := 0;

    if (magic /= null) then         -- MagiC vorhanden?
        if magic.aesvars /= null then   -- MagiC-AES aktiv?
            magic_version := magic.aesvars.version; -- MagiC-Versionsnummer
            flags := flags or GAI_MAGIC or GAI_INFO;
        end if;
    end if;

    if (flags and GAI_INFO) /= 0 then       -- ist appl_getinfo() vorhanden?
        if Application.Get_Info(2, ag1, ag2, ag3, ag4) and then ag3 /= 0 then -- Unterfunktion 2, Farben
            flags := flags or GAI_CICN;
        end if;

        if Application.Get_Info(7, ag1, ag2, ag3, ag4) then -- Unterfunktion 7
            flags := flags or uint16(ag1 and (GAI_WDLG or GAI_LBOX or GAI_FNTS or GAI_FSEL or GAI_PDLG));
        end if;

        if Application.Get_Info(12, ag1, ag2, ag3, ag4) and then (ag1 and 8) /= 0 then -- AP_TERM?
            flags := flags or GAI_APTERM;
        end if;

        if Application.Get_Info(13, ag1, ag2, ag3, ag4) then -- Unterfunktion 13, Objekte
            if (flags and GAI_MAGIC) /= 0 then -- MagiC spezifische Funktion!
                if (ag4 and 8) /= 0 then -- G_SHORTCUT supported ?
                    flags := flags or GAI_GSHORTCUT;
                end if;
            end if;

            if ag1 /= 0 and then ag2 /= 0 then -- 3D-Objekte und objc_sysvar() vorhanden?
                if objc_sysvar(0, 6, 0, 0, hor_3d, ver_3d) /= 0 then -- 3D-Look eingeschaltet?
                    if (pens >= 16) then -- mindestens 16 Farben?
                        flags := flags or GAI_3D;
                        dummy := objc_sysvar(0, BACKGRCOL, 0, 0, radio_bgcol, dummy);
                    end if;
                end if;
            end if;
        end if;
    end if;

    aes_flags := flags;
end;

-- **********************************************************************
-- ----------------------------------------------------------------------
-- **********************************************************************

user_blks: USERBLK_ptr;
radio_selected: OBJECT_ptr;
radio_deselected: OBJECT_ptr;


procedure save_fillattr(handle: VdiHdl; attrib: out short_array) is
begin
    vqf_attributes(handle, attrib);
end;

-- ----------------------------------------------------------------------

procedure restore_fillattr(handle: VdiHdl; attrib: in short_array) is
    dummy: int16;
begin
    dummy := vsf_interior(handle, attrib(0));
    dummy := vsf_color(handle, attrib(1));
    dummy := vsf_style(handle, attrib(2));
    dummy := vswr_mode(handle, attrib(3));
    dummy := vsf_perimeter(handle, attrib(4));
end;

-- ----------------------------------------------------------------------

procedure save_lineattr(handle: VdiHdl; attrib: out short_array) is
begin
    vql_attributes(handle, attrib);
end;

-- ----------------------------------------------------------------------

procedure restore_lineattr(handle: VdiHdl; attrib: in short_array) is
    dummy: int16;
begin
    dummy := vsl_type(handle, attrib(0));
    dummy := vsl_color(handle, attrib(1));
    dummy := vswr_mode(handle, attrib(2));
    dummy := vsl_width(handle, attrib(3));
    vsl_ends(handle, attrib(4), attrib(5));
end;

-- ----------------------------------------------------------------------

procedure save_textattr(handle: VdiHdl; attrib: out short_array) is
    dummy, hout, vout: int16;
begin
    vqt_attributes(handle, attrib);
    dummy := vst_effects(handle, 0);
    vst_alignment(handle, TA_LEFT, TA_TOP, hout, vout);
    dummy := vst_rotation(handle, 0);
end;

-- ----------------------------------------------------------------------

procedure restore_textattr(handle: VdiHdl; attrib: in short_array) is
    dummy, hout, vout: int16;
    charw, charh, cellw, cellh: int16;
begin
    dummy := vst_color(handle, attrib(1));
    dummy := vst_rotation(handle, attrib(2));
    vst_alignment(handle, attrib(3), attrib(4), hout, vout);
    -- original vqt_attributes returns mode-1
    -- vswr_mode(handle, attrib(5) + 1);
    vst_height(handle, attrib(7), charw, charh, cellw, cellh);
end;

-- ----------------------------------------------------------------------

procedure save_clip(handle: VdiHdl; clip: out short_array) is
    wo: vdi_workout_array;
begin
    vq_extnd(handle, 1, wo);
    clip(0) := wo(45);
    clip(1) := wo(46);
    clip(2) := wo(47);
    clip(3) := wo(48);
    clip(4) := wo(19);
end;

-- ----------------------------------------------------------------------

procedure restore_clip(handle: VdiHdl; clip: in short_array) is
begin
    vs_clip(handle, clip(4), clip);
end;

-- ----------------------------------------------------------------------

procedure userdef_text(x, y: int16; str: const_chars_ptr) is
    charw, charh, cellw, cellh: int16;
    dummy: int16;
begin
    dummy := vswr_mode(vdi_handle, MD_TRANS);
    dummy := vst_color(vdi_handle, G_BLACK);
    vst_height(vdi_handle, (if gl_hchar < 15 then 4 else 13), charw, charh, cellw, cellh);

    v_gtext(vdi_handle, x, y, str);
end;

-- ----------------------------------------------------------------------

function draw_check(pb: PARMBLK_ptr) return int16 with Convention => C;
function draw_check(pb: PARMBLK_ptr) return int16 is
    rect: short_array(0..3);
    clip: short_array(0..3);
    xy: short_array(0..9);
    str: const_chars_ptr;
    fillattrib: short_array(0..4);
    lineattrib: short_array(0..5);
    savedclip: short_array(0..4);
    textattrib: short_array(0..9);
    function to_string is new Ada.Unchecked_Conversion(intptr, const_chars_ptr);
    dummy: int16;
begin
    save_fillattr(vdi_handle, fillattrib);
    save_lineattr(vdi_handle, lineattrib);
    save_textattr(vdi_handle, textattrib);
    save_clip(vdi_handle, savedclip);

    str := to_string(pb.pb_parm);

    clip(0) := pb.pb_xc;
    clip(1) := pb.pb_yc;
    clip(2) := pb.pb_xc + pb.pb_wc - 1;
    clip(3) := pb.pb_yc + pb.pb_hc - 1;
    vs_clip(vdi_handle, 1, clip);

    rect(0) := pb.pb_x;
    rect(1) := pb.pb_y;
    rect(2) := pb.pb_x + gl_hchar - 1;
    rect(3) := pb.pb_y + gl_hchar - 1;

    dummy := vswr_mode(vdi_handle, MD_REPLACE);

    dummy := vsl_color(vdi_handle, G_BLACK);

    xy(0) := rect(0);
    xy(1) := rect(1);
    xy(2) := rect(2);
    xy(3) := rect(1);
    xy(4) := rect(2);
    xy(5) := rect(3);
    xy(6) := rect(0);
    xy(7) := rect(3);
    xy(8) := rect(0);
    xy(9) := rect(1);
    v_pline(vdi_handle, 5, xy);

    dummy := vsf_color(vdi_handle, G_WHITE);

    xy(0) := rect(0) + 1;
    xy(1) := rect(1) + 1;
    xy(2) := rect(2) - 1;
    xy(3) := rect(3) - 1;
    vr_recfl(vdi_handle, xy);

    if (pb.pb_currstate and OS_SELECTED) /= 0
    then
        pb.pb_currstate := pb.pb_currstate and not OS_SELECTED;

        dummy := vsl_color(vdi_handle, G_BLACK);
        xy(0) := rect(0) + 2;
        xy(1) := rect(1) + 2;
        xy(2) := rect(2) - 2;
        xy(3) := rect(3) - 2;
        v_pline(vdi_handle, 2, xy);

        xy(1) := rect(3) - 2;
        xy(3) := rect(1) + 2;
        v_pline(vdi_handle, 2, xy);
    end if;

    userdef_text(pb.pb_x + gl_hchar + gl_wchar, pb.pb_y, str);

    restore_clip(vdi_handle, savedclip);
    restore_lineattr(vdi_handle, lineattrib);
    restore_fillattr(vdi_handle, fillattrib);
    restore_textattr(vdi_handle, textattrib);

    return pb.pb_currstate;
end;

-- ----------------------------------------------------------------------

function draw_radio(pb: PARMBLK_ptr) return int16 with Convention => C;
function draw_radio(pb: PARMBLK_ptr) return int16 is
    image: BITBLK_ptr;
    src: MFDB;
    des: MFDB;
    clip: short_array(0..3);
    xy: short_array(0..9);
    image_colors: short_array(0..1);
    str: const_chars_ptr;
    fillattrib: short_array(0..4);
    lineattrib: short_array(0..5);
    savedclip: short_array(0..4);
    textattrib: short_array(0..9);
    function to_string is new Ada.Unchecked_Conversion(intptr, const_chars_ptr);
    dummy: int16;
begin
    save_fillattr(vdi_handle, fillattrib);
    save_lineattr(vdi_handle, lineattrib);
    save_textattr(vdi_handle, textattrib);
    save_clip(vdi_handle, savedclip);

    str := to_string(pb.pb_parm);

    clip(0) := pb.pb_xc;
    clip(1) := pb.pb_yc;
    clip(2) := pb.pb_xc + pb.pb_wc - 1;
    clip(3) := pb.pb_yc + pb.pb_hc - 1;
    vs_clip(vdi_handle, 1, clip);

    if (pb.pb_currstate and OS_SELECTED) /= 0
    then
        pb.pb_currstate := pb.pb_currstate and not OS_SELECTED;

        image := radio_selected.ob_spec.bitblk;
    else
        image := radio_deselected.ob_spec.bitblk;
    end if;

    src.fd_addr := image.bi_pdata;
    src.fd_w := image.bi_wb * 8;
    src.fd_h := image.bi_hl;
    src.fd_wdwidth := image.bi_wb / 2;
    src.fd_stand := 0;
    src.fd_nplanes := 1;
    src.fd_r1 := 0;
    src.fd_r2 := 0;
    src.fd_r3 := 0;

    des.fd_addr := System.null_address;

    xy(0) := 0;
    xy(1) := 0;
    xy(2) := src.fd_w - 1;
    xy(3) := src.fd_h - 1;
    xy(4) := pb.pb_x;
    xy(5) := pb.pb_y;
    xy(6) := xy(4) + xy(2);
    xy(7) := xy(5) + xy(3);

    image_colors(0) := G_BLACK;
    image_colors(1) := radio_bgcol;

    vrt_cpyfm(vdi_handle, MD_REPLACE, xy, src, des, image_colors);
    userdef_text(pb.pb_x + gl_hchar + gl_wchar, pb.pb_y, str);

    restore_clip(vdi_handle, savedclip);
    restore_lineattr(vdi_handle, lineattrib);
    restore_fillattr(vdi_handle, fillattrib);
    restore_textattr(vdi_handle, textattrib);

    return pb.pb_currstate;
end;

-- ----------------------------------------------------------------------

function draw_innerframe(pb: PARMBLK_ptr) return int16 with Convention => C;
function draw_innerframe(pb: PARMBLK_ptr) return int16 is
    clip: short_array(0..3);
    obj: short_array(0..3);
    xy: short_array(0..11);
    str: const_chars_ptr;
    fillattrib: short_array(0..4);
    lineattrib: short_array(0..5);
    savedclip: short_array(0..4);
    textattrib: short_array(0..9);
    function to_string is new Ada.Unchecked_Conversion(intptr, const_chars_ptr);
    dummy: int16;
begin
    save_fillattr(vdi_handle, fillattrib);
    save_lineattr(vdi_handle, lineattrib);
    save_textattr(vdi_handle, textattrib);
    save_clip(vdi_handle, savedclip);

    str := to_string(pb.pb_parm);

    clip(0) := pb.pb_xc;
    clip(1) := pb.pb_yc;
    clip(2) := pb.pb_xc + pb.pb_wc - 1;
    clip(3) := pb.pb_yc + pb.pb_hc - 1;
    vs_clip(vdi_handle, 1, clip);

    dummy := vswr_mode(vdi_handle, MD_TRANS);
    dummy := vsl_color(vdi_handle, G_BLACK);
    dummy := vsl_type(vdi_handle, 1);

    obj(0) := pb.pb_x;
    obj(1) := pb.pb_y;
    obj(2) := pb.pb_x + gl_hchar - 1;
    obj(3) := pb.pb_y + gl_hchar - 1;

    xy(0) := obj(0) + gl_wchar;
    xy(1) := obj(1) + gl_hchar / 2;
    xy(2) := obj(0);
    xy(3) := xy(1);
    xy(4) := obj(0);
    xy(5) := obj(3);
    xy(6) := obj(2);
    xy(7) := obj(3);
    xy(8) := obj(2);
    xy(9) := xy(1);
    xy(10) := xy(0) + strlen(str) * gl_wchar;
    xy(11) := xy(1);

    v_pline(vdi_handle, 6, xy);

    userdef_text(obj(0) + gl_wchar, obj(1), str);

    restore_clip(vdi_handle, savedclip);
    restore_lineattr(vdi_handle, lineattrib);
    restore_fillattr(vdi_handle, fillattrib);
    restore_textattr(vdi_handle, textattrib);

    return pb.pb_currstate;
end;

-- ----------------------------------------------------------------------

function draw_underline(pb: PARMBLK_ptr) return int16 with Convention => C;
function draw_underline(pb: PARMBLK_ptr) return int16 is
    clip: short_array(0..3);
    xy: short_array(0..3);
    str: const_chars_ptr;
    fillattrib: short_array(0..4);
    lineattrib: short_array(0..5);
    savedclip: short_array(0..4);
    textattrib: short_array(0..9);
    function to_string is new Ada.Unchecked_Conversion(intptr, const_chars_ptr);
    dummy: int16;
begin
    save_fillattr(vdi_handle, fillattrib);
    save_lineattr(vdi_handle, lineattrib);
    save_textattr(vdi_handle, textattrib);
    save_clip(vdi_handle, savedclip);

    str := to_string(pb.pb_parm);

    clip(0) := pb.pb_xc;
    clip(1) := pb.pb_yc;
    clip(2) := pb.pb_xc + pb.pb_wc - 1;
    clip(3) := pb.pb_yc + pb.pb_hc - 1;
    vs_clip(vdi_handle, 1, clip);

    dummy := vswr_mode(vdi_handle, MD_TRANS);
    dummy := vsl_color(vdi_handle, G_BLACK);
    dummy := vsl_type(vdi_handle, 1);

    xy(0) := pb.pb_x;
    xy(1) := pb.pb_y + pb.pb_h - 1;
    xy(2) := pb.pb_x + pb.pb_w - 1;
    xy(3) := xy(1);
    v_pline(vdi_handle, 2, xy);

    userdef_text(pb.pb_x, pb.pb_y, str);

    restore_clip(vdi_handle, savedclip);
    restore_lineattr(vdi_handle, lineattrib);
    restore_fillattr(vdi_handle, fillattrib);
    restore_textattr(vdi_handle, textattrib);

    return pb.pb_currstate;
end;

-- ----------------------------------------------------------------------

procedure substitute_objects(objects: AEStree_ptr; nobs: int16; flags: uint16) is
    obj: AEStree_ptr;
    i: int16;
    count: int16;
    function to_pointer is new Ada.Unchecked_Conversion(void_ptr, USERBLK_ptr);
    blk: USERBLK_ptr;
    o_type: uint16;
    state: uint16;


    function "+" (Left : USERBLK_ptr; Right: Integer) return USERBLK_ptr is
    pragma Inline ("+");
        function to_ptr is new Ada.Unchecked_Conversion (void_ptr, USERBLK_ptr);
        function to_address is new Ada.Unchecked_Conversion (USERBLK_ptr, void_ptr);
    begin
        return to_ptr(to_address(Left) + Storage_Offset(Right) * (USERBLK'Object_Size / 8));
    end "+";

begin
    if (flags and GAI_MAGIC) /= 0 and then magic_version >= 16#300# then
        user_blks := NULL;
        return;
    end if;
    obj := objects;
    i := nobs;
    count := 0;
    loop
        exit when i = 0;
        i := i - 1;
        if ((obj(i).ob_state and OS_WHITEBAK) /= 0 and then
            (obj(i).ob_state and 16#8000#) /= 0)
        then
            case obj(i).ob_type and 16#ff# is
            when G_BUTTON =>
                count := count + 1;
            when G_STRING =>
                if ((obj(i).ob_state and 16#ff00#) = 16#ff00#) then
                    count := count + 1;
                end if;
            when others =>
                null;
            end case;
        end if;
    end loop;

    if (count /= 0)
    then
        user_blks := to_pointer(Gemdos.Malloc(int32(count) * (USERBLK'Object_Size / 8)));
        if (user_blks /= NULL)
        then
            rsrc_load;
            if (gl_hchar < 15)
            then
                radio_selected := AEStree_ptr'Deref(rs_trindex(RADIOBUTTONS_DIALOG)'Address)(RADIO_SMALL_SELECTED)'Access;
                radio_deselected := AEStree_ptr'Deref(rs_trindex(RADIOBUTTONS_DIALOG)'Address)(RADIO_SMALL_DESELECTED)'Access;
            else
                radio_selected := AEStree_ptr'Deref(rs_trindex(RADIOBUTTONS_DIALOG)'Address)(RADIO_LARGE_SELECTED)'Access;
                radio_deselected := AEStree_ptr'Deref(rs_trindex(RADIOBUTTONS_DIALOG)'Address)(RADIO_LARGE_DESELECTED)'Access;
            end if;
            blk := user_blks;
            obj := objects;
            i := nobs;
            loop
                exit when i = 0;
                i := i - 1;
                o_type := obj(i).ob_type and 255;
                state := obj(i).ob_state;
                if (state and OS_WHITEBAK) /= 0
                then
                    if (state and 16#8000#) /= 0
                    then
                        state := state and 16#ff00#;
                        if (flags and GAI_MAGIC) /= 0
                        then
                            if (o_type = G_BUTTON and then state = 16#fe00#)
                            then
                                blk.ub_parm := obj(i).ob_spec.index;
                                blk.ub_code := draw_innerframe'Access;
                                obj(i).ob_type := G_USERDEF;
                                obj(i).ob_flags := obj(i).ob_flags and not OF_FL3DMASK;
                                obj(i).ob_spec.userblk := blk;
                                blk := blk + 1;
                            end if;
                        else
                            case o_type is
                            when G_BUTTON =>
                                blk.ub_parm := obj(i).ob_spec.index;
                                if (state = 16#fe00#) then
                                    blk.ub_code := draw_innerframe'Access;
                                else
                                    if (obj(i).ob_flags and OF_RBUTTON) /= 0 then
                                        blk.ub_code := draw_radio'Access;
                                    else
                                        blk.ub_code := draw_check'Access;
                                    end if;
                                end if;
                                obj(i).ob_type := G_USERDEF;
                                obj(i).ob_flags := obj(i).ob_flags and not OF_FL3DMASK;
                                obj(i).ob_spec.userblk := blk;
                                blk := blk + 1;
                            when G_STRING =>
                                if (state = 16#ff00#)
                                then
                                    blk.ub_parm := obj(i).ob_spec.index;
                                    blk.ub_code := draw_underline'Access;
                                    obj(i).ob_type := G_USERDEF;
                                    obj(i).ob_flags := obj(i).ob_flags and not OF_FL3DMASK;
                                    obj(i).ob_spec.userblk := blk;
                                    blk := blk + 1;
                                end if;
                            when others =>
                                null;
                            end case;
                        end if;
                    end if;
                end if;

                -- obj := obj + 1;
            end loop;
        end if;
    end if;
end;

-- ----------------------------------------------------------------------

procedure substitute_free is
    dummy: int16;
begin
    if user_blks /= null then
        dummy := Gemdos.Mfree(user_blks.all'Address);
    end if;
    user_blks := NULL;
end;


end adaptrsc;
