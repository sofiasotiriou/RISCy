--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;


entity latch1 is
    port ( 
        input, clock, enable : in std_logic;
        output : out std_logic
    );
end latch1;

architecture behavioral of latch1 is
begin
	process (clock)
    begin
        if clock'EVENT and clock = '0' then
            if enable = '1' then
                output <= input;
            end if;
        end if;
    end process;
end behavioral;