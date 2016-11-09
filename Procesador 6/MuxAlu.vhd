
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MuxAlu is
    Port ( crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           imm : in  STD_LOGIC_VECTOR (31 downto 0);
           selector : in  STD_LOGIC;
           op2 : out  STD_LOGIC_VECTOR (31 downto 0));
end MuxAlu;

architecture Behavioral of MuxAlu is

begin
process(crs2,selector,imm)
begin
	if (selector = '0')then
		op2<=crs2;
	else
		op2<=imm;
	end if;
end process;	
end Behavioral;

