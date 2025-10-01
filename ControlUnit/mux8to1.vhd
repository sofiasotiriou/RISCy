--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- 8to1 multiplexer (operation) for the ALU (the component asked at a later time is multiplexer8to1)
entity mux8to1 is
port(
    m1, m2, m3, m4, m5, m6, m7, m8, carryOutGEQ, carryOutADD, carryOutSUB : in std_logic;
    operation : in std_logic_vector (2 downto 0);
    result, carryOut : out std_logic
);
end mux8to1;

architecture behavioral of mux8to1 is
begin
	--select output according to operation 
   with operation select
       result <= m1 when "000",
                 m2 when "001",
                 m3 when "010",
                 m4 when "011",
                 m5 when "100",
                 m6 when "101",
                 m7 when "110",
                 m8 when others;
						
	--select the carryOut that corresponds to the operation 
   with operation select
       carryOut <= carryOutGEQ when "100",
                   carryOutADD when "000",
						 carryOutSUB when "001",
						 '0' when others;
end behavioral;
