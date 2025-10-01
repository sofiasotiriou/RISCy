--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;


-- 1-bit ALU
entity ALU1 is
port(
    a, b : in std_logic;
	 carryIn : in std_logic := '0';
    operation : in std_logic_vector (2 downto 0);
    finalResult, carryOut : out std_logic
);
end ALU1;

architecture structural of ALU1 is
--initializing the 8 components that correspond to the operations of the ALU and the multiplexer component
component portAND is
port(
    a, b : in std_logic;
    andresult : out std_logic
);
end component;

component portOR is
port(
    a, b : in std_logic;
    orresult : out std_logic
);
end component;

component ADD is
port(
    a, b, carryIn : in std_logic;
    sum, carryOut : out std_logic
);
end component;

component SUB is 
port(
    a, b, carryIn : in std_logic;
    resultSub, carryOut : out std_logic
);
end component;

component portXOR is
port(
    a, b : in std_logic;
    resultXor : out std_logic
);
end component;

component portNOR is
port(
    a, b : in std_logic;
    resultNor : out std_logic
);
end component;

component portGEQ is
port(
    carryIn : in std_logic;
    resultGeq, carryOut : out std_logic
);
end component;

component portNOT is
port(
    a : in std_logic;
    resultNot : out std_logic
);
end component;

component mux8to1 is
port(
    m1, m2, m3, m4, m5, m6, m7, m8, carryOutGEQ, carryOutADD, carryOutSUB : in std_logic;
    operation : in std_logic_vector (2 downto 0);
    result, carryOut : out std_logic
);
end component;

signal m1, m2, m3, m4, m5, m6, m7, m8, coGEQ, coADD, coSUB : std_logic;

begin
	
    -- operations
    op1: ADD port map (a, b, carryin, m1, coADD);
    op2: SUB port map (a, b, carryin, m2, coSUB);
    op3: portAND port map (a, b, m3);
    op4: portOR port map (a, b, m4);
    op5: portGEQ port map (carryin, m5, coGEQ);
    op6: portNOT port map (a, m6);
    op7: portXOR port map (a, b, m7);
    op8: portNOR port map (a, b, m8);

    -- choosing operation and the correct carryOut based on opcode
    mux: mux8to1 port map (m1, m2, m3, m4, m5, m6, m7, m8, coGEQ, coADD, coSUB, operation, finalResult, carryOut);
end;