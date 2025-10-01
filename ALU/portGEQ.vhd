--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- GEQ operation
entity portGEQ is
port(
    carryIn : in std_logic;
    resultGeq, carryOut : out std_logic
);
end portGEQ;

architecture behavioral of portGEQ is
begin
	--The first one will take the value of not MSB, while the rest will be 0 
    resultGeq <=  carryIn;
    carryOut <= '0';
end behavioral;