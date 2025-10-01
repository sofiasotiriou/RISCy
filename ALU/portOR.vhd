--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- OR gate
entity portOR is
    port(
        a, b : in std_logic;
        orResult : out std_logic
    );
end portOr;

architecture behavioral of portOR is
begin
    orResult <= a or b;
end behavioral;