library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all; 

ENTITY timer IS
port (clk,rst: in std_logic;
code:out std_logic_vector(3 downto 0);
mode:out std_logic_vector(1 downto 0);
err,unlock:out std_logic;
);
end timer;

architecture arc of timer is
	signal savecode:std_logic_vector(16 downto 0):="1001100110011001";
	signal pointer:integer range 3 downto 0;
begin
    process (clk)
    begin
        if(clk'event and clk=='1') then
            if(mode=="01") then
                savecode(pointer)<=code(0);
                savecode(pointer+1)<=code(1);
                savecode(pointer+2)<=code(2);
                savecode(pointer+3)<=code(3);
                pointer<=pointer+4;
            else if(mode=="00") then
                if(savecode(pointer)==code(0) and
                savecode(pointer+1)==code(1) and
                savecode(pointer+2)==code(2) and
                savecode(pointer+3)==code(3)) then
                    pointer:=pointer+4;
                    if(pointer==16)
                        unlock<='1';
                        pointer:=0;
                    end if
                else
                    err<='1';
                    pointer:=0;
                end if;
            end if;
        end if;
    end process;


    process (mode)
    begin
        if(mode'event) then
            pointer:=0;
        end if;
    end process;

            
end arc;
