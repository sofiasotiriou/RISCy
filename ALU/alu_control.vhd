--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;


entity alu_control is
    port (
        opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
        func   : in  STD_LOGIC_VECTOR(2 downto 0);
        aluOperation  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is
begin
    process(opcode, func)
    begin
        case opCode is
            when "0000" =>
                aluOperation(3) <= '0';
                aluOperation(2 downto 0) <= func;
            when others => aluOperation <= opCode;
        end case;
    end process;
end Behavioral;