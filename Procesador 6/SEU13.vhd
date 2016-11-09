library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU22 is
    Port ( Ext_in : in  STD_LOGIC_VECTOR (21 downto 0);
           Ext_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU22;

architecture Behavioral of SEU22 is

begin
	process(Ext_in)
	begin
		if(Ext_in(21) = '0')then
			Ext_out(31 downto 22) <= "0000000000";
			Ext_out(21 downto 0) <= Ext_in;
		else
			Ext_out(31 downto 22) <= "1111111111";
			Ext_out(21 downto 0) <= Ext_in;
		end if;
	end process;
end Behavioral;

