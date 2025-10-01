--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity forwarder is 
	generic ( 
		addressSize : integer := 3
	);
	port ( 
		adr1, adr2, exmem, memwb : in std_logic_vector (addressSize-1 downto 0);
		out1, out2 : out std_logic_vector(1 downto 0)
	);
end forwarder; 

architecture behavior of forwarder is 
begin 
	process(adr1, adr2, exmem, memwb) 
	begin 
		if (adr1=exmem) then 
			out1 <= "10";
		elsif (adr1=memwb) then 
			out1 <= "01";
		else 
			out1 <= "00";
		end if; 
		
		if (adr2=exmem) then 
			out2 <= "10";
		elsif (adr2=memwb) then 
			out2 <= "01";
		else 
			out2 <= "00";
		end if;
	end process;
end behavior;