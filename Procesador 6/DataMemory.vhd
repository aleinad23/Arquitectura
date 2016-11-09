library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity DataMemory is
    Port ( address : in  STD_LOGIC_VECTOR (4 downto 0);
           dato : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           DataToMem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is
	type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
	signal RAM : ram_type := (others => x"00000000");
begin
	process(address,dato,WE,rst)
	begin
		if(rst = '1')then
			DataToMem <= (others => '0');
			RAM <= (others => x"00000000");
		else
			DataToMem <= RAM(conv_integer(address));
			if(WE = '1')then
				RAM(conv_integer(address))<= dato;
			end if;
		end if;
	end process;
end Behavioral;

