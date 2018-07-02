library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all; 

ENTITY lock IS
    port (clk,rst: in std_logic;
          code:in std_logic_vector(3 downto 0);
          mode:in std_logic_vector(1 downto 0);
          err,unlock:out std_logic;
          pointerout:out std_logic_vector(1 downto 0);
          lk3:out std_logic
          
      );
end lock;

architecture arc of lock is
    signal savecode1:std_logic_vector(3 downto 0);
    signal savecode2:std_logic_vector(3 downto 0);
    signal savecode3:std_logic_vector(3 downto 0);
    signal savecode4:std_logic_vector(3 downto 0);
    signal mastcode1:std_logic_vector(3 downto 0):="0000";
    signal mastcode2:std_logic_vector(3 downto 0):="0000";
    signal mastcode3:std_logic_vector(3 downto 0):="0000";
    signal mastcode4:std_logic_vector(3 downto 0):="0000";
    type states is (st0,in0,in1,in2,in3,ck0,ck1,ck2,ck3);
    signal state:states;

    signal common,master:std_logic;
    signal pointer:integer range 15 downto 0:=0;
    signal pointerchange:integer range 16 downto 0;
    signal lkcount:integer range 4 downto 0:=0;
    signal lk3c:std_logic:='0';
begin
    process (clk,rst)
    begin
        
    if(rst='0') then
			unlock<='0';
			err<='0';
			master<='1';
			if(mode="01")  then
				state<=in0;
			else
				state<=ck0;
			end if;
			
		if(lk3c='1')then
			common<='0';
		else
			common<='1';
		end if;
		lkcount<=0;

elsif(clk'event and clk='1') then
case state is
            when in0=>
            unlock<='0';
            err<='0';
            savecode1(3 downto 0)<=code;
            state<=in1;
        when in1=>
            unlock<='0';
            err<='0';
            savecode2(3 downto 0)<=code;
            state<=in2;
        when in2=>
            unlock<='0';
            err<='0';
            savecode3(3 downto 0)<=code;
            state<=in3;
        when in3=>
            unlock<='0';
            err<='0';
            savecode4(3 downto 0)<=code;
            state<=st0;

        when ck0=>
            if(not (savecode1=code) or common='0') then
                if(master='0' or not(mastcode1=code)) then
                    state<=ck0;
                    unlock<='0';
                    err<='1';
                    if(lkcount=2) then
                        lk3c<='1';
                    else
                        lkcount<=lkcount+1;
                    end if;
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                else
                    state<=ck1;
                    common<='0';
                    unlock<='0';
                    err<='0';
                end if;
            elsif not(mastcode1=code) then
                state<=ck1;
                master<='0';
                unlock<='0';
                err<='0';
            else
                state<=ck1;
                unlock<='0';
                err<='0';
            end if;
        when ck1=>
            if(not (savecode2=code) or common='0') then
                if(master='0' or not(mastcode2=code)) then
                    state<=st0;
                   
                    unlock<='0';
                    err<='1';
                    if(lkcount=2) then
                        lk3c<='1';
                    else
                        lkcount<=lkcount+1;
                    end if;
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                else
                    state<=ck2;
                    common<='0';
                    unlock<='0';
                    err<='0';
                end if;
            elsif not(mastcode2=code) then
                state<=ck2;
                master<='0';
                unlock<='0';
                err<='0';
            else
                state<=ck2;
                unlock<='0';
                err<='0';
            end if;
        when ck2=>
            if(not (savecode3=code) or common='0') then
                if(master='0' or not(mastcode3=code)) then
                    state<=st0;
                    unlock<='0';
                    err<='1';
                    if(lkcount=2) then
                        lk3c<='1';
                    else
                        lkcount<=lkcount+1;
                    end if;
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                else
                    state<=ck3;
                    common<='0';
                    unlock<='0';
                    err<='0';
                end if;
            elsif not(mastcode3=code) then
                state<=ck3;
                master<='0';
                unlock<='0';
                err<='0';
            else
                state<=ck3;
                unlock<='0';
                err<='0';
            end if;
        when ck3=>
            if(not (savecode4=code) or common='0') then
                if(master='0' or not(mastcode4=code)) then
                    state<=st0;
                    unlock<='0';
                    err<='1';
                    if(lkcount=2) then
                        lk3c<='1';
                    else
                        lkcount<=lkcount+1;
                    end if;

                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                else
                    state<=st0;

                    unlock<='1';
                    lkcount<=0;
                    lk3c<='0';
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                    err<='0';
                end if;
            elsif(master='0' or not(mastcode4=code)) then
                state<=st0;

                unlock<='1';
                lkcount<=0;
                master<='1';
                if(lk3c='1')then
                    common<='0';
                else
                    common<='1';
                end if;
                err<='0';
            else
                state<=st0;
                unlock<='1';
                lkcount<=0;
                lk3c<='0';
                master<='1';
                if(lk3c='1')then
                    common<='0';
                else
                    common<='1';
                end if;
                err<='0';
            end if;
        when st0=>
            unlock<='0';
            err<='0';
    end case;

end if;
if(state=ck0) then
	pointerout<="00";
elsif (state=ck1) then
	pointerout<="01";
else
	pointerout<="11";
	end if;
    end process;

    
    lk3<=lk3c;


end arc;
