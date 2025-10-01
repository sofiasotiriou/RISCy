--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- SUB
entity SUB is
port(
    a, b, carryIn : in std_logic;
    resultSub, carryOut : out std_logic
);
end SUB;

architecture structural of SUB is

component portNOT is 
port (
	 a : in std_logic;
    resultNot : out std_logic
);
end component;

component ADD is
port(
    a, b, carryin : in std_logic;
    sum, carryout : out std_logic
);
end component;

signal bInverted : std_logic;

begin
	--invert b
	step0: portNot port map (b, bInverted);
	
	--perform SUB = a + bInv + carryIn where the carry in of the LSB is 1
   step1: ADD port map (a, bInverted, carryIn, resultSub, carryOut);
end structural;
