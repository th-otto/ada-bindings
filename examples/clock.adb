--
--  Copyright (c) 2022 Thorsten Otto
--
--  Simple, resizable and movable GEM Window, drawing an analog Clock
--  Example program for ADA Atari TOS bindings
--
--  This example program is in the Public Domain under the terms of
--  Unlicense: http://unlicense.org/
--

with Ada.Characters;
with Atari.Aes; use Atari.Aes;
with Atari.Vdi; use Atari.Vdi;
with Atari.Gemdos;
use Atari;
with Atari.Aes.Menu;
with Atari.Aes.Graf;
with Interfaces; use Interfaces;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Text_IO;

Pragma Unreferenced(Text_IO);


procedure clock is

pragma Suppress (Overflow_Check);

    type draw_what is (DRAW_ALL, DRAW_TIME);
    PARTS: constant int16 := NAME or CLOSER or MOVER or SIZER;
    phys_handle: VdiHdl;
    whandle: int16;
    vdi_handle: aliased VdiHdl;
    gl_wchar, gl_hchar: int16;
    gl_wbox, gl_hbox: int16;
    max_x, max_y: int16;
    menu_id: int16;
    title: constant char_array := " ADA Clock " & ASCII.NUL;
    menu_name: constant char_array := "  ADA Clock" & ASCII.NUL;
    wx, wy: aliased int16;
    oldhour, oldminute, oldsecond: int16;

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
        vdi_handle := phys_handle;
        v_opnvwk(workin, vdi_handle, workout);
        max_x := workout(0);
        max_y := workout(1);
        return vdi_handle > 0;
    end;

    procedure close_vwork is
    begin
        v_clsvwk(vdi_handle);
    end;

    procedure open_window is
        calc: GRECT;
        desk: GRECT;
    begin
        if whandle <= 0 then
            dummy := wind_get(0, WF_WORKXYWH, desk);
            whandle := wind_create(PARTS, desk);
            if whandle<=0 then
                return;
            end if;
            dummy := wind_set(whandle, WF_NAME, title(title'First)'Unchecked_Access);
            if wx = -1 then
                wind_calc(WC_BORDER, PARTS, 100, 100, 170, 170,
                    calc.g_x, calc.g_y, calc.g_w, calc.g_h);
                wx := (max_x - calc.g_w) / 2;
                wy := 16 + (max_y - calc.g_h) / 2;
            end if;
            dummy := wind_open(whandle, wx, wy, 170, 170);
        else
            dummy := wind_set(whandle, WF_TOP);
        end if;
    end;

    procedure close_window is
    begin
        if whandle > 0
        then
            dummy := wind_close(whandle);
            dummy := wind_delete(whandle);
            whandle := 0;
        end if;
    end;

    procedure redrawwindow(what: draw_what) is
        hour, minute, second: int16;
        hourdiff, mindiff, secdiff: int16;
        work: GRECT;
        box: GRECT;
        clip: short_array(0..3);
        x, y: int16;

        procedure gettime is
            time: uint16;
        begin
            time := Gemdos.Tgettime;
            hour := int16(Shift_Right(time, 11)) and 31;
            if hour >= 12 then
                hour := hour - 12;
            end if;
            minute := int16(Shift_Right(time, 5)) and 63;
            second := int16(Shift_Left(time and 31, 1));
        end;

        procedure calcpoint(w, h: int16; i: int16; x, y: out int16; s: int16) is
        begin
            x := (w / 2) + int16(Float'Truncation(float(w / 2 - 10 - s) * sin(2.0 * float(i) * PI / 60.0)));
            y := (h / 2) + int16(Float'Truncation(float(h / 2 - 10 - s) * cos(PI + 2.0 * float(i) * PI / 60.0)));
        end;

        procedure showtime is
            x, y: int16;
            xyarray: short_array(0..3);
        begin
            dummy := vsl_color(vdi_handle, G_WHITE);
            xyarray(0) := work.g_x + work.g_w / 2;
            xyarray(1) := work.g_y + work.g_h / 2;

            calcpoint(work.g_w, work.g_h, oldsecond, x, y, secdiff);
            xyarray(2) := work.g_x + x;
            xyarray(3) := work.g_y + y;
            dummy := vsl_width(vdi_handle, 1);
            v_pline(vdi_handle, 2, xyarray);

            if (minute /= oldminute)
            then
                calcpoint(work.g_w, work.g_h, oldminute, x, y, mindiff);
                xyarray(2) := work.g_x + x;
                xyarray(3) := work.g_y + y;
                dummy := vsl_width(vdi_handle, 3);
                v_pline(vdi_handle, 2, xyarray);
            end if;

            if (minute /= oldminute or else (minute mod 12) = 0 or else hour /= oldhour)
            then
                calcpoint(work.g_w, work.g_h, oldhour * 5 + oldminute / 12, x, y, hourdiff);
                xyarray(2) := work.g_x + x;
                xyarray(3) := work.g_y + y;
                dummy := vsl_width(vdi_handle, 5);
                v_pline(vdi_handle, 2, xyarray);
            end if;

            dummy := vsl_color(vdi_handle, G_BLACK);

            calcpoint(work.g_w, work.g_h, second, x, y, secdiff);
            xyarray(2) := work.g_x + x;
            xyarray(3) := work.g_y + y;
            dummy := vsl_width(vdi_handle, 1);
            v_pline(vdi_handle, 2, xyarray);

            calcpoint(work.g_w, work.g_h, minute, x, y, mindiff);
            xyarray(2) := work.g_x + x;
            xyarray(3) := work.g_y + y;
            dummy := vsl_width(vdi_handle, 3);
            v_pline(vdi_handle, 2, xyarray);

            calcpoint(work.g_w, work.g_h, hour * 5 + minute / 12, x, y, hourdiff);
            xyarray(2) := work.g_x + x;
            xyarray(3) := work.g_y + y;
            dummy := vsl_width(vdi_handle, 5);
            v_pline(vdi_handle, 2, xyarray);
        end;

    begin
        if whandle <= 0 then
            return;
        end if;
        mouse_off;
        dummy := vswr_mode(vdi_handle, MD_REPLACE);
        dummy := wind_get(whandle, WF_WORKXYWH, work);

        secdiff := work.g_w;
        if work.g_h < work.g_w then
            secdiff := work.g_h;
        end if;
        secdiff := secdiff / 2;
        mindiff := secdiff / 5;
        hourdiff := secdiff / 3;
        secdiff := secdiff / 6;
        gettime;
        if oldsecond = second then
            second := second + 1;
        end if;

        dummy := wind_get(whandle, WF_FIRSTXYWH, box);
        loop
            exit when box.g_w <= 0 or else box.g_h <= 0;
            grect_to_array(box, clip);
            dummy := wind_get(whandle, WF_NEXTXYWH, box);
            vs_clip(vdi_handle, 1, clip);
            case what is
            when DRAW_ALL =>
                dummy := vsf_color(vdi_handle, G_WHITE);
                dummy := vsf_perimeter(vdi_handle, 0);
                dummy := vsf_interior(vdi_handle, FIS_SOLID);
                vr_recfl(vdi_handle, clip);
                dummy := vsf_color(vdi_handle, G_BLACK);
                dummy := vsf_perimeter(vdi_handle, 1);
                for i in 0..11 loop
                    calcpoint(work.g_w, work.g_h, int16(i) * 5, x, y, 0);
                    v_circle(vdi_handle, work.g_x + x, work.g_y + y, 2);
                end loop;
                showtime;
            when DRAW_TIME =>
                showtime;
            end case;
            dummy := wind_get(whandle, WF_NEXTXYWH, box);
        end loop;
        oldsecond := second;
        oldminute := minute;
        oldhour := hour;
        mouse_on;
    end;

    function handle_message(msg: in out Message_Buffer) return boolean is
        dummy2: int16;
    begin
        -- Text_IO.Put_Line("got message " & msg.simple.msgtype'image);
        case msg.simple.msgtype is
            when WM_REDRAW =>
                redrawwindow(DRAW_ALL);
            when WM_TOPPED =>
                if msg.simple.handle = whandle then
                    dummy := wind_set(whandle, WF_TOP);
                end if;
            when WM_CLOSED =>
                if msg.simple.handle = whandle then
                    dummy := wind_get(whandle, WF_CURRXYWH, wx, wy, dummy, dummy2);
                    close_window;
                end if;
                if is_Application then
                    return true;
                end if;
            when AP_TERM =>
                close_window;
                return true;
            when WM_MOVED =>
                if msg.simple.handle = whandle then
                    dummy := wind_set(whandle, WF_CURRXYWH, msg.rect.rect);
                    redrawwindow(DRAW_ALL);
                end if;
            when WM_SIZED =>
                if msg.simple.handle = whandle then
                    if msg.rect.rect.g_w < 100 then
                        msg.rect.rect.g_w := 100;
                    end if;
                    if msg.rect.rect.g_h < 100 then
                        msg.rect.rect.g_h := 100;
                    end if;
                    dummy := wind_set(whandle, WF_CURRXYWH, msg.rect.rect);
                    dummy := wind_get(whandle, WF_WORKXYWH, msg.rect.rect);
                    msg.simple.msgtype := WM_REDRAW;
                    msg.simple.from := gl_apid;
                    msg.simple.size := 0;
                    dummy := appl_write(gl_apid, msg);
                end if;
            when AC_OPEN =>
                if msg.simple.menu_id = menu_id then
                    open_window;
                end if;
            when AC_CLOSE =>
                whandle := 0;
            when others =>
                null;
        end case;
        return false;
    end;

    procedure event_loop is
        x, y, key, clicks: int16;
        kstate, state: int16;
        event: int16;
        quit: boolean;
        msg: Message_Buffer;
        events: int16;
    begin
        quit := false;

        loop
            if whandle > 0 then
                events := MU_MESAG or MU_TIMER;
            else
                events := MU_MESAG;
            end if;
            event := evnt_multi(events, 258, 3, 0,
                0, 0, 0, 0, 0,
                0, 0, 0, 0, 0,
                msg,
                1000,
                x, y, state, kstate, key, clicks);
            dummy := wind_update(BEG_UPDATE);
            if (event and MU_MESAG) /= 0 then
                quit := handle_message(msg);
            end if;
            if (event and MU_TIMER) /= 0 then
                redrawwindow(DRAW_TIME);
            end if;
            dummy := wind_update(END_UPDATE);
            exit when quit;
        end loop;
    end;

begin
    if appl_init /= -1 then
        if open_vwork then
            wx := -1;
            if not Is_Application then
                menu_id := Menu.Register(gl_apid, menu_name(menu_name'First)'Unchecked_Access);
            else
                Graf.Mouse(ARROW);
                open_window;
            end if;
            event_loop;
            close_vwork;
        end if;
        appl_exit;
    end if;

end clock;
