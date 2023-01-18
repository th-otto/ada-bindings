pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;
with Ada.Unchecked_Conversion;
with Interfaces; use Interfaces;

package body Atari.Vdi is

vdi_control: aliased VDIContrl;
vdi_intin: aliased VDIIntIn;
vdi_ptsin: aliased VDIPtsIn;
vdi_intout: aliased VDIIntOut;
vdi_ptsout: aliased VDIPtsOut;


vdi_pb: aliased VDIPB := (
    control => vdi_control'Access,
    intin => vdi_intin'Access,
    ptsin => vdi_ptsin'Access,
    intout => vdi_intout'Access,
    ptsout => vdi_ptsout'Access
);


procedure vdi(pb: VDIPB_ptr) is
    use ASCII;
    function to_address is new Ada.Unchecked_Conversion(VDIPB_ptr, System.Address);
begin
    asm("move.l %0,%%d1" & LF & HT &
        "move.w #115,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        inputs => System.Address'Asm_Input("g", to_address(pb)),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


procedure vdi_trap is
begin
    vdi(vdi_pb'Access);
end;


function string_to_vdi(src: in String; offset: int16) return int16 is
	len: int16;
	dst: Integer;
begin
	len := src'Length;
	dst := Integer(offset);
	for i in src'First .. src'Last loop
		vdi_intin(dst) := Character'Pos(src(i));
		dst := dst + 1;
  	end loop;
	return len;
end;


function string_to_vdi(src: in String; offset: int16; maxlen: int16) return int16 is
	len: Integer;
	dst: Integer;
begin
	len := Integer(maxlen);
	dst := Integer(offset);
	for i in src'First .. src'First + len - 1 loop
		vdi_intin(dst) := Character'Pos(src(i));
		dst := dst + 1;
  	end loop;
	return int16(len);
end;


function string_to_vdi(src: in Wide_String; offset: int16) return int16 is
	len: int16;
	dst: Integer;
begin
	len := src'Length;
	dst := Integer(offset);
	for i in src'First .. src'Last loop
		vdi_intin(dst) := Wide_Character'Pos(src(i));
		dst := dst + 1;
  	end loop;
	return len;
end;


function string_to_vdi(src: in Wide_String; offset: int16; maxlen: int16) return int16 is
	len: Integer;
	dst: Integer;
begin
	len := Integer(maxlen);
	dst := Integer(offset);
	for i in src'First .. src'First + len - 1 loop
		vdi_intin(dst) := Wide_Character'Pos(src(i));
		dst := dst + 1;
  	end loop;
	return int16(len);
end;


procedure vdi_to_string(dst: out String; maxlen: int16; offset: int16 := 0) is
	src: Integer;
	len: Integer;
begin
	src := Integer(offset);
	len := Integer(maxlen);
	for i in 0 .. len - 1 loop
		dst(i) := Character'Val(vdi_intout(src));
		src := src + 1;
  	end loop;
end;



procedure v_opnwk(
            work_in : short_array;
            handle  : in out VdiHdl;
            work_out: out vdi_workout_array) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(System.Address, VDIIntIn_ptr);
    function to_intout is new Ada.Unchecked_Conversion(System.Address, VDIIntOut_ptr);
    function to_ptsout is new Ada.Unchecked_Conversion(System.Address, VDIPtsOut_ptr);
begin
	vdi_control.opcode := 1;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := work_in'Length;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	pb.control := vdi_control'Access;
	pb.intin := to_intin(work_in'Address);
	pb.ptsin := vdi_ptsin'Access;
	pb.intout := to_intout(work_out(0)'Address);
	pb.ptsout := to_ptsout(work_out(45)'Address);
	
	vdi(pb'Unchecked_Access);
	
	handle := vdi_control.handle;
end;


procedure v_clswk(handle: VdiHdl) is
begin
	vdi_control.opcode := 2;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure v_clrwk(handle: VdiHdl) is
begin
	vdi_control.opcode := 3;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure v_updwk(handle: VdiHdl) is
begin
	vdi_control.opcode := 4;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure v_escape(handle: VdiHdl; subcode: int16; num_intin: int16 := 0; num_ptsin: int16 := 0) is
begin
	vdi_control.opcode := 5;
	vdi_control.num_ptsin := num_ptsin;
	vdi_control.num_intin := num_intin;
	vdi_control.subcode := subcode;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure vq_chcells(
            handle: VdiHdl;
            n_rows: out int16;
            n_cols: out int16) is
begin
	v_escape(handle, 1);
	n_rows := vdi_intout(0);
	n_cols := vdi_intout(1);
end;


procedure v_exit_cur(handle: VdiHdl) is
begin
	v_escape(handle, 2);
end;


procedure v_enter_cur(handle: VdiHdl) is
begin
	v_escape(handle, 3);
end;


procedure v_curup(handle: VdiHdl) is
begin
	v_escape(handle, 4);
end;


procedure v_curdown(handle: VdiHdl) is
begin
	v_escape(handle, 5);
end;


procedure v_curright(handle: VdiHdl) is
begin
	v_escape(handle, 6);
end;


procedure v_curleft(handle: VdiHdl) is
begin
	v_escape(handle, 7);
end;


procedure v_curhome(handle: VdiHdl) is
begin
	v_escape(handle, 8);
end;


procedure v_eeos(handle: VdiHdl) is
begin
	v_escape(handle, 9);
end;


procedure v_eeol(handle: VdiHdl) is
begin
	v_escape(handle, 10);
end;


procedure v_curaddress(
            handle: VdiHdl;
            row: int16;
            column: int16) is
begin
	vdi_intin(0) := row;
	vdi_intin(1) := column;
	v_escape(handle, 11, 2);
end;


procedure v_curtext(handle: VdiHdl; str: String) is
	len : int16;
begin
	len := string_to_vdi(str, 0);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: String; maxlen: int16) is
	len : int16;
begin
	len := string_to_vdi(str, 0, maxlen);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: Wide_String) is
	len : int16;
begin
	len := string_to_vdi(str, 0);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: Wide_String; maxlen: int16) is
	len : int16;
begin
	len := string_to_vdi(str, 0, maxlen);
	v_escape(handle, 12, len);
end;


procedure v_rvon(handle: VdiHdl) is
begin
	v_escape(handle, 13);
end;


procedure v_rvoff(handle: VdiHdl) is
begin
	v_escape(handle, 14);
end;


procedure vq_curaddress(handle : VdiHdl;
            cur_row: out int16;
            cur_column: out int16) is
begin
	v_escape(handle, 15);
	cur_row := vdi_intout(0);
	cur_column := vdi_intout(0);
end;


function vq_tabstatus(handle: VdiHdl) return int16 is
begin
	v_escape(handle, 16);
	return vdi_intout(0);
end;


procedure v_hardcopy(handle: VdiHdl) is
begin
	v_escape(handle, 17);
end;


procedure v_dspcur(handle: VdiHdl; x : int16; y : int16) is
begin
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	v_escape(handle, 18, 0, 1);
end;


procedure v_rmcur(handle: VdiHdl) is
begin
	v_escape(handle, 19);
end;


procedure v_form_adv(handle: VdiHdl) is
begin
	v_escape(handle, 20);
end;


procedure v_output_window(handle: VdiHdl; pxy: short_array) is
begin
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	v_escape(handle, 21, 0, 2);
end;


procedure v_clear_disp_list(handle: VdiHdl) is
begin
	v_escape(handle, 22);
end;


procedure v_bit_image(
            handle  : VdiHdl;
            filename: string;
            aspect  : int16;
            x_scale : int16;
            y_scale : int16;
            h_align : int16;
            v_align : int16;
            pxy     : short_array) is
	len: int16;
begin
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	vdi_intin(0) := aspect;
	vdi_intin(1) := x_scale;
	vdi_intin(2) := y_scale;
	vdi_intin(3) := h_align;
	vdi_intin(4) := v_align;
	len := string_to_vdi(filename, 5);
	v_escape(handle, 23, len + 5, 2);
end;


procedure vq_scan(
            handle : VdiHdl;
            g_slice: out int16;
            g_page : out int16;
            a_slice: out int16;
            a_page : out int16;
            div_fac: out int16) is
begin
	v_escape(handle, 24);
	g_slice := vdi_intout(0);
	g_page := vdi_intout(1);
	a_slice := vdi_intout(2);
	a_page := vdi_intout(3);
	div_fac := vdi_intout(4);
end;


procedure v_alpha_text(handle: VdiHdl; str: string) is
	len: int16;
begin
	len := string_to_vdi(str, 0);
	v_escape(handle, 25, len);
end;


function v_orient(
            handle     : VdiHdl;
            orientation: int16)
           return int16 is
begin
	vdi_intin(0) := orientation;
	vdi_control.num_intout := 0;
	v_escape(handle, 27, 1);
	if vdi_control.num_intout /= 0 then
		return vdi_intout(0);
	end if;
	return 0;
end;


function v_copies(
            handle : VdiHdl;
            count: int16)
           return int16 is
begin
	vdi_intin(0) := count;
	vdi_control.num_intout := 0;
	v_escape(handle, 28, 1);
	if vdi_control.num_intout /= 0 then
		return vdi_intout(0);
	end if;
	return 0;
end;


function v_tray(
            handle    : VdiHdl;
            input     : int16)
           return boolean is
begin
	vdi_intin(0) := input;
	vdi_control.num_intout := 0;
	v_escape(handle, 29, 1);
	if vdi_control.num_intout /= 0 then
		return true;
	end if;
	return false;
end;


function v_trays(
            handle    : VdiHdl;
            input     : int16;
            output    : int16;
            set_input : out int16;
            set_output: out int16)
           return boolean is
begin
	vdi_intin(0) := input;
	vdi_intin(1) := output;
	vdi_control.num_intout := 0;
	v_escape(handle, 29, 2);
	if vdi_control.num_intout /= 0 then
		set_input := vdi_intout(0);
		set_output := vdi_intout(1);
		return true;
	end if;
	set_input := 0;
	set_output := 0;
	return false;
end;


function v_page_size(
            handle : VdiHdl;
            page_id: int16)
           return int16 is
begin
	vdi_intin(0) := page_id;
	vdi_control.num_intout := 0;
	v_escape(handle, 37, 1);
	if vdi_control.num_intout /= 0 then
		return vdi_intout(0);
	end if;
	return 0;
end;


function vs_palette(
            handle : VdiHdl;
            palette: int16)
           return int16 is
begin
	vdi_intin(0) := palette;
	v_escape(handle, 60, 1);
	return vdi_intout(0);
end;


procedure v_sound(
            handle  : VdiHdl;
            freq    : int16;
            duration: int16) is
begin
	vdi_intin(0) := freq;
	vdi_intin(1) := duration;
	v_escape(handle, 61, 2);
end;


function vs_mute(
            handle: VdiHdl;
            action: int16)
           return int16 is
begin
	vdi_intin(0) := action;
	v_escape(handle, 62, 1);
	return vdi_intout(0);
end;


procedure vt_resolution(
            handle: VdiHdl;
            xres: int16;
            yres: int16;
            xset: out int16;
            yset: out int16) is
begin
	vdi_intin(0) := xres;
	vdi_intin(1) := yres;
	v_escape(handle, 81, 2);
	xset := vdi_intout(0);
	yset := vdi_intout(1);
end;


procedure vt_axis(
            handle: VdiHdl;
            xres: int16;
            yres: int16;
            xset: out int16;
            yset: out int16) is
begin
	vdi_intin(0) := xres;
	vdi_intin(1) := yres;
	v_escape(handle, 82, 2);
	xset := vdi_intout(0);
	yset := vdi_intout(1);
end;


procedure vt_origin(
            handle : VdiHdl;
            xorigin: int16;
            yorigin: int16) is
begin
	vdi_intin(0) := xorigin;
	vdi_intin(1) := yorigin;
	v_escape(handle, 83, 2);
end;


procedure vq_tdimensions(
            handle    : VdiHdl;
            xdimension: out int16;
            ydimension: out int16) is
begin
	v_escape(handle, 84);
	xdimension := vdi_intout(0);
	ydimension := vdi_intout(1);
end;


procedure vt_alignment(
            handle: VdiHdl;
            dx: int16;
            dy: int16) is
begin
	vdi_intin(0) := dx;
	vdi_intin(1) := dy;
	v_escape(handle, 85, 2);
end;


procedure vsp_film(
            handle   : VdiHdl;
            color_idx: int16;
            lightness: int16) is
begin
	vdi_intin(0) := color_idx;
	vdi_intin(1) := lightness;
	v_escape(handle, 91, 2);
end;


function vqp_filmname(
            handle : VdiHdl;
            index: int16;
            name : out String)
           return int16 is
begin
	vdi_intin(0) := index;
	v_escape(handle, 92, 1);
	vdi_to_string(name, vdi_control.num_intout);
	return vdi_control.num_intout;
end;


procedure vsc_expose(
            handle : VdiHdl;
            state: int16) is
begin
	vdi_intin(0) := state;
	v_escape(handle, 93, 1);
end;

















procedure v_circle(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            radius: int16) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 3;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 4;
	vdi_control.handle := handle;

	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := 0;
	vdi_ptsin(3) := 0;
	vdi_ptsin(4) := radius;
	vdi_ptsin(5) := 0;
	vdi_trap;
end;


procedure v_ellipse(
            handle: VdiHdl;
            x   : int16;
            y   : int16;
            xradius: int16;
            yradius: int16) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 5;
	vdi_control.handle := handle;

	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := xradius;
	vdi_ptsin(3) := yradius;
	vdi_trap;
end;


function vsf_interior(
            handle : VdiHdl;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 23;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_style(
            handle : VdiHdl;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 24;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_color(
            handle   : VdiHdl;
            color_idx: int16)
           return int16 is
begin
	vdi_control.opcode := 25;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := color_idx;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vswr_mode(
            handle: VdiHdl;
            mode: int16)
           return int16 is
begin
	vdi_control.opcode := 32;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := mode;

	vdi_trap;
	
	return vdi_intout(0);
end;


procedure v_opnvwk(
            work_in : vdi_workin_array;
            handle  : in out int16;
            work_out: out vdi_workout_array) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(System.Address, VDIIntIn_ptr);
    function to_intout is new Ada.Unchecked_Conversion(System.Address, VDIIntOut_ptr);
    function to_ptsout is new Ada.Unchecked_Conversion(System.Address, VDIPtsOut_ptr);
begin
	vdi_control.opcode := 100;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := work_in'Length;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	pb.control := vdi_control'Access;
	pb.intin := to_intin(work_in'Address);
	pb.ptsin := vdi_ptsin'Access;
	pb.intout := to_intout(work_out(0)'Address);
	pb.ptsout := to_ptsout(work_out(45)'Address);
	
	vdi(pb'Unchecked_Access);
	
	handle := vdi_control.handle;
end;


procedure v_clsvwk(handle: VdiHdl) is
begin
	vdi_control.opcode := 101;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


function vsf_perimeter(
            handle: VdiHdl;
            vis: int16)
           return int16 is
begin
	vdi_control.opcode := 104;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := vis;
	vdi_trap;
	
	return vdi_intout(0);
end;


function vsf_perimeter(
            handle : VdiHdl;
            vis  : int16;
            style: int16)
           return int16 is
begin
	vdi_control.opcode := 104;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 2;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := vis;
	vdi_intin(1) := style;
	vdi_trap;
	
	return vdi_intout(0);
end;


procedure vr_recfl(
            handle : VdiHdl;
            pxy    : short_array) is
begin
	vdi_control.opcode := 114;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	vdi_trap;
end;


procedure vs_clip(
            handle   : VdiHdl;
            clip_flag: int16;
            pxy      : short_array) is
begin
	vdi_control.opcode := 129;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := clip_flag;
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	vdi_trap;
end;


procedure vs_clip(
            handle   : VdiHdl;
            clip_flag: int16;
            pxy      : PXY_array) is
begin
	vdi_control.opcode := 129;
	vdi_control.num_ptsin := 2;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_intin(0) := clip_flag;
	vdi_ptsin(0) := pxy(0).p_x;
	vdi_ptsin(1) := pxy(0).p_y;
	vdi_ptsin(2) := pxy(1).p_x;
	vdi_ptsin(3) := pxy(1).p_y;
	vdi_trap;
end;



function vq_vgdos return uint32 is
    v: uint32;
    use ASCII;
begin
    asm("moveq #-2,%%d0" & LF & HT &
        "trap #2" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        volatile => true,
        outputs => Interfaces.Unsigned_32'Asm_output("=r", v),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
    return v;
end;


function vq_gdos return boolean is
    use ASCII;
    v: Unsigned_32;
begin
    asm("moveq #-2,%%d0" & LF & HT &
        "trap #2" & LF & HT &
        "addq.w #2,%%d0" & LF & HT &
        "ext.l %%d0" & LF & HT &
        "move.l %%d0,%0" & LF & HT,
        volatile => true,
        outputs => Unsigned_32'Asm_output("=r", v),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
    return v /= 0;
end;

end Atari.Vdi;
