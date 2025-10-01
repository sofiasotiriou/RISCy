library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity programCounter is
    port (
        input : in  STD_LOGIC_VECTOR(15 downto 0);
        clock, enable   : in  STD_LOGIC;
        output   : out STD_LOGIC_VECTOR(15 downto 0)
    );
end programCounter;

architecture Behavioral of programCounter is
begin
    process (clock)
    begin
        if clock='1' then 
				if enable = '1' then
                output <= input;
				else 
					output <= (others =>'0');
				end if;
        end if; 
    end process;
end Behavioral;