LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_7 is
	port(
	    int:in integer range 9 downto 0;
		display:out std_logic_vector(6 downto 0)
	);
end digital_7;
architecture bhv of digital_7 is
begin
	process(int)
	begin
		case int is
			when 0=>display<="1111110";
			when 1=>display<="0110000";
			when 2=>display<="1101101";
			when 3=>display<="1111001";
			when 4=>display<="0110011";
			when 5=>display<="1011011";
			when 6=>display<="0011111";
			when 7=>display<="1110000";
			when 8=>display<="1111111";
			when 9=>display<="1110011";
			when others=>display<="0000000";
		end case;
	end process;
end bhv;
