--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- NOT gate
entity portNOT is
port(
    a : in std_logic;
    resultNot : out std_logic
);
end portNOT;

architecture behavioral of portNOT is
begin
    resultNot <= not(a);
end behavioral;