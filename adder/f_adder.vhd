library ieee;
use ieee.std_logic_1164.all;


ENTITY f_adder IS
PORT(a,b,ci: in std_logic;
	s,c0: out std_logic);
end f_adder;
architecture arc of f_adder is
	component h_adder
		port(a,b: in std_logic;
			s,c:out std_logic);
	end component;
	signal s1,c1,c2:std_logic;
begin
	u1:h_adder port map(a,b,s1,c1);
	u2:h_adder port map(s1,ci,s,c2);
	c0<=c1 or c2;
end arc;
