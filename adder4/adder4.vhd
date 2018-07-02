library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

ENTITY adder4 IS
port (cin: in std_logic;
x,y:in std_logic_vector(3 downto 0);
sum:out std_logic_vector(3 downto 0);
cout:out std_logic);
end adder4;

architecture arc of adder4 is
	component f_adder
		port(ci,a,b: in std_logic;
			s:out std_logic);
	end component;
	signal c,g,p:std_logic_vector(0 to 3);
begin
	g(0)<=x(0) and y(0);p(0)<=x(0) or y(0);
	g(1)<=x(1) and y(1);p(1)<=x(1) or y(1);
	g(2)<=x(2) and y(2);p(2)<=x(2) or y(2);
	g(3)<=x(3) and y(3);p(3)<=x(3) or y(3);
	c(0)<=g(0) or (p(0) and cin);
	c(1)<=g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
	c(2)<=g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
	c(3)<=g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and c(0)) or (p(3) and p(2) and p(1) and p(0) and cin);
	
	u1:f_adder port map(cin,x(0),y(0),sum(0));
	u2:f_adder port map(c(0),x(1),y(1),sum(1));
	u3:f_adder port map(c(1),x(2),y(2),sum(2));
	u4:f_adder port map(c(2),x(3),y(3),sum(3));
	cout<=c(3);
end arc;
