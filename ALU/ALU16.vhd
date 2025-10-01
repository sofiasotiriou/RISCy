--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;


entity ALU16 is 
port (
    a, b : in std_logic_vector (15 downto 0);
    opcode : in std_logic_vector (2 downto 0);
    endResult : out std_logic_vector (15 downto 0);
    overflow : out std_logic
);
end ALU16;

architecture structural of ALU16 is 

component ALU1 is 
port(
    a, b, carryIn : in std_logic;
    operation : in std_logic_vector (2 downto 0);
    finalResult, carryOut : out std_logic
);
end component;

component ControlCircuit is 
port (
    msba : in std_logic;
    opcode : in std_logic_vector (2 downto 0);
    carryIn : out std_logic
);              
end component;

signal cin : std_logic;
signal carry : std_logic_vector (15 downto 0);

begin 
	--sets carry in if necassary (1 for SUB and MSB of a for GEQ)
   step0: ControlCircuit port map (a(15), opcode, cin);
	--one rotation so that in the loop the carry(i-1) doesn't step out of bounds
   step1: ALU1 port map (a(0), b(0), cin, opcode, endResult(0), carry(0));

	aluloop : for i in 1 to 15 generate 
		aluinst: ALU1 port map (a(i), b(i), carry(i-1), opcode, endResult(i), carry(i));
	end generate;

   overflow <= (carry(15) xor carry(14));
end structural;