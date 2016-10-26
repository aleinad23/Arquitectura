
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PSRModifier is
    Port ( ALUResult : in  STD_LOGIC_VECTOR (31 downto 0);
           oper131 : in  STD_LOGIC; --oper131
           oper231 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out std_logic_vector(3 downto 0));
end PSRModifier;

architecture Behavioral of PSRModifier is

begin
	process(ALUResult, ALUOP, oper131, oper231,rst)
	begin
		if rst = '1' then
			nzvc <= "0000";
		else
		
			if(ALUOP = "001000" or ALUOP = "001001")then--ADDcc ADDxcc
				nzvc(3) <= ALUResult(31);
				if(ALUResult = x"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (oper131 and oper231 and (not ALUResult(31))) or ((oper131) and (not oper231) and ALUResult(31));
				nzvc(0) <= (oper131 and oper231) or ((not ALUResult(31)) and (oper131 or oper231));
			else
				if(ALUOP = "001010" or ALUOP = "001011")then --SUBcc SUBxcc
					nzvc(3) <= ALUResult(31);
					if(ALUResult = x"00000000")then
						nzvc(2) <= '1';
					else
						nzvc(2) <= '0';
					end if;
					nzvc(1) <= ((oper131 and (not oper231) and (not ALUResult(31))) or ((not oper131) and oper231 and ALUResult(31)));
					nzvc(0) <= ((not oper131) and oper231) or (ALUResult(31) and ((not oper131) or oper231));
				else
					if(ALUOP = "001100" or ALUOP = "001101" or ALUOP = "001110" or ALUOP = "001111" or ALUOP = "010000" or ALUOP = "010001")then
						--ANDcc ANDncc ORcc ORncc XORcc XNORcc
						nzvc(3) <= ALUResult(31);
						if (ALUResult = x"00000000") then
							nzvc(2) <= '1';
						else
							nzvc(2) <= '0';
						end if;
						nzvc(1) <= '0';
						nzvc(0) <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;
end Behavioral;

