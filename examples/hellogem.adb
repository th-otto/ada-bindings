with Ada.Characters;
with Atari.Aes; use Atari.Aes;
use Atari;


procedure hellogem is
    dummy: int16;

begin
    dummy := appl_init;
    dummy := form_alert(1, "[1][Hello from GemAES Ada][OK]");
    appl_exit;
end hellogem;
