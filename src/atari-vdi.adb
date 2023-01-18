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


procedure v_curtext(handle: VdiHdl; str: in String) is
	len : int16;
begin
	len := string_to_vdi(str, 0);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: in String; maxlen: int16) is
	len : int16;
begin
	len := string_to_vdi(str, 0, maxlen);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: in Wide_String) is
	len : int16;
begin
	len := string_to_vdi(str, 0);
	v_escape(handle, 12, len);
end;


procedure v_curtext(handle: VdiHdl; str: in Wide_String; maxlen: int16) is
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


procedure v_alpha_text(handle: VdiHdl; str: in string) is
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


procedure v_meta_extents(
            handle : VdiHdl;
            min_x: int16;
            min_y: int16;
            max_x: int16;
            max_y: int16) is
begin
	vdi_ptsin(0) := min_x;
	vdi_ptsin(1) := min_y;
	vdi_ptsin(2) := max_x;
	vdi_ptsin(3) := max_y;
	v_escape(handle, 98, 0, 2);
end;


procedure v_write_meta(
            handle      : VdiHdl;
            num_intin   : int16;
            a_intin  : short_array;
            num_ptsin   : int16;
            a_ptsin     : short_array) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(System.Address, VDIIntIn_ptr);
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 5;
	vdi_control.num_ptsin := num_ptsin;
	vdi_control.num_intin := num_intin;
	vdi_control.subcode := 99;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := to_intin(a_intin'Address);
	pb.ptsin := to_ptsin(a_ptsin'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
end;


procedure vm_pagesize(
            handle  : VdiHdl;
            pgwidth : int16;
            pgheight: int16) is
begin
	vdi_intin(0) := 0;
	vdi_intin(1) := pgwidth;
	vdi_intin(2) := pgheight;
	v_escape(handle, 99, 3);
end;


procedure vm_coords(
            handle: VdiHdl;
            llx: int16;
            lly: int16;
            urx: int16;
            ury: int16) is
begin
	vdi_intin(0) := 1;
	vdi_intin(1) := llx;
	vdi_intin(2) := lly;
	vdi_intin(3) := urx;
	vdi_intin(4) := ury;
	v_escape(handle, 99, 5);
end;


function v_bez_qual(
            handle: VdiHdl;
            prcnt: int16) return int16 is
begin
	vdi_intin(0) := 32;
	vdi_intin(1) := 1;
	vdi_intin(2) := prcnt;
	v_escape(handle, 99, 3);
	return vdi_intout(0);
end;


procedure vm_filename(
            handle  : VdiHdl;
            filename: in string) is
	len: int16;
begin
	len := string_to_vdi(filename, 0);
	v_escape(handle, 100, len);
end;


procedure v_offset(
            handle: VdiHdl;
            offset: int16) is
begin
	vdi_intin(0) := offset;
	v_escape(handle, 101, 1);
end;


procedure v_fontinit(
            handle     : VdiHdl;
            font_header: System.Address) is
    type address_ptr is access all System.Address;
    function to_address is new Ada.Unchecked_Conversion(System.Address, address_ptr);
    ptr: System.Address;
    pptr: aliased address_ptr;
begin
    ptr := vdi_intin(0)'Address;
    pptr := to_address(ptr);
    pptr.all := font_header;
	v_escape(handle, 102, 2);
end;


procedure v_escape2000(
            handle : VdiHdl;
            times: int16) is
begin
    vdi_intin(0) := times;
	v_escape(handle, 2000, 1);
end;


procedure v_pline(
            handle: VdiHdl;
            count : int16;
            pxy:    short_array) is
    pb: aliased VDIPB;
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 6;
	vdi_control.num_ptsin := count;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := vdi_intin'Access;
	pb.ptsin := to_ptsin(pxy'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
end;


procedure v_bez(
            handle: VdiHdl;
            count : int16;
            pxy:    short_array;
            bezarr: System.Address;
            extent: out short_array;
            totpts: out int16;
            totmoves: out int16) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(System.Address, VDIIntIn_ptr);
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 6;
	vdi_control.num_ptsin := count;
	vdi_control.num_intin := int16(Shift_Right(Unsigned_16(count + 1), 1));
	vdi_control.subcode := 13;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := to_intin(bezarr);
	pb.ptsin := to_ptsin(pxy'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
	totpts := vdi_intout(0);
	totmoves := vdi_intout(1);
	extent(0) := vdi_ptsout(0);
	extent(1) := vdi_ptsout(1);
	extent(2) := vdi_ptsout(2);
	extent(3) := vdi_ptsout(3);
end;


procedure v_pmarker(
            handle: VdiHdl;
            count : int16;
            pxy:    short_array) is
    pb: aliased VDIPB;
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 7;
	vdi_control.num_ptsin := count;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := vdi_intin'Access;
	pb.ptsin := to_ptsin(pxy'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
end;


procedure v_gtext(
            handle: VdiHdl;
            x  : int16;
            y  : int16;
            str: in String) is
    len: int16;
begin
	len := string_to_vdi(str, 0);
	vdi_control.opcode := 8;
	vdi_control.num_ptsin := 1;
	vdi_control.num_intin := len;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_trap;
end;


procedure v_gtext(
            handle: VdiHdl;
            x  : int16;
            y  : int16;
            str: in Wide_String) is
    len: int16;
begin
	len := string_to_vdi(str, 0);
	vdi_control.opcode := 8;
	vdi_control.num_ptsin := 1;
	vdi_control.num_intin := len;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_trap;
end;


procedure v_fillarea(
            handle: VdiHdl;
            count : int16;
            pxy:    short_array) is
    pb: aliased VDIPB;
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 9;
	vdi_control.num_ptsin := count;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := vdi_intin'Access;
	pb.ptsin := to_ptsin(pxy'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
end;



procedure v_bez_fill(
            handle: VdiHdl;
            count : int16;
            pxy:    short_array;
            bezarr: System.Address;
            extent: out short_array;
            totpts: out int16;
            totmoves: out int16) is
    pb: aliased VDIPB;
    function to_intin is new Ada.Unchecked_Conversion(System.Address, VDIIntIn_ptr);
    function to_ptsin is new Ada.Unchecked_Conversion(System.Address, VDIPtsIn_ptr);
begin
	vdi_control.opcode := 9;
	vdi_control.num_ptsin := count;
	vdi_control.num_intin := int16(Shift_Right(Unsigned_16(count + 1), 1));
	vdi_control.subcode := 13;
	vdi_control.handle := handle;
	pb.control := vdi_control'Access;
	pb.intin := to_intin(bezarr);
	pb.ptsin := to_ptsin(pxy'Address);
	pb.intout := vdi_intout'Access;
	pb.ptsout := vdi_ptsout'Access;
	vdi(pb'Unchecked_Access);
	totpts := vdi_intout(0);
	totmoves := vdi_intout(1);
	extent(0) := vdi_ptsout(0);
	extent(1) := vdi_ptsout(1);
	extent(2) := vdi_ptsout(2);
	extent(3) := vdi_ptsout(3);
end;


procedure v_gdp(handle: VdiHdl; subcode: int16; num_ptsin: int16; num_intin: int16 := 0) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := num_ptsin;
	vdi_control.num_intin := num_intin;
	vdi_control.subcode := subcode;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure v_bar(
            handle: VdiHdl;
            pxy:    short_array) is
begin
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	v_gdp(handle, 1, 2);
end;


procedure v_arc(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            radius: int16;
            begang: int16;
            endang: int16) is
begin
	vdi_intin(0) := begang;
	vdi_intin(1) := endang;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := 0;
	vdi_ptsin(3) := 0;
	vdi_ptsin(4) := 0;
	vdi_ptsin(5) := 0;
	vdi_ptsin(6) := radius;
	vdi_ptsin(7) := 0;
	v_gdp(handle, 2, 4, 2);
end;


procedure v_pieslice(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            radius: int16;
            begang: int16;
            endang: int16) is
begin
	vdi_intin(0) := begang;
	vdi_intin(1) := endang;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := 0;
	vdi_ptsin(3) := 0;
	vdi_ptsin(4) := 0;
	vdi_ptsin(5) := 0;
	vdi_ptsin(6) := radius;
	vdi_ptsin(7) := 0;
	v_gdp(handle, 3, 4, 2);
end;


procedure v_circle(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            radius: int16) is
begin
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := 0;
	vdi_ptsin(3) := 0;
	vdi_ptsin(4) := radius;
	vdi_ptsin(5) := 0;
	v_gdp(handle, 4, 3);
end;


procedure v_ellipse(
            handle: VdiHdl;
            x   : int16;
            y   : int16;
            xradius: int16;
            yradius: int16) is
begin
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := xradius;
	vdi_ptsin(3) := yradius;
	v_gdp(handle, 5, 2);
end;


procedure v_ellarc(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            xradius  : int16;
            yradius  : int16;
            begang: int16;
            endang: int16) is
begin
	vdi_intin(0) := begang;
	vdi_intin(1) := endang;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := xradius;
	vdi_ptsin(3) := yradius;
	v_gdp(handle, 6, 2, 2);
end;


procedure v_ellpie(
            handle: VdiHdl;
            x     : int16;
            y     : int16;
            xradius  : int16;
            yradius  : int16;
            begang: int16;
            endang: int16) is
begin
	vdi_intin(0) := begang;
	vdi_intin(1) := endang;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := xradius;
	vdi_ptsin(3) := yradius;
	v_gdp(handle, 7, 2, 2);
end;


procedure v_rbox(
            handle: VdiHdl;
            pxy:    short_array) is
begin
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	v_gdp(handle, 8, 2);
end;


procedure v_rfbox(
            handle: VdiHdl;
            pxy:    short_array) is
begin
	vdi_ptsin(0) := pxy(0);
	vdi_ptsin(1) := pxy(1);
	vdi_ptsin(2) := pxy(2);
	vdi_ptsin(3) := pxy(3);
	v_gdp(handle, 9, 2);
end;


procedure v_justified(
            handle    : VdiHdl;
            x         : int16;
            y         : int16;
            str       : in string;
            width     : int16;
            word_space: int16;
            char_space: int16) is
	len: int16;
begin
	--  TODO: handle char_space $8000/$8001 (returns interspace information)
	vdi_intin(0) := word_space;
	vdi_intin(1) := char_space;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := width;
	vdi_ptsin(3) := 0;

	len := string_to_vdi(str, 2);
	v_gdp(handle, 11, 2, len + 2);
end;


procedure v_justified(
            handle    : VdiHdl;
            x         : int16;
            y         : int16;
            str       : in Wide_String;
            width     : int16;
            word_space: int16;
            char_space: int16) is
	len: int16;
begin
	--  TODO: handle char_space $8000/$8001 (returns interspace information)
	vdi_intin(0) := word_space;
	vdi_intin(1) := char_space;
	vdi_ptsin(0) := x;
	vdi_ptsin(1) := y;
	vdi_ptsin(2) := width;
	vdi_ptsin(3) := 0;

	len := string_to_vdi(str, 2);
	v_gdp(handle, 11, 2, len + 2);
end;


function v_bez_on(handle: VdiHdl) return int16 is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 1;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 13;
	vdi_control.handle := handle;
	vdi_intout(0) := 0;

	vdi_trap;

	return vdi_intout(0);
end;


procedure v_bez_off(handle: VdiHdl) is
begin
	vdi_control.opcode := 11;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 13;
	vdi_control.handle := handle;
	vdi_trap;
end;


procedure vst_height(
            handle: VdiHdl;
            height: int16;
            charw : out int16;
            charh : out int16;
            cellw : out int16;
            cellh : out int16) is
begin
	vdi_ptsin(0) := 0;
	vdi_ptsin(1) := height;

	vdi_control.opcode := 12;
	vdi_control.num_ptsin := 1;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	charw := vdi_ptsout(0);
	charh := vdi_ptsout(1);
	cellw := vdi_ptsout(2);
	cellh := vdi_ptsout(3);
end;


function vst_rotation(
            handle: VdiHdl;
            angle: int16)
           return int16 is
begin
	vdi_intin(0) := angle;

	vdi_control.opcode := 13;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	return vdi_intout(0);
end;


procedure vs_color(
            handle   : VdiHdl;
            color_idx: int16;
            rgb      : in short_array) is
begin
	vdi_intin(0) := color_idx;
	vdi_intin(1) := rgb(0);
	vdi_intin(2) := rgb(1);
	vdi_intin(3) := rgb(2);

	vdi_control.opcode := 14;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 4;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


function vsl_type(
            handle : VdiHdl;
            style: int16)
           return int16 is
begin
	vdi_intin(0) := style;

	vdi_control.opcode := 15;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	return vdi_intout(0);
end;


function vsl_width(
            handle : VdiHdl;
            width: int16)
           return int16 is
begin
	vdi_ptsin(0) := width;
	vdi_ptsin(1) := 0;

	vdi_control.opcode := 16;
	vdi_control.num_ptsin := 1;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	return vdi_ptsout(0);
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
