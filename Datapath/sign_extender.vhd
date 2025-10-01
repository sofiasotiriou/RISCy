--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity sign_extender is
	generic(
        n: integer := 16;
        m: integer := 6
    );
    port ( 
        input : in std_logic_vector(m-1 downto 0);
        output : out std_logic_vector(n-1 downto 0)
    );
end sign_extender;

architecture behavioral of sign_extender is
begin
	output <= (n-1 downto m => input(m-1)) & (input);
end behavioral;