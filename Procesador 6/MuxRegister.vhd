library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MuxRegister is
    Port ( rsd : in  STD_LOGIC_VECTOR (5 downto 0);
           RegO7 : in  STD_LOGIC_VECTOR (5 downto 0);
           rfDest : in  STD_LOGIC;
           nRds : out  STD_LOGIC_VECTOR (5 downto 0));
end MuxRegister;

architecture Behavioral of MuxRegister is

begin
	process(rsd,RegO7,rfDest)
	begin 
	
		if(rfDest = '1') then 
			nRds <= RegO7;
		else
			if(rfDest = '0') then
			nRds <= rsd;
			end if;
		end if;
end process;


end Behavioral;

