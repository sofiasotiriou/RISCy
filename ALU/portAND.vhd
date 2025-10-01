--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

--AND gate 
entity portAND is 
port(
	a, b : in std_logic;
	andResult : out std_logic);
end portAND;

architecture behavioral of portAND is 
begin 
	andResult <= a and b;
end behavioral;