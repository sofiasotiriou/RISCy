--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

entity ControlCircuit is
port (
    msba : in std_logic;
    opcode : in std_logic_vector (2 downto 0);
    carryIn : out std_logic
);
end ControlCircuit;

architecture cc of ControlCircuit is
begin
    process (opcode, msba) 
	 --initializes the carryIn according to the operation that is going to be performed
    begin
        case opcode is
            --SUB
            when "001" =>
                carryIn <= '1';
            --GEQ
            when "100" =>
                carryIn <= not msba;
            when others => 
                carryIn <= '0';
        end case;
    end process;
end;
