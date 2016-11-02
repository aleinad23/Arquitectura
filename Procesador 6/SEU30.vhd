library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SEU30 is
    Port ( Ext_in : in  STD_LOGIC_VECTOR (29 downto 0);
           Ext_out : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU30;

architecture Behavioral of SEU30 is

begin
process(Ext_in)
	begin
		if(Ext_in(29) = '0')then
			Ext_out(31 downto 30) <= "00";
			Ext_out(29 downto 0) <= Ext_in;
		else
			Ext_out(31 downto 30) <= "11";
			Ext_out(29 downto 0) <= Ext_in;
		end if;
	end process;

end Behavioral;

