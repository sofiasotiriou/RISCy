--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity trapUnit is 
	port (
		opcode : in std_logic_vector (3 downto 0);
		eor : out std_logic
	);
end trapUnit;

architecture behavior of trapUnit is 
begin 
	process(opcode) 
	begin 
		if opcode="1110" then 
			eor <= '1';
		else 
			eor <= '0';
		end if; 
	end process;
end behavior; 