--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- XOR gate
entity portXOR is
port(
    a, b : in std_logic;
    resultXor : out std_logic
);
end portXOR;

architecture behavioral of portXOR is
begin
    resultXor <= (a and not(b)) or (not(a) and b);
end behavioral;