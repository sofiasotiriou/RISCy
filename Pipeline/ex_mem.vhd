--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity ex_mem is 
	generic (
		n: INTEGER := 16;
		addressSize : INTEGER := 3
	);
	port (
		clock, inPrintDigit, inReadDigit, inWriteEnable, inLW : in std_logic;
		inR2, inALUres : in std_logic_vector (n-1 downto 0);
		inAddr : in std_logic_vector (addressSize-1 downto 0);
		
		outPrintDigit, outReadDigit, outWriteEnable, outLW : out std_logic;
		outR2, outALUres : out std_logic_vector (n-1 downto 0);
		outAddr : out std_logic_vector (addressSize-1 downto 0)
	);
end ex_mem; 

architecture behavior of ex_mem is 
begin 
	process(clock) 
	begin 
		if clock='1' then 
			outPrintDigit   <= inPrintDigit;
			outReadDigit    <= inReadDigit;
			outWriteEnable  <= inWriteEnable;
			outLW           <= inLW;
			outR2           <= inR2;
			outALUres       <= inALUres;
			outAddr         <= inAddr;
		end if;
	end process; 
end behavior;