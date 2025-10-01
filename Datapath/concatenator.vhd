--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity concatenator is 
port ( 
		out0, out1, out2, out3, out4, out5, out6, out7 : in std_logic_vector(15 downto 0);
		ALLout : out std_logic_vector(127 downto 0)
	);
end concatenator;

architecture behavioral of concatenator is 
begin 
	process(out0, out1, out2, out3, out4, out5, out6, out7)
	begin 
		--inputing sequentially all outputs into a single vector
		ALLout(15 downto 0) <= out0;
		ALLout(31 downto 16) <= out1;
		ALLout(47 downto 32) <= out2;
		ALLout(63 downto 48) <= out3;
		ALLout(79 downto 64) <= out4;
		ALLout(95 downto 80) <= out5;
		ALLout(111 downto 96) <= out6;
		ALLout(127 downto 112) <= out7;
	end process;
end behavioral; 
