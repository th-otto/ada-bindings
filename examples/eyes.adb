--
--	Copyright (c) 2022 Thorsten Otto
--
--	Simple Eyes clone
--	Example program for ADA Atari TOS bindings
--
--	This example program is in the Public Domain under the terms of
--	Unlicense: http://unlicense.org/
--

with Ada.Characters;
with Atari.Aes; use Atari.Aes;
with Atari.Aes.Application;
with Atari.Aes.Menu;
with Atari.Aes.Graf;
with Atari.Aes.Event;
with Atari.Aes.Window;
with Atari.Vdi; use Atari.Vdi;
use Atari;
with Interfaces; use Interfaces;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Text_IO;

Pragma Unreferenced(Text_IO);


procedure eyes is
    use ASCII;
    type draw_what is (DRAW_ALL, EYES);
    PARTS: constant int16 := Window.NAME or Window.CLOSER or Window.MOVER;

    phys_handle: VdiHdl;
    whandle: int16;
    handle: aliased VdiHdl;
    gl_wchar, gl_hchar: int16;
    gl_wbox, gl_hbox: int16;
    max_x, max_y: int16;
    menu_id: int16;
    title: constant char_array := " ADA Eyes " & ASCII.NUL;
    menu_name: constant char_array := "  ADA Eyes" & ASCII.NUL;
    oldx, oldy: int16;
    wx, wy: aliased int16;
    
    dummy: aliased int16;

    procedure mouse_on is
    begin
        Graf.Mouse(M_ON);
    end;

    procedure mouse_off is
    begin
        Graf.Mouse(M_OFF);
    end;

    function open_vwork return boolean is
        workin: vdi_workin_array;
        workout: vdi_workout_array;
    begin
        for i in workin'Range loop
           workin(i) := 1;
        end loop;
        workin(10) := 2;
        phys_handle := Graf.Handle(gl_wchar, gl_hchar, gl_wbox, gl_hbox);
        handle := phys_handle;
        v_opnvwk(workin, handle, workout);
        max_x := workout(0);
        max_y := workout(1);
        return handle > 0;
    end;

    procedure close_vwork is
    begin
        v_clsvwk(handle);
    end;

    procedure setfillparams(color, perimeter, interior: int16) is
    begin
        dummy := vsf_color(handle, color);
        dummy := vsf_perimeter(handle, perimeter);
        dummy := vsf_interior(handle, interior);
    end;
    
    procedure redrawwindow(what: draw_what; pmx, pmy: int16) is
        box, work: GRECT;
        clip: short_array(0..3);
        xx, yy, zz, f, ff: float;

        procedure pupil(mx, my, x, y: int16) is
        begin
            xx := float(mx - (work.g_x + x));
            yy := float(my - (work.g_y + y));
            zz := sqrt(xx * xx + yy * yy);
            if zz /= 0.0 then
                f := 9.0 * xx / zz;
                ff := 19.0 * yy / zz;
            else
                f := 0.0;
                ff := 0.0;
            end if;
            v_circle(handle, work.g_x + x + int16(Float'Truncation(f)), work.g_y + y + int16(Float'Truncation(ff)), 10);
        end;

    begin
        if whandle <= 0 then
            return;
        end if;
        dummy := Window.Get(whandle, Window.WF_WORKXYWH, work);
        dummy := Window.Get(whandle, Window.WF_FIRSTXYWH, box);
        loop
            exit when box.g_w <= 0 or else box.g_h <= 0;
            if rc_intersect(work, box) then
                clip(0) := box.g_x;
                clip(1) := box.g_y;
                clip(2) := box.g_x + box.g_w - 1;
                clip(3) := box.g_y + box.g_h - 1;
                vs_clip(handle, 1, clip);
                if what = DRAW_ALL then
                    mouse_off;
                    setfillparams(G_WHITE, 0, FIS_SOLID);
                    vr_recfl(handle, clip);
                    setfillparams(G_BLACK, 1, FIS_HOLLOW);
                    v_ellipse(handle, work.g_x + 25, work.g_y + 40, 20, 35);        
                    v_ellipse(handle, work.g_x + work.g_w - 25, work.g_y + 40, 20, 35);
                    mouse_on;
                end if;
                if ((what = DRAW_ALL) or else (oldx /= pmx) or else (oldy /= pmy)) then
                    mouse_off;
                    if what = EYES then
                        setfillparams(G_WHITE, 0, FIS_SOLID);
                        pupil(oldx, oldy, 25, 40);
                        pupil(oldx, oldy, work.g_w - 25, 40);
                        oldx := pmx;
                        oldy := pmy;
                    end if;
                    setfillparams(G_BLACK, 0, FIS_SOLID);
                    pupil(oldx, oldy, 25, 40);
                    pupil(oldx, oldy, work.g_w - 25, 40);
                    mouse_on;
                end if;
            end if;
            dummy := Window.Get(whandle, Window.WF_NEXTXYWH, box);
        end loop;
    end;

    procedure open_window is
        calc: GRECT;
        button, kstate: int16;
		desk: GRECT;
    begin
        if whandle <= 0 then
        	dummy := Window.Get(Window.DESK, Window.WF_WORKXYWH, desk);
            whandle := Window.Create(PARTS, desk);
            if whandle<=0 then
                return;
            end if;
            dummy := Window.Set(whandle, Window.WF_NAME, title(title'First)'Unchecked_Access);
            mouse_off;
            if wx = -1 then
                Window.Calc(Window.WC_BORDER, PARTS, 100, 100, 100, 100,
                    calc.g_x, calc.g_y, calc.g_w, calc.g_h);
                wx := (max_x - calc.g_w) / 2;
                wy := 16 + (max_y - calc.g_h) / 2;
            end if;
            dummy := Window.Open(whandle, wx, wy, 100, 100);
            mouse_on;
            Graf.Mkstate(oldx, oldy, button, kstate);
        else
            dummy := Window.Set(whandle, Window.WF_TOP);
        end if;
    end;

	procedure close_window is
	begin
		if whandle > 0
		then
			dummy := Window.Close(whandle);
			dummy := Window.Delete(whandle);
			whandle := 0;
		end if;
	end;

    function handle_message(pipe: Event.Message_Buffer) return boolean is
        dummy2: int16;
    begin
        -- Text_IO.Put_Line("got message " & pipe.simple.msgtype'image);
        case pipe.simple.msgtype is
            when Event.WM_REDRAW =>
                redrawwindow(DRAW_ALL, -1, -1);
            when Event.WM_TOPPED =>
                if pipe.simple.handle = whandle then
                    dummy := Window.Set(whandle, Window.WF_TOP);
                end if;
            when Event.WM_CLOSED =>
                if pipe.simple.handle = whandle then
                    dummy := Window.Get(whandle, Window.WF_CURRXYWH, wx, wy, dummy, dummy2);
                    close_window;
                end if;
                if Application.is_Application then
                    return true;
                end if;
            when Event.AP_TERM =>
            	close_window;
            	return true;
            when Event.WM_MOVED =>
                if pipe.simple.handle = whandle then
                    dummy := Window.Set(whandle, Window.WF_CURRXYWH, pipe.rect.rect);
                    redrawwindow(DRAW_ALL, -1, -1);
                end if;
            when Event.AC_OPEN =>
                if pipe.simple.menu_id = menu_id then
                    open_window;
                end if;
            when Event.AC_CLOSE =>
                whandle := 0;
            when others =>
                null;
        end case;
        return false;
    end;

    function event_loop return boolean is
        x, y, key, clicks: int16;
        kstate, state: int16;
        quit: boolean;
        pipe: Event.Message_Buffer;
        events: int16;
    begin
        quit := false;
        
        loop
            if whandle > 0 then
                events := Event.MU_MESAG or Event.MU_M1;
            else
                events := Event.MU_MESAG;
            end if;
            events := Event.Multi(events, 0, 0, 0,
                1, oldx, oldy, 1, 1,
                0, 0, 0, 0, 0,
                pipe,
                100,
                x, y, state, kstate, key, clicks);
            dummy := Window.Update(Window.BEG_UPDATE);
            if (events and Event.MU_MESAG) /= 0 then
                quit := handle_message(pipe);
            end if;
            if (events and Event.MU_M1) /= 0 then
                redrawwindow(EYES, x, y);
            end if;
            dummy := Window.Update(Window.END_UPDATE);
            exit when quit;
        end loop;
        return quit;
    end;


begin
    if Application.Init /= -1 then
        if open_vwork then
            dummy := vswr_mode(handle, MD_REPLACE);
            wx := -1;
            oldx := -1;
            oldy := -1;
            if not Application.Is_Application then
                menu_id := Menu.Register(Application.Id, menu_name(menu_name'First)'Unchecked_Access);
            else
                Graf.Mouse(ARROW);
                open_window;
            end if;
            loop
                exit when event_loop;
            end loop;
            close_vwork;
        end if;
        Application.AExit;
    end if;
end eyes;
