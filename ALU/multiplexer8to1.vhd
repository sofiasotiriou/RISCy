--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

--asked as mux8to1 
entity multiplexer8to1 is 
	port ( 
			in1, in2, in3, in4, in5, in6, in7, in8 : in std_logic_vector(15 downto 0);
			opcode : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(15 downto 0)
    );
end multiplexer8to1;

architecture behavioral of multiplexer8to1 is 
	
begin
	process (in1, in2, in3, in4, in5, in6, in7, in8, opcode)
	begin 
		case opcode is 
			when "000" => output <= in1;
			when "001" => output <= in2;
			when "010" => output <= in3;
			when "011" => output <= in4;
			when "100" => output <= in5;
			when "101" => output <= in6;
			when "110" => output <= in7;
			when others => output <= in8;
		end case;
	end process;
end behavioral;