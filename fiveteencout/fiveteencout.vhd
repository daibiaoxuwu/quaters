library ieee; 

use ieee.std_logic_1164.all; 

use ieee.std_logic_unsigned.all; 

ENTITY fiveteencout IS 

PORT(clk,reset,enable : IN std_logic; count : OUT std_logic_vector(3 downto 0)); 

END fiveteencout; 

ARCHITECTURE counter OF fiveteencout IS 

SIGNAL count_int:std_logic_vector(0 to 3); 

BEGIN 

PROCESS(clk,reset) 

BEGIN 

WAIT UNTIL rising_edge(clk); 

IF reset = '1' THEN 

count_int <= (OTHERS => '0'); 

ELSIF enable = '1' THEN 

IF(count_int="1110") THEN 

count_int<="0000"; 

ELSE 

count_int <= count_int+"0001"; 

--ELSE 

-- NULL  

--IF (count_int="1001") THEN 

--count_int<="0000"; 

END IF; 

END IF; 

END PROCESS; 

count <= count_int; 

-- IF (reset='0') then 

--q<="0000"; 

---ELSIF(clk'event and clk='1') THEN 

--q<=q 1; 

--IF (q<="1001") then 

--q<="0000"; 

---END IF; 


--IF (reset<='1')THEN 

--q<="00"; 

--ELSIF 

--wait until (clk'event and clk='1'); 

--WAIT UNTIL (clk'EVENT AND clk = '1'); 

--WAIT UNTIL (clock'EVENT AND clock = '1'); 

-- q<=q '1'; 

--end if; 

--count<=q; 

-- WAIT UNTIL clock = '1'; 

--if (clock'event and clock='1')then 

--WAIT UNTIL rising_edge(clock); 

--clock'event and clock='1'; 

--count <= 0; 

--WAIT UNTIL (clock'EVENT AND clock = '1'); 

--WAIT riseedge clock = '1'; 

--if (clock'event and clock='1') then 

--WAIT UNTIL rising_edge(clock); 

--count <= 1; 

--WAIT UNTIL (clock'EVENT AND clock = '1'); 

--WAIT UNTIL clock = '1'; 

--if (clock'event and clock='1')then 

--WAIT UNTIL rising_edge(clock); 

--count <= 2; 

--end if; 

--end if; 

--end if; 

-- END PROCESS; 

END counter; 


