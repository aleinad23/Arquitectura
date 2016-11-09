
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UC is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  op2 : in  STD_LOGIC_VECTOR (2 downto 0);----------
           icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  cond: in  STD_LOGIC_VECTOR (3 downto 0);
			  
			  ALUOP : out  STD_LOGIC_VECTOR (5 downto 0);
			  rfdest : out  STD_LOGIC;
			  rfsource : out  STD_LOGIC_VECTOR (1 downto 0);
			  wrEnMem : out  STD_LOGIC;
			  pcSource : out STD_LOGIC_VECTOR (1 downto 0);
           wrEnRF : out  STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin

	process(op,op3)
	begin
	
		if(op = "00") then -- Branches Nop & Sethi
			--Branch
			if(op2 = "010")then 
				case cond is
					when "1000" => -- B Always
						pcSource <= "10";
						wrEnRF <= '0'; 
						rfsource <= "00"; -- 
						rfdest <= '0';
						wrEnMem <= '0';
						ALUOP <= "111111";
					end if;
						
					-- NOTA: B Never ????
					
					when "1001" => -- B not equal
						if (not(icc(2)) = '1') then -- not z
							pcSource <= "10"; 
							wrEnRF <= '0'; 
							rfsource <= "00"; 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
							
					when "0001" => -- B on equal
						if (icc(2) = '1') then -- z
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
							
					when "1001" => -- B Greather
						if (not(icc(2) or (icc(3) xor icc(1))) = '1') then --
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "0010" => -- B less or equal
						if (icc(2) or (icc(3) xor icc(1)) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "1011" => -- B greater or equal
						if (not(icc(3) xor icc(1)) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
							
					when "0011" => -- B less
						if (icc(3) xor icc(1) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "1100" => -- B greater unsigned
						if (not(icc(0) or icc(2)) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
				
					when "0100" => -- B less or equal unsigned
						if (icc(0) or icc(2) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "1101" => -- B on carry clear
						if (not(0) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
				
					when "0101" => -- B on carry set
						if (icc(0) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "1110" => -- B on positive
						if (not(icc(3)) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "0110" => -- B on negative
						if (icc(3) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "1111" => -- B on overflow carry
						if (not(icc(1)) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when "0111" => -- B on overflow set
						if (icc(1) = '1') then -- 
							pcSource <= "10";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						else
							pcSource <= "11";
							wrEnRF <= '0'; 
							rfsource <= "00"; -- 
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111";
						end if;
					
					when others => -- Not Implemented
							pcSource <= "00";
							wrEnRF <= '0';
							rfsource <= "00";
							rfsest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111"; 
					end case;
				end if;
			end if;
		end if;
					
		------LOAD and STORE
		
		------Sethi
		
		------Call
		
		--- Modificar los otros
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
				when "111100" => --SAVE
					ALUOP <= "000110";
				when others => 
					ALUOP <= "111111";
			end case;
		end if;	
	end process;
					

end Behavioral;

