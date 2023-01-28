pragma No_Strict_Aliasing;
with System.Machine_Code;
use System.Machine_Code;

package body Atari.Aes is

pragma Suppress (Range_Check);
pragma Suppress (Overflow_Check);
pragma Suppress (Access_Check);


aes_pb: aliased AESPB := (
    global => aes_global'Access,
    control => aes_control'Access,
    intin => aes_intin'Access,
    intout => aes_intout'Access,
    addrin => aes_addrin'Access,
    addrout => aes_addrout'Access
);


procedure crystal(pb: AESPB_ptr) is
    use ASCII;
begin
    asm("move.l %0,%%d1" & LF & HT &
        "move.w #200,%%d0" & LF & HT &
        "trap #2" & LF & HT,
        volatile => true,
        inputs => void_ptr'Asm_Input("g", pb.all'Address),
        clobber => "d0, d1, d2, a0, a1, a2, cc, memory"
    );
end;


procedure aes_trap is
begin
	crystal(aes_pb'Access);
end;


function max(a,b:int16) return int16 is
begin
	if a > b then
		return a;
	else
		return b;
	end if;
end;




function min(a,b:int16) return int16 is
begin
	if a < b then
		return a;
	else
		return b;
	end if;
end;


procedure rc_copy(src: in Rectangle; dst: out Rectangle) is
begin
	dst := src;
end;


function rc_equal(r1: in Rectangle; r2: in Rectangle) return boolean is
begin
	return r1.g_x = r2.g_x and then
	       r1.g_y = r2.g_y and then
	       r1.g_w = r2.g_w and then
	       r1.g_h = r2.g_h;
end;


function rc_intersect(src: in Rectangle; dst: in out Rectangle) return boolean is
	x,y,w,h:	int16;
begin
	x := max(dst.g_x, src.g_x);
	y := max(dst.g_y, src.g_y);
	w := min(dst.g_x + dst.g_w, src.g_x + src.g_w);
	h := min(dst.g_y + dst.g_h, src.g_y + src.g_h);
	dst.g_x := x;
	dst.g_y := y;
	dst.g_w := w - x;
	dst.g_h := h - y;
	if (w>x) and then (h>y) then
		return true;
	else
		return false;
	end if;
end;


procedure array_to_grect(c_array: short_array; area: out Rectangle) is
begin
	area.g_x := c_array(0);
	area.g_y := c_array(1);
	area.g_w := c_array(2) - c_array(0) + 1;
	area.g_h := c_array(3) - c_array(1) + 1;
end;


procedure grect_to_array(area: in Rectangle; c_array: out short_array) is
begin
	c_array(0) := area.g_x;
	c_array(1) := area.g_y;
	c_array(2) := area.g_x + area.g_w - 1;
	c_array(3) := area.g_y + area.g_h - 1;
end;


function vq_aes return int16 is
    ret: int16;
begin
	aes_global(0) := 0;
	--  Application.Init
	aes_control.opcode := 10;
	aes_control.num_intin := 0;
	aes_control.num_intout := 1;
	aes_control.num_addrin := 0;
	aes_control.num_addrout := 0;
	aes_trap;
	ret := aes_intout(0);
	if (aes_global(0) = 0) then
	   ret := -1;
	end if;
	return ret;
end;


function vq_aes return boolean is
begin
	return vq_aes >= 0;
end;


end Atari.Aes;
