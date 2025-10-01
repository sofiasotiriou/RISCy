library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity jrSelector is 
	generic ( 
		n : integer := 16
	);
	port( 
		jumpAD, branchAD, pcp2add : in std_logic_vector (n-1 downto 0);
		opcode : in std_logic_vector (1 downto 0);
		result: out std_logic_vector (n-1 downto 0)
	);
end jrSelector;


architecture behavior of jrSelector is 
begin 
    process(opcode)
    begin 
		  result <= pcp2add;
        case opcode is 
            when "01" => result <= jumpAD; 
            when "10" => result <= branchAD;   
            when others => result <= pcp2add;  
        end case;
    end process;
end behavior;