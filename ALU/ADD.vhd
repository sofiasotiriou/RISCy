--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

-- full adder
entity ADD is
port(
    a, b, carryin : in std_logic;
    sum, carryout : out std_logic
);
end ADD;

architecture behavioral of ADD is
begin
    sum <= a xor b xor carryin;
    carryout <= (a and b) or (carryin and a) or (carryin and b);
end behavioral;