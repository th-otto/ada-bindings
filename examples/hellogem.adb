--
--	Copyright (c) 2022 Thorsten Otto
--
--	Simple hello world, using GEM.
--	Example program for ADA Atari TOS bindings
--
--	This example program is in the Public Domain under the terms of
--	Unlicense: http://unlicense.org/
--

with Ada.Characters;
with Atari.Aes; use Atari.Aes;
with Atari.Aes.Form;
use Atari;


procedure hellogem is
    dummy: int16;

begin
    dummy := appl_init;
    dummy := Form.Alert(1, "[1][Hello from GemAES Ada][OK]");
    appl_exit;
end hellogem;
