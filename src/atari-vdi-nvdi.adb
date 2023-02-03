pragma No_Strict_Aliasing;
with Ada.Unchecked_Conversion;
with System.Storage_Elements; use System.Storage_Elements;

--
-- NOT YET IMPLEMENTED:
--  v_ps_halftone
--  v_etext

--  v_setrgbi
--  v_xbit_image
--  v_topbot
--  vs_bkcolor
--  v_pat_rotate
--  vs_grayoverride

--  v_get_driver_info
--  vqt_real_extent

--  vq_margins
--  vq_driver_info
--  vq_bit_image
--  vs_page_info
--  vs_crop
--  vq_image_type
--  vs_save_disp_list
--  vs_load_disp_list

--  vqt_xfntinfo
--  vq_ext_devinfo
--  vqt_name_and_id
--  vst_name

--  vqt_char_index

--  vqt_is_char_available

--  v_color2nearest
--  v_color2value
--  v_create_ctab
--  v_create_itab
--  v_ctab_idx2value
--  v_ctab_idx2vdi
--  v_ctab_vdi2idx
--  v_delete_ctab
--  v_delete_itab
--  v_get_ctab_id
--  v_get_outline
--  v_value2color
--  vq_ctab
--  vq_ctab_entry
--  vq_ctab_id
--  vq_dflt_ctab
--  vq_hilite_color
--  vq_margins
--  vq_max_color
--  vq_min_color
--  vq_prn_scaling
--  vq_px_format
--  vq_weight_color
--  vqf_bg_color
--  vqf_fg_color
--  vql_bg_color
--  vql_fg_color
--  vqm_bg_color
--  vqm_fg_color
--  vqr_bg_color
--  vqr_fg_color
--  vqt_bg_color
--  vqt_fg_color
--  vs_ctab
--  vs_ctab_entry
--  vs_dflt_ctab
--  vs_document_info
--  vs_hilite_color
--  vs_max_color
--  vs_min_color
--  vs_weight_color
--  vsf_bg_color
--  vsf_fg_color
--  vsl_bg_color
--  vsl_fg_color
--  vsm_bg_color
--  vsm_fg_color
--  vsr_bg_color
--  vsr_fg_color
--  vst_bg_color
--  vst_fg_color
--  vr_clip_rects_by_dst
--  vr_clip_rects_by_src
--  vr_clip_rects32_by_dst
--  vr_clip_rects32_by_src
--


package body Atari.Vdi.Nvdi is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


function To_Address is
  new Ada.Unchecked_Conversion (chars_ptr, System.Address);

function "+" (Left : chars_ptr; Right : Integer) return chars_ptr is
pragma Inline ("+");
   function To_chars_ptr is
      new Ada.Unchecked_Conversion (System.Address, chars_ptr);
begin
   return To_chars_ptr (To_Address (Left) + Storage_Offset(Right));
end "+";



function fix31_to_point(fix: fix31) return int16 is
begin
	return int16(Shift_Right(Unsigned_32(fix + 32768), 16));
end;


function point_to_fix31(point: int16) return fix31 is
begin
	return fix31(Shift_Left(Unsigned_32(point), 16));
end;


procedure set_intin_pointer(offset: Integer; val: System.Address) is
    ptr: System.Address;
begin
    ptr := vdi_intin(offset)'Address;
    void_ptr'Deref(ptr) := val;
end;


procedure set_intin_long(offset: Integer; val: int32) is
    ptr: System.Address;
begin
    ptr := vdi_intin(offset)'Address;
    int32'Deref(ptr) := val;
end;


function get_intout_pointer(offset: Integer) return System.Address is
    ptr: System.Address;
begin
    ptr := vdi_intout(offset)'Address;
    return void_ptr'Deref(ptr);
end;


function get_intout_long(offset: Integer) return int32 is
    ptr: System.Address;
begin
    ptr := vdi_intout(offset)'Address;
    return int32'Deref(ptr);
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


function vq_tray_names(handle: VdiHdl; input_name: chars_ptr; output_name: chars_ptr; input: out int16; output: out int16) return boolean is
begin
	set_intin_pointer(0, to_address(input_name));
	set_intin_pointer(2, to_address(output_name));
	vdi_control.num_intout := 0;
	v_escape(handle, 36, 4);
	if vdi_control.num_intout > 0 then
		input := vdi_intout(0);
		output := vdi_intout(1);
	else
		input := 0;
		output := 0;
		input_name.all := Character'Val(0);
		output_name.all := Character'Val(0);
	end if;
	return vdi_control.num_intout > 0;
end;


function vq_page_name(
            handle     : VdiHdl;
            page_id    : int16;
            page_name  : chars_ptr;
            page_width : out int32;
            page_height: out int32)
           return int16 is
begin
	vdi_intin(0) := page_id;
	set_intin_pointer(1, to_address(page_name));
	vdi_control.num_intout := 0;
	v_escape(handle, 38, 4);
	if vdi_control.num_intout = 0 then
		return -1;
	end if;
	page_width := get_intout_long(1);
	page_height := get_intout_long(3);
	return vdi_intout(0);
end;


function vs_calibrate(
            handle: VdiHdl;
            flag: int16;
            rgb : short_array)
           return int16 is
begin
	set_intin_pointer(0, rgb'Address);
    vdi_intin(2) := flag;
    v_escape(handle, 76, 3);
    return vdi_intout(0);
end;


function vq_calibrate(handle: VdiHdl; flag: out int16) return int16 is
begin
    v_escape(handle, 77);
    flag := vdi_intout(0);
    return vdi_control.num_intout;
end;


procedure vst_width(handle: VdiHdl; width: int16; char_width, char_height, cell_width, cell_height: out int16) is
begin
	vdi_intin(0) := width;
	vdi_control.opcode := 231;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	char_width := vdi_intout(0);
	char_height := vdi_intout(1);
	cell_width := vdi_intout(2);
	cell_height := vdi_intout(3);
end;


procedure vqt_fontheader(handle: VdiHdl; buffer: System.Address; pathname: out String) is
begin
    set_intin_pointer(0, buffer);
	vdi_control.opcode := 232;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 2;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	vdi_to_string(pathname, vdi_control.num_intout);
end;


procedure vst_scratch(handle: VdiHdl; mode: int16) is
begin
	vdi_intin(0) := mode;
	vdi_control.opcode := 244;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


procedure vst_error(handle: VdiHdl; mode: int16; errorvar: short_ptr) is
begin
	vdi_intin(0) := mode;
    set_intin_pointer(1, errorvar.all'Address);
	vdi_control.opcode := 245;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 3;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
end;


function vq_devinfo(handle: VdiHdl; device: int16; dev_exists: out boolean; filename: out String; device_name: out String) return int16 is
	p: Integer;
	len: Integer;
    function to_address is new Ada.Unchecked_Conversion(short_ptr, chars_ptr);
    pts: chars_ptr;
begin
	vdi_intin(0) := device;
	vdi_control.opcode := 248;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	-- does the driver exist ? */
	if (vdi_control.num_intout = 0 or else vdi_intout(0) = 0) 
	then
		dev_exists := false;
		filename := "";
		device_name := "";
		return 0;
	end if;
	
	-- set the filename. The value in vdi_intout may be "DRIVER.SYS"
	-- or "DRIVER   SYS". vdi_intout is not a nul-terminated string.
	-- In both cases, this binding returns a valid filename: "DRIVER.SYS"
	-- with a null-character to ended the string. 
	p := 0;
	for i in 0 .. Integer(vdi_control.num_intout) loop
		filename(p) := Character'Val(vdi_intout(i));
		if filename(p) = ' ' then
			if vdi_intout(i + 1) /= Character'Pos(' ') then
		 		filename(p) := '.';
				p := p + 1;
			end if;
		else
			p := p + 1;
		end if;
	end loop;
	
	-- device name in ptsout is a C-String, (a nul-terminated string with 8bits per characters)
	-- each short value (vdi_ptsout[x]) contains 2 characters.
	-- When ptsout contains a device name, NVDI/SpeedoGDOS seems to always write the value "13"
	-- in vdi_control[1] (hey! this should be a read only value from the VDI point of view!!!),
	-- and SpeedoGDOS 5 may set vdi_control[2] == 1 (intead of the size of vdi_ptsout, including
	-- the device_name). It's seems that this value "13" (written in vdi_control[1]) has missed
	-- its target (vdi_control[2]). So, here is a workaround:
	if vdi_control.num_ptsout = 1 and then vdi_control.num_ptsin > 0 then
		len := Integer(vdi_control.num_ptsin * 2);
	else
		len := Integer((vdi_control.num_ptsout - 1) * 2);
	end if;
	pts := to_address(vdi_ptsout(1)'Access);
	for i in 0 .. len - 1 loop
		device_name(i + 1) := pts.all;
		pts := pts + 1;
	end loop;
	return vdi_intout(0);
end;


function v_savecache(handle: VdiHdl; filename: in String) return int16 is
    len: int16;
begin
    len := string_to_vdi(filename, 0);
	vdi_control.opcode := 249;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := len;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	return vdi_intout(0);
end;


function v_loadcache(handle: VdiHdl; filename: in String; mode: int16) return int16 is
    len: int16;
begin
	vdi_intin(0) := mode;
    len := string_to_vdi(filename, 1);
	vdi_control.opcode := 250;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := len + 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	return vdi_intout(0);
end;


function v_flushcache(handle: VdiHdl) return int16 is
begin
	vdi_control.opcode := 251;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	return vdi_intout(0);
end;


function vst_setsize(handle: VdiHdl; point: int16; chwd, chht, cellwd, cellht: out int16) return int16 is
begin
	vdi_intin(0) := point;
	vdi_control.opcode := 252;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	chwd := vdi_ptsout(0);
	chht := vdi_ptsout(1);
	cellwd := vdi_ptsout(2);
	cellht := vdi_ptsout(3);

	return vdi_intout(0);
end;


function vst_setsize(handle: VdiHdl; point: fix31; chwd, chht, cellwd, cellht: out int16) return int16 is
begin
	set_intin_long(0, point);
	vdi_control.opcode := 252;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 2;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;
	
	chwd := vdi_ptsout(0);
	chht := vdi_ptsout(1);
	cellwd := vdi_ptsout(2);
	cellht := vdi_ptsout(3);

	return vdi_intout(0);
end;


function vst_skew(handle: VdiHdl; skew: int16) return int16 is
begin
	vdi_intin(0) := skew;
	vdi_control.opcode := 253;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	return vdi_intout(0);
end;


procedure vqt_get_table(handle: VdiHdl; map: out short_ptr) is
    function to_address is new Ada.Unchecked_Conversion(System.Address, short_ptr);
begin
	vdi_control.opcode := 254;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 0;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	map := to_address(get_intout_pointer(0));
end;


procedure vqt_cachesize(handle: VdiHdl; which_cache: int16; size: out int32) is
begin
	vdi_intin(0) := which_cache;
	vdi_control.opcode := 255;
	vdi_control.num_ptsin := 0;
	vdi_control.num_intin := 1;
	vdi_control.subcode := 0;
	vdi_control.handle := handle;

	vdi_trap;

	size := get_intout_long(0);
end;


function v_open_bm(
            base_handle: VdiHdl;
            bitmap: GCBITMAP_ptr;
            color_flags: int16;
            unit_flags: int16;
            pixel_width, pixel_height: int16) return VdiHdl is
begin
    vdi_control.opcode := 100;
    vdi_control.num_ptsin := 0;
    vdi_control.num_intin := 4;
    vdi_control.subcode := 3;
    vdi_control.handle := base_handle;
	vdi_control.ptr1 := bitmap.all'Address;

    vdi_intin(0) := color_flags;
    vdi_intin(1) := unit_flags;
    vdi_intin(2) := pixel_width;
    vdi_intin(3) := pixel_height;
    
    vdi_trap;
    
    return vdi_intout(0);
end;


function vqt_ext_name(
            handle     : VdiHdl;
            index      : int16;
            name       : out String;
            vector_font: out int16;
            font_format: out int16;
            flags      : out int16)
           return int16 is
begin
    vdi_intin(0) := index;
    vdi_intin(1) := 0;

    vdi_control.opcode := 130;
    vdi_control.num_ptsin := 0;
    vdi_control.num_intin := 2;
    vdi_control.subcode := 1;
    vdi_control.handle := handle;

	--  set the 0 as return value in case NVDI is not present
	vdi_intout(0) := 0;
	
    vdi_trap;

    vdi_to_string(name, 32, 1);

	if (vdi_control.num_intout > 34) then
		vector_font  := vdi_intout(33);
		flags        := int16(Shift_Right(uint16(vdi_intout(34)), 8) and 255);
		font_format  := vdi_intout(34) and 255;
	else if (vdi_control.num_intout > 33 ) then
		vector_font	 := vdi_intout(33);
		flags		 := 0;
		font_format  := (if vdi_intout(33) /= 0 then 0 else 1);
	else
		vector_font	 := 0;
		flags		 := 0;
		font_format  := 0;
	end if; end if;

    return vdi_intout(0);
end;


procedure v_setrgb(
            handle: VdiHdl;
            c_type: int16;
            r     : int16;
            g     : int16;
            b     : int16) is
begin
    vdi_control.opcode := 138;
    vdi_control.num_ptsin := 0;
    vdi_control.num_intin := 3;
    vdi_control.subcode := c_type;
    vdi_control.handle := handle;

    vdi_intin(0) := r;
    vdi_intin(1) := g;
    vdi_intin(2) := b;
    
    vdi_trap;
end;


procedure vr_transfer_bits(
            handle  : VdiHdl;
            src_bm  : in GCBITMAP;
            dst_bm  : in GCBITMAP;
            src_rect: in RECT16;
            dst_rect: in RECT16;
            mode    : int16) is
begin
    vdi_control.opcode := 170;
    vdi_control.num_ptsin := 4;
    vdi_control.num_intin := 4;
    vdi_control.subcode := 0;
    vdi_control.handle := handle;

    vdi_intin(0) := mode;
    vdi_intin(1) := 0;
    vdi_intin(2) := 0;
    vdi_intin(3) := 0;
    vdi_ptsin(0) := src_rect.x1;
    vdi_ptsin(1) := src_rect.y1;
    vdi_ptsin(2) := src_rect.x2;
    vdi_ptsin(3) := src_rect.y2;
    vdi_ptsin(4) := dst_rect.x1;
    vdi_ptsin(5) := dst_rect.y1;
    vdi_ptsin(6) := dst_rect.x2;
    vdi_ptsin(7) := dst_rect.y2;
    vdi_control.ptr1 := src_bm'Address;
    vdi_control.ptr2 := dst_bm'Address;
    vdi_control.ptr3 := System.Null_Address;
    
    vdi_trap;
end;


function v_create_driver_info(
            handle   : VdiHdl;
            driver_id: int16)
           return Aes.Pdlg.DRV_INFO_ptr is
begin
    vdi_control.opcode := 180;
    vdi_control.num_ptsin := 0;
    vdi_control.num_intin := 1;
    vdi_control.subcode := 0;
    vdi_control.handle := handle;

    vdi_intin(0) := driver_id;
    
    vdi_trap;
    
    return Aes.Pdlg.DRV_INFO_ptr'Deref(vdi_intout(0)'Address);
end;

end Atari.Vdi.Nvdi;
