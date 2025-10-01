--author: Sofia-Zoi Sotiriou p3210192
library IEEE;
use IEEE.std_logic_1164.all;


entity id_ex is 
	generic (
		n : integer := 16;
		addressSize : integer := 3 
	);
	port ( 
		clock, inEOR, inWasJumpOut, inJump, inJR, inBranch, inR, inMFPC, inLW, inSW, inReadDigit, inPrintDigit : in std_logic;
		inALUfunc : in std_logic_vector(3 downto 0);
		inR1, inR2, inImmediate16 : in std_logic_vector(n-1 downto 0);
		inR1address, inR2address : in std_logic_vector(addressSize-1 downto 0); 
		inJumpShortAddr  : in std_logic_vector(11 downto 0);
		
		outEOR, outWasJumpOut, outJump, outJR, outBranch, outR, outMFPC, outLW, outSW, outReadDigit, outPrintDigit : out std_logic;
		outALUfunc : out std_logic_vector(3 downto 0);
		outR1, outR2, outImmediate16 : out std_logic_vector(n-1 downto 0);
		outR1address, outR2address : out std_logic_vector(addressSize-1 downto 0); 
		outJumpShortAddr  : out std_logic_vector(11 downto 0)
	);
end id_ex;

architecture behavior of id_ex is 
begin 
	process(clock) 
	begin 
		if clock='1' then 
			outEOR <= inEOR;
			outWasJumpOut <= inWasJumpOut;
			outJump <= inJump;
			outJR <= inJR;
			outBranch <= inBranch;
			outR <= inR;
			outMFPC <= inMFPC;
			outLW <= inLW;
			outSW <= inSW;
			outReadDigit <= inReadDigit;
			outPrintDigit <= inPrintDigit;
			outALUfunc <= inALUfunc;
			outR1 <= inR1;
			outR2 <= inR2;
			outImmediate16 <= inImmediate16; 
			outR1address <= inR1address;
			outR2address <= inR2address;
			outJumpShortAddr <= inJumpShortAddr;
		end if; 
	end process; 
end behavior;			