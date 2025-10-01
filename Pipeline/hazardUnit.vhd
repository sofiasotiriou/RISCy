--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity hazardUnit is 
	port ( 
		jr, isJump, wasJump, mustBranch : in std_logic;
		flush, wasJumpOut : out std_logic;
		opcodeJR : out std_logic_vector(1 downto 0)
	);
end hazardUnit;

architecture behavior of hazardUnit is 
begin 
   process(jr, isJump, wasJump, mustBranch)
	begin
		flush <='0';
		opcodeJR <="00";
		if jr = '1' or isJump = '1' or wasJump = '1' or mustBranch = '1' then
			flush <= '1';
		end if;
		if isJump = '1' then
         opcodeJR <= "01";
      elsif mustBranch = '1' then
         opcodeJR <= "10";
      end if;
	end process;
   wasJumpOut <= isJump;
end behavior;