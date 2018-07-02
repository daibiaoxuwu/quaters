library ieee;
use ieee.std_logic_1164.all;

entity test2 is
port (a,b:in std_logic;
	s,c:out std_logic);
end test2;
architecture rt1 of test2 is
begin
c<=a and b;
s<=a xor b;
end rt1;