
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxRFSource is
    Port ( DataMemory : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           RFSource : in  STD_LOGIC_VECTOR (1 downto 0);
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxRFSource;

architecture Behavioral of MuxRFSource is

begin
	process(DataMemory,AluResult,PC,RFSource)
	begin 
		case RFSource is
			when "00" => 
					DataOut <= DataMemory;
			when "01" =>
					DataOut <= AluResult;
			when "10" => 
					DataOut <= PC;
			when others => 
					DataOut <= x"00000000";
		end case;
	end process;
end Behavioral;