library ieee;
use ieee.std_logic_1164.all;

entity h_adder is
port (a,b:in std_logic;
	s,c:out std_logic);
end h_adder;
architecture rt1 of h_adder is
begin
c<=a and b;
s<=a xor b;
end rt1;