library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


ENTITY adder5 IS
port (cin: in std_logic;
x,y:in std_logic_vector(3 downto 0);
sum:out std_logic_vector(3 downto 0);
cout:out std_logic);
end adder5;

architecture arc of adder5 is
	signal c1:std_logic_vector(4 downto 0);
	signal x1:std_logic_vector(4 downto 0);
	signal y1:std_logic_vector(4 downto 0);
	signal mid:std_logic_vector(4 downto 0);
begin
	x1<='0' &x;
	y1<='0' &y;
	c1<="0000" &cin;
	mid<=c1+x1+y1;
	sum<=mid(3 downto 0);
	cout<=mid(4);
	
	
end arc;
