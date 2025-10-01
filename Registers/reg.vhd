--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

--top level entity
entity reg is
	generic (
		n : integer := 16
	);
   port (
      input : in std_logic_vector(n-1 downto 0);
      clock, enable : in std_logic;
		output : out std_logic_vector(n-1 downto 0)
   );
end entity reg;

architecture behavior of reg is
	component latch1 is
		 port ( 
			  input, clock, enable : in std_logic;
			  output : out std_logic
		 );
	end component;
begin
    reg_loop : for i in n-1 downto 0 generate 
		REG0 : latch1 port map(input(i), clock, enable, output(i));
	end generate reg_loop;
end behavior;