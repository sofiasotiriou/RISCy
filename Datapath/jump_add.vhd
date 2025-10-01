--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity jump_add is
    port ( 
			jumpAD: in std_logic_vector(11 downto 0);
			instrP2AD : in std_logic_vector(15 downto 0);
			EjumpAD : out std_logic_vector(15 downto 0)
    );
end jump_add;

architecture behavioral of jump_add is
	signal almostExtendedJump, shiftedExtendedJump : std_logic_vector(15 downto 0);
begin
	process(jumpAD, instrP2AD) 
	begin 
		if jumpAD(11) = '1' then 
			almostExtendedJump <= "1111" & jumpAD;
		else 
			almostExtendedJump <= "0000" & jumpAD;
		end if;
		--shift left to do the multiplication by 2
		shiftedExtendedJump <= almostExtendedJump(14 downto 0) & '0';
		EjumpAD <= shiftedExtendedJump + instrP2AD;
	
	end process;
end behavioral;