--
--	Copyright (c) 2022 Thorsten Otto
--
--	Simple, resizable and movable GEM Window
--	Example program for ADA Atari TOS bindings
--
--	This example program is in the Public Domain under the terms of
--	Unlicense: http://unlicense.org/
--

with Ada.Characters;
with Atari.Aes; use Atari.Aes;
with Atari.Vdi; use Atari.Vdi;
use Atari;
with Atari.Aes.Application;
with Atari.Aes.Menu;
with Atari.Aes.Graf;
with Interfaces; use Interfaces;

procedure gemwin is
	win_h: int16;
	fulled: boolean;
	win_name: aliased char_array := "ADA GEM Window" & ASCII.NUL;
	win_info: aliased char_array := "Move me and resize me..." & ASCII.NUL;
	menu_id: int16;
	vdi_h: int16;
    gl_wchar, gl_hchar: int16;
    gl_wbox, gl_hbox: int16;
    dummy: int16;
    menu_name: constant char_array := "  ADA Window" & ASCII.NUL;

	WIN_KIND : constant int16 := NAME or INFO or CLOSER or MOVER or SIZER or FULLER;

	function open_vwk return boolean is
		workin: vdi_workin_array;
		workout: vdi_workout_array;
	begin
	    vdi_h := Graf.Handle(gl_wchar, gl_hchar, gl_wbox, gl_hbox);

        for i in workin'Range loop
           workin(i) := 1;
        end loop;
        workin(10) := 2;
		v_opnvwk(workin, vdi_h, workout);
	
		return vdi_h > 0;
	end;

	procedure open_window is
		dim: GRECT;
		desk: GRECT;
	begin
        if win_h <= 0 then
        	dummy := wind_get(0, WF_WORKXYWH, desk);
			win_h := wind_create(WIN_KIND, desk);
            if win_h <= 0 then
                return;
            end if;
			dummy := wind_set(win_h, WF_NAME, win_name(win_name'First)'Unchecked_Access);
			dummy := wind_set(win_h, WF_INFO, win_info(win_info'First)'Unchecked_Access);
		
			dummy := wind_get(0, WF_WORKXYWH, dim);
		
			dim.g_x := dim.g_x + (dim.g_w / 20);
			dim.g_y := dim.g_y + (dim.g_h / 20);
			dim.g_w := dim.g_w - (dim.g_w / 20) * 2;
			dim.g_h := dim.g_h - (dim.g_h / 20) * 2;
		
			dummy := wind_open(win_h, dim);
        else
            dummy := wind_set(win_h, WF_TOP);
        end if;
	end;

	procedure close_window is
	begin
		if win_h > 0 then
	        dummy := wind_close(win_h);
	        dummy := wind_delete(win_h);
	        win_h := 0;
	    end if;
	end;

	procedure wind_redraw(wh: int16; rect: GRECT) is
		xyarray: short_array(0..3);
		wrect: GRECT;
	begin
		dummy := wind_update(BEG_UPDATE);
		v_hide_c(vdi_h);
	
		dummy := wind_get(wh, WF_FIRSTXYWH, wrect);
        loop
            exit when wrect.g_w <= 0 or else wrect.g_h <= 0;
			if rc_intersect(rect, wrect) then
				xyarray(0) := wrect.g_x;
				xyarray(1) := wrect.g_y;
				xyarray(2) := wrect.g_x + wrect.g_w - 1;
				xyarray(3) := wrect.g_y + wrect.g_h - 1;
				vs_clip(vdi_h, 1, xyarray);

				dummy := vsf_color(vdi_h, G_WHITE);
				v_bar(vdi_h, xyarray);
			end if;
			dummy := wind_get(wh, WF_NEXTXYWH, wrect);
		end loop;
	
		v_show_c(vdi_h);
		dummy := wind_update(END_UPDATE);
	end;

	procedure event_loop is
		msg_buf: Message_Buffer;
		fsrect: GRECT;
	begin
		loop
			dummy := evnt_mesag(msg_buf);
			case msg_buf.simple.msgtype is
				when WM_CLOSED =>
	                if msg_buf.simple.handle = win_h then
	                	close_window;
	                end if;
	                if Application.is_Application then
						exit;
					end if;
	            when AP_TERM =>
	            	close_window;
	            	exit;
				when WM_REDRAW =>
	                if msg_buf.simple.handle = win_h then
						wind_redraw(win_h, msg_buf.rect.rect);
					end if;
				when WM_MOVED | WM_SIZED =>
	                if msg_buf.simple.handle = win_h then
						dummy := wind_set(win_h, WF_CURRXYWH, msg_buf.rect.rect);
						fulled := false;
					end if;
				when WM_FULLED =>
	                if msg_buf.simple.handle = win_h then
						if fulled then
							dummy := wind_get(win_h, WF_PREVXYWH, fsrect);
							dummy := wind_set(win_h, WF_CURRXYWH, fsrect);
							fulled := false;
						else
							dummy := wind_get(win_h, WF_CURRXYWH, fsrect);
							dummy := wind_set(win_h, WF_PREVXYWH, fsrect);
							dummy := wind_get(win_h, WF_FULLXYWH, fsrect);
							dummy := wind_set(win_h, WF_CURRXYWH, fsrect);
							fulled := true;
						end if;
					end if;
				when WM_TOPPED | WM_NEWTOP =>
	                if msg_buf.simple.handle = win_h then
						dummy := wind_set(win_h, WF_TOP);
					end if;
	            when AC_OPEN =>
	                if msg_buf.simple.menu_id = menu_id then
	                    open_window;
	                end if;
	            when AC_CLOSE =>
	            	-- no close_window here.
	            	-- when we get this message, window was already deleted by AES
	                win_h := 0;
	            when others =>
	                null;
			end case;
		end loop;
	end;

begin
    if Application.Init /= -1 then
		if open_vwk then
            if not Application.Is_Application then
                menu_id := Menu.Register(Application.Id, menu_name(menu_name'First)'Unchecked_Access);
            else
                Graf.Mouse(ARROW);
                open_window;
            end if;
			event_loop;

			v_clsvwk(vdi_h);
		end if;
		Application.AExit;
	end if;
end gemwin;
