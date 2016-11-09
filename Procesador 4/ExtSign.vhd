library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ExtSign is
    Port ( Ext_in : in  STD_LOGIC_VECTOR (12 downto 0);
           Ext_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ExtSign;

architecture Behavioral of ExtSign is

begin
	process(Ext_in)
	begin
		if(Ext_in(12) = '0')then 
			Ext_out(31 downto 13) <= "0000000000000000000";
			Ext_out(12 downto 0) <= Ext_in;
		else
			Ext_out(31 downto 13) <= "1111111111111111111";
			Ext_out(12 downto 0) <= Ext_in;
		end if;
	end process;
			
	


end Behavioral;

