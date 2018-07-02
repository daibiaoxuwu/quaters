library ieee;
use ieee.std_logic_1164.all;


ENTITY sct IS
PORT(clk,clr,pau,d: in std_logic;
	q,qf: out std_logic);
end sct;
architecture arc of sct is
	signal q1:std_logic;
	signal qf1:std_logic;
begin
    process (clk,pau,clr,q1,qf1)
    begin
    if(pau = '0') then
		if(clr = '1') then
			q1<='0';
			qf1<='1';
		elsif(clk'event and clk = '1') then
			q1<=d;
			qf1<= not d;
		end if;
    end if;
	 
end process;
q<=q1;
qf<=qf1;
    
end arc;


