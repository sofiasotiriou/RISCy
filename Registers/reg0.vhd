--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity reg0 is 
	generic(
        n: integer := 16
    );
	port ( 
			input : in std_logic_vector(n-1 downto 0);
			clock, enable : in std_logic;
			output : out std_logic_vector(n-1 downto 0)
    );
end reg0;

architecture behavioral of reg0 is 
	
begin
	output <= (others => '0');
end behavioral;