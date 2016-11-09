
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Multiplexor is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           selector : in  STD_LOGIC;
           Mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Multiplexor;

architecture Behavioral of Multiplexor is

begin
	
	process (A,B,selector)
	begin
		if (selector = '0') then
			Mux_out <= A;
		else
			Mux_out <= B;
		end if;
	end process;

end Behavioral;

