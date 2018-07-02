library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all; 

ENTITY timer IS
port (clk2,rst: in std_logic;
hout:out std_logic_vector(6 downto 0);
lout:out std_logic_vector(6 downto 0));
end timer;

architecture arc of timer is
	component sct
		port(clk,clr,d: in std_logic;
			q,qf:out std_logic);
	end component;
    component digital_7
	    port(int:in integer range 9 downto 0;
		display:out std_logic_vector(6 downto 0));
	end component;
	signal rst1:std_logic;
	signal d:std_logic_vector(6 downto 0):="0000000";
	signal qv: std_logic_vector(6 downto 0):="0000000";
	signal dout:std_logic_vector(6 downto 0):="0000000";
	signal int:integer range 59 downto 0;
	signal intlow:integer range 9 downto 0;
	signal inthigh:integer range 9 downto 0;
begin
	
process (clk2,d,rst)
    begin
    if(d="1000011") then--0111100
        rst1<='1';
    else
		rst1<=rst;
	end if;
end process;
    u1:sct port map(clk2,rst1,d(0),qv(0),dout(0));d(0)<=dout(0);
	u2:sct port map(d(0),rst1,d(1),qv(1),dout(1));d(1)<=dout(1);
	u3:sct port map(d(1),rst1,d(2),qv(2),dout(2));d(2)<=dout(2);
	u4:sct port map(d(2),rst1,d(3),qv(3),dout(3));d(3)<=dout(3);
	u5:sct port map(d(3),rst1,d(4),qv(4),dout(4));d(4)<=dout(4);
	u6:sct port map(d(4),rst1,d(5),qv(5),dout(5));d(5)<=dout(5);
	u7:sct port map(d(5),rst1,d(6),qv(6),dout(6));d(6)<=dout(6);
    int<=CONV_INTEGER(qv);
    intlow<=int mod 10;
    inthigh<=int / 10;
    d1:digital_7 port map(inthigh,hout);
    d2:digital_7 port map(intlow,lout);

end arc;
