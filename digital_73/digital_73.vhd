LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_73 is
	port(
		press:in std_logic;					--signal for the key presssed
		display:out std_logic_vector(6 downto 0);  --display of 7 controller number
		display_4:out std_logic_vector(3 downto 0);--display of even number(2n)
		display_8:out std_logic_vector(3 downto 0) --display of odd number(2n+1)
	);
end digital_73;
architecture bhv of digital_73 is
	signal key:std_logic_vector(3 downto 0):="0000"; --number
begin
	process
	begin
		wait until press='1';
		key<=key+"0001";
		if(key="1001")then
			key<="0000";
		end if;
	end process;
	
	process(key)--display numbers
	begin
		case key is--display:7 controls
			when"0000"=>display<="1111110" after 200ns;
			when"0001"=>display<="0110000" after 200ns;
			when"0010"=>display<="1101101" after 200ns;
			when"0011"=>display<="1111001" after 200ns;
			when"0100"=>display<="0110011" after 200ns;
			when"0101"=>display<="1011011" after 200ns;
			when"0110"=>display<="0011111" after 200ns;
			when"0111"=>display<="1110000" after 200ns;
			when"1000"=>display<="1111111" after 200ns;
			when"1001"=>display<="1110011" after 200ns;
			when"1010"=>display<="1110111" after 200ns;
			when"1011"=>display<="0011111" after 200ns;
			when"1100"=>display<="1001110" after 200ns;
			when"1101"=>display<="0111101" after 200ns;
			when"1110"=>display<="1001111" after 200ns;
			when"1111"=>display<="1000111" after 200ns;
			when others=>display<="0000000" after 200ns;
		end case;
		case key is--display:evens
			when"0000"=>display_4<="0000" after 200ns;
			when"0001"=>display_4<="0010" after 200ns;
			when"0010"=>display_4<="0100" after 200ns;
			when"0011"=>display_4<="0110" after 200ns;
			when"0100"=>display_4<="1000" after 200ns;
			when others=>display_4<="1111" after 200ns;
		end case;
		case key is--display:odds
			when"0000"=>display_8<="0001" after 200ns;
			when"0001"=>display_8<="0011" after 200ns;
			when"0010"=>display_8<="0101" after 200ns;
			when"0011"=>display_8<="0111" after 200ns;
			when"0100"=>display_8<="1001" after 200ns;
			when others=>display_8<="1111" after 200ns;
		end case;
	end process;
end bhv;