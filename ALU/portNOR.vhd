--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- NOR gate
entity portNOR is
port(
    a, b : in std_logic;
    resultNor : out std_logic
);
end;

architecture behavioral of portNOR is
begin
    resultNor <= not(a or b);
end behavioral;

