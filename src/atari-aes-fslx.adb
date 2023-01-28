pragma No_Strict_Aliasing;
with System;
with Ada.Unchecked_Conversion;

package body Atari.Aes.Fslx is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);



procedure strcpy(dst: void_ptr; src: void_ptr)
    with Import => True,
         Convention => C,
         External_Name => "strcpy";


procedure stripnull(str: in out String) is
begin
	if str'Last > 0 and then str(str'Last) = Character'First then
		str := str(str'First .. str'Last - 1);
	end if;
end;


function convert_string_array(Strings: in String_Array) return void_ptr is
	Pragma Unreferenced(Strings);
begin
	--  TODO
	return System.null_address;
end;


function fslx_open(
            title    : in String;
            x        : int16;
            y        : int16;
            handle   : out int16;
            path     : in out String;
            pathlen  : int16;
            fname    : in out String;
            fnamelen : int16;
            patterns : in String_Array;
            filter   : XFSL_FILTER;
            paths    : in String_Array;
            sort_mode: int16;
            flags    : int16)
           return XFSL_DIALOG_ptr is
    c_title: String := title & ASCII.NUL;
    c_path: String(1..Integer(pathlen)) := path & ASCII.NUL;
    c_fname: String(1..Integer(fnamelen)) := fname & ASCII.NUL;
begin
	aes_control.opcode := 190;
	aes_control.num_intin := 6;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 6;
	aes_control.num_addrout := 1;
	aes_intin(0) := x;
	aes_intin(1) := y;
	aes_intin(2) := pathlen;
	aes_intin(3) := fnamelen;
	aes_intin(4) := sort_mode;
	aes_intin(5) := flags;
	if c_title'Length = 0 then
		aes_addrin(0) := System.null_address;
	else
		aes_addrin(0) := c_title'Address;
	end if;
	aes_addrin(1) := c_path(c_path'First)'Address;
	aes_addrin(2) := c_fname(c_fname'First)'Address;
	aes_addrin(3) := convert_string_array(patterns);
	if filter = null then
		aes_addrin(4) := System.null_address;
	else
		aes_addrin(4) := filter.all'Address;
	end if;
	if paths'Length = 0 then
		aes_addrin(5) := System.Null_Address;
	else
		aes_addrin(5) := convert_string_array(patterns);
	end if;
	aes_trap;
	stripnull(c_path);
	path := c_path;
	stripnull(c_fname);
	fname := c_fname;
	handle := aes_intout(0);
	return XFSL_DIALOG_ptr'Deref(aes_addrout(0)'Address);
end;


function fslx_close(fsd: XFSL_DIALOG_ptr; x, y: out int16) return int16 is
begin
	aes_control.opcode := 191;
	aes_control.num_intin := 0;
	aes_control.num_intout := 3;
	aes_control.num_addrin := 1;
	aes_control.num_addrout := 0;
	aes_addrin(0) := fsd.all'Address;
	aes_trap;
	x := aes_intout(1);
	y := aes_intout(2);
	return aes_intout(0);
end;


function fslx_getnxtfile(fsd: XFSL_DIALOG_ptr; fname: out String) return boolean is
	c_fname: String(1..256);
begin
	aes_control.opcode := 192;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 0;
	aes_addrin(0) := fsd.all'Address;
	aes_addrin(1) := c_fname(c_fname'First)'Address;
	aes_trap;
	stripnull(c_fname);
	fname := c_fname;
	return aes_intout(0) /= 0;
end;


function fslx_evnt(
            fsd      : XFSL_DIALOG_ptr;
            events   : Wdialog.EVNT_ptr;
            path     : in out String;
            fname    : in out String;
            button   : out int16;
            nfiles   : out int16;
            sort_mode: out int16;
            pattern  : out String)
           return boolean is
	c_path: String(1..256) := path & ASCII.NUL;
	c_fname: String(1..256) := fname & ASCII.NUL;
	c_pattern: String(1..256);
begin
	aes_control.opcode := 193;
	aes_control.num_intin := 0;
	aes_control.num_intout := 4;
	aes_control.num_addrin := 2;
	aes_control.num_addrout := 1;
	aes_addrin(0) := fsd.all'Address;
	aes_addrin(1) := events.all'Address;
	aes_addrin(2) := c_path(c_path'First)'Address;
	aes_addrin(3) := c_fname(c_fname'First)'Address;
	aes_trap;
	stripnull(c_path);
	path := c_path;
	stripnull(c_fname);
	fname := c_fname;
	button := aes_intout(1);
	nfiles := aes_intout(2);
	sort_mode := aes_intout(3);
	strcpy(c_pattern(c_pattern'First)'Address, aes_addrout(0));
	stripnull(c_pattern);
	pattern := c_pattern;
	return aes_intout(0) /= 0;
end;


function fslx_do(
            title    : in String;
            path     : in out String;
            pathlen  : int16;
            fname    : in out String;
            fnamelen : int16;
            patterns : in String_Array;
            filter   : XFSL_FILTER;
            paths    : in String_Array;
            sort_mode: in out int16;
            flags    : int16;
            button   : out int16;
            nfiles   : out int16;
            pattern  : out String)
           return XFSL_DIALOG_ptr is
    c_title: String := title & ASCII.NUL;
    c_path: String(1..Integer(pathlen)) := path & ASCII.NUL;
    c_fname: String(1..Integer(fnamelen)) := fname & ASCII.NUL;
	c_pattern: String(1..256);
begin
	aes_control.opcode := 194;
	aes_control.num_intin := 4;
	aes_control.num_intout := 4;
	aes_control.num_addrin := 6;
	aes_control.num_addrout := 2;
	aes_intin(0) := pathlen;
	aes_intin(1) := fnamelen;
	aes_intin(2) := sort_mode;
	aes_intin(3) := flags;
	if c_title'Length = 0 then
		aes_addrin(0) := System.null_address;
	else
		aes_addrin(0) := c_title'Address;
	end if;
	aes_addrin(1) := c_path(c_path'First)'Address;
	aes_addrin(2) := c_fname(c_fname'First)'Address;
	aes_addrin(3) := convert_string_array(patterns);
	if filter = null then
		aes_addrin(4) := System.null_address;
	else
		aes_addrin(4) := filter.all'Address;
	end if;
	if paths'Length = 0 then
		aes_addrin(5) := System.Null_Address;
	else
		aes_addrin(5) := convert_string_array(patterns);
	end if;
	aes_trap;
	stripnull(c_path);
	path := c_path;
	stripnull(c_fname);
	fname := c_fname;
	button := aes_intout(1);
	nfiles := aes_intout(2);
	sort_mode := aes_intout(3);
	strcpy(c_pattern(c_pattern'First)'Address, aes_addrout(1));
	stripnull(c_pattern);
	pattern := c_pattern;
	return XFSL_DIALOG_ptr'Deref(aes_addrout(0)'Address);
end;


function fslx_set_flags(
            flags : int16;
            oldval: out int16)
           return boolean is
begin
	aes_control.opcode := 195;
	aes_control.num_intin := 2;
	aes_control.num_intout := 2;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_intin(0) := 0;
	aes_intin(1) := flags;
	aes_trap;
	oldval := aes_intout(1);
	return aes_intout(0) /= 0;
end;


end Atari.Aes.Fslx;
