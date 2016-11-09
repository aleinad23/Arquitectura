
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

begin

	process(op,op3)
	begin
		if(op = "10")then
			case(op3) is
				when "000001" => --AND
					ALUOP <= "000000";
				when "000101" => --ANDn
					ALUOP <= "000001";
				when "000010" => --OR
					ALUOP <= "000010";
				when "000110" => --ORN
					ALUOP <= "000011";
				when "000011" =>  --XOR
					ALUOP <= "000100";
				when "000111" => --XNOR
					ALUOP <= "000101";
				when "000000" => --ADD
					ALUOP <= "000110";		
				when "000100" => --SUB
					ALUOP <= "000111";
				when "010000" => --ADDcc
					ALUOP <= "001000";
				when "011000" => --ADDXcc
					ALUOP <= "001001";
				when "010100" => --SUBcc
					ALUOP <= "001010";
				when "011100" => --SUBXcc
					ALUOP <= "001011";
				when "010001" => --ANDcc
					ALUOP <= "001100";
				when "010101" => --ANDncc
					ALUOP <= "001101";
				when "010010" => --ORcc
					ALUOP <= "001110";
				when "010110" => --ORncc
					ALUOP <= "001111";
				when "010011" => --XORcc
					ALUOP <= "010000";
				when "010111" => --XNORcc
					ALUOP <= "010001";
				when "001000" => --ADDx
					ALUOP <= "010010";
				when "001100" => --SUBx
					ALUOP <= "010011";
				when "100101" => --SLL
					ALUOP <= "010100";
				when "100110" => --SRL
					ALUOP <= "010101";
				when others => 
					ALUOP <= "111111";
			end case;
		end if;	
	end process;
					

end Behavioral;

