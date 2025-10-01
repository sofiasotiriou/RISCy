--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity selector is 
	generic ( 
		n : integer := 16
	);
	port ( 
		op : in std_logic_vector(1 downto 0);
		regFile, mem, wb : in std_logic_vector (n-1 downto 0);
		output : out std_logic_vector(n-1 downto 0)
	);
end selector; 

architecture behavior of selector is 
begin 
	process(op) 
	begin 
		if (op="10") then 
			output <= mem;
		elsif (op="01") then 
			output <= wb;
		elsif (op="00") then
			output <= regFile;
		else 
			output <= (others => '0');
		end if; 
	end process;
end behavior;