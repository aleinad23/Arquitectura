
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter is
    Port ( PC_in : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           PC_out : out  STD_LOGIC_VECTOR (31 downto 0));
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin

	process(PC_in, rst, clk)
	begin
		if(rst = '1')then
			PC_out <= "00000000000000000000000000000000";
		else
			if(rising_edge(clk) and rst = '0')then
				PC_out <= PC_in;
			end if;
		end if;
	end process;
			

end Behavioral;

