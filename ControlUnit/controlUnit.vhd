--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity controlUnit is
	port (
		opcode : in std_logic_vector (3 downto 0);
		func : in std_logic_vector (2 downto 0);
		flush : in std_logic; 
		isBranch, isJReg, isJtype, isLoad, isMFPC, isRtype, isRead, isStore, isWrite : out std_logic
	);
end controlUnit;
	
architecture behavior of controlUnit is 
begin  
	process(opcode, func, flush) 
	begin 
		isBranch <= '0';
		isJReg <= '0';
		isJtype <= '0';
		isLoad <= '0';
		isMFPC <= '0';
		isRtype <= '0';
		isRead <= '0';
		isStore <= '0';
		isWrite <= '0';
		
		if flush='0' then
			case opcode is 
				when "0000" => 
					isRtype <= '1';
					if func="111" then 
						isMFPC <= '1';
					end if;
					
				when "1111" => 
					isJtype <= '1';
				when "0110" =>
					isRead <= '1';
				when "0111" => 
					isWrite <= '1';
				when "0001" => 
					isLoad <= '1';
				when "0010" => 
					isStore <= '1';
				when "1101" => 
					isJReg <= '1';
				when "0100" => 
					isBranch <= '1';
				when others =>
					null;
			end case; 
		end if; 
	end process; 
end behavior;				