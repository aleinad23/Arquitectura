
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxPC is
    Port ( PCdisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCdisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Address : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCout : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxPC;

architecture Behavioral of MuxPC is

begin

	process(PCdisp30,Pcdisp22,Pc1,Address,PcSource)
	begin
			case PCSource is
				when "00" =>
						PCout <= Address;
				when "01" => 
						PCout <= Pcdisp30;
				when "10" =>
						PCout <= PCdisp22;
				when others => 
						PCout <= PC1;
						
			end case;
	end process;
end Behavioral;
