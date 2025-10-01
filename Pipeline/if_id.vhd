--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity if_id is 
	generic ( 
		n : integer := 16
	);
	port( 
		pcIn, inInstruction : in std_logic_vector (n-1 downto 0);
		clock, enable, flush : in std_logic;
		pcOut, outInstruction: out std_logic_vector (n-1 downto 0)
	);
end if_id;

architecture behavioral of if_id is
begin
	process(clock)
   begin
		if clock='1' and flush = '1' then
			pcOut <= (others => '0');
			outInstruction <= (others => '0');	
		elsif clock='1' and enable = '1' then
			if is_X(pcIn) then 
				pcOut <= "0000000000000010"; 
			else 
				pcOut <= std_logic_vector(unsigned(pcIn) + 2);
			end if;
			outInstruction <= inInstruction;	
		end if;
	end process;
end architecture behavioral;