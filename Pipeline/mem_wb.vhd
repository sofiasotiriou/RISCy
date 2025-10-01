--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity mem_wb is 
	generic (
		n: INTEGER := 16;
		addressSize : INTEGER := 3
	);
	port (
		clock : in std_logic;
		result : in std_logic_vector (n-1 downto 0);
		regAddr : in std_logic_vector (addressSize-1 downto 0);
		
		writeData : out std_logic_vector (n-1 downto 0);
		writeAddr : out std_logic_vector (addressSize-1 downto 0)
	); 
end mem_wb;

architecture behavior of mem_wb is 
begin 
	process(clock)
	begin 
		if clock='1' then 
			writeData <= result;
			writeAddr <= regAddr;
		end if; 
	end process; 
end behavior;