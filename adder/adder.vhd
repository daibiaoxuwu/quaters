library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY adder IS
port (cin: in std_logic;
x,y:in std_logic_vector(3 downto 0);
sum:out std_logic_vector(3 downto 0);
cout:out std_logic);
end adder;

architecture arc of adder is
	component f_adder
		port(ci,a,b: in std_logic;
			s,c0:out std_logic);
	end component;
	signal c:std_logic_vector(0 to 4);
begin
	c(0)<=cin;
	u1:f_adder port map(c(0),x(0),y(0),sum(0),c(1));
	u2:f_adder port map(c(1),x(1),y(1),sum(1),c(2));
	u3:f_adder port map(c(2),x(2),y(2),sum(2),c(3));
	u4:f_adder port map(c(3),x(3),y(3),sum(3),c(4));
	cout<=c(4);
end arc;
