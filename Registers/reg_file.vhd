--author: Sofia-Zoi Sotiriou p3210192

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;

entity reg_file is 
	port (
			clock : in std_logic;
			read1AD, read2AD, write1AD: in std_logic_vector(2 downto 0);
			write1 : in std_logic_vector(15 downto 0);
			OUTall : out std_logic_vector(127 downto 0); 
			read1, read2 : out std_logic_vector(15 downto 0)
	);
end reg_file;

architecture structural of reg_file is 
--The component for the 7 regular registers 
component reg is
	generic (
		n : integer := 16
	);
   port (
      input : in std_logic_vector(n-1 downto 0);
      clock, enable : in std_logic;
		output : out std_logic_vector(n-1 downto 0)
   );
end component;

--The component for the pseudo-register
component reg0 
	port ( 
			input : in std_logic_vector(15 downto 0);
			clock, enable : in std_logic;
			output : out std_logic_vector(15 downto 0)
    );
end component;
	
--The multiplexer that perform he reading function	
component multiplexer8to1 is 
port ( 
			in1, in2, in3, in4, in5, in6, in7, in8 : in std_logic_vector(15 downto 0);
			opcode : in std_logic_vector(2 downto 0);
			output : out std_logic_vector(15 downto 0)
    );
end component;

--The decoder that gives the enable signal for each register to allow writing 
component decoder3to8 is 
	port ( 
			input: in std_logic_vector(2 downto 0);
			output : out std_logic_vector(7 downto 0)
    );
end component;

--Creates the 128-bit output by adding the outputs of all the registers to one vector
component concatenator
	port ( 
		out0, out1, out2, out3, out4, out5, out6, out7 : in std_logic_vector(15 downto 0);
		ALLout : out std_logic_vector(127 downto 0)
	);
end component;
--Each element is the enable signal for that register
signal registers : std_logic_vector(7 downto 0);
--Intermediate signals for the outputs of all the registers and the multiplexers that correspond to the reading function
signal out0, out1, out2, out3, out4, out5, out6, out7, reader1, reader2 : std_logic_vector(15 downto 0);

begin

	decoder : decoder3to8 port map (write1AD, registers);
	
	--Instantiating all the registers
	register0 : reg0 port map (write1, clock, registers(0), out0);
	register1 : reg port map (write1, clock, registers(1), out1);
	register2 : reg port map (write1, clock, registers(2), out2);
	register3 : reg port map (write1, clock, registers(3), out3);
	register4 : reg port map (write1, clock, registers(4), out4);
	register5 : reg port map (write1, clock, registers(5), out5);
	register6 : reg port map (write1, clock, registers(6), out6);
	register7 : reg port map (write1, clock, registers(7), out7);
	
	--Concatenating all the outputs into one 128-bit vector
	addResults : concatenator port map ( out0, out1, out2, out3, out4, out5, out6, out7, OUTall);
	
	--reading the first input and outputing the corresponding data
	reading1 : multiplexer8to1 port map (out0, out1, out2, out3, out4, out5, out6, out7, read1AD, read1);
	--read1 <= reader1;
	
	--reading the second input and outputing the corresponding data
	reading2 : multiplexer8to1 port map (out0, out1, out2, out3, out4, out5, out6, out7, read2AD, read2);
	--read2 <= reader2;
		
end structural; 