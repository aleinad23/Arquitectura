
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
					--end if;
						
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
							
					when "1010" => -- B Greather
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
						if ((icc(2) or (icc(3) xor icc(1))) = '1') then -- 
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
						if ((icc(3) xor icc(1)) = '1') then -- 
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
						if ((icc(0) or icc(2)) = '1') then -- 
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
						if (not(icc(0)) = '1') then -- 
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
							rfdest <= '0';
							wrEnMem <= '0';
							ALUOP <= "111111"; 
					end case;
				end if;
			end if;
					
		------LOAD and STORE
		if(op = "11")then
			if(op3 = "000000")then --Load
				pcSource <= "00";
				wrEnRF <= '1';
				rfsource <= "00";
				rfdest <= '0';
				wrEnMem <= '0';
				ALUOP <= "000000";
			end if;
			if(op3 = "000100")then --Store
				pcSource <= "11";
				wrEnRF <= '0';
				rfsource <= "00";
				rfdest <= '0';
				wrEnMem <= '0';
				ALUOP <= "000000";
			end if;
		end if;
		
		------Sethi
		if(op = "00" and op2 = "100")then
			pcSource <= "11";
			wrEnRF <= '0'; 
			rfsource <= "01";
			rfdest <= '0';
			wrEnMem <= '0'; 
			ALUOP <= "111111";
		end if;
		
		------Call
		if(op = "01")then
			pcSource <= "01"; 
			wrEnRF <= '1'; 
			rfsource <= "10"; 
			rfdest <= '1'; 
			wrEnMem <= '0'; 
			ALUOP <= "111111"; 	
		end if;
		
		--- Modificar los otros
		if(op = "10")then
			case(op3) is
				when "000001" => --AND
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000000";
				when "000101" => --ANDn
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000001";
				when "000010" => --OR
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000010";
				when "000110" => --ORN
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000011";
				when "000011" =>  --XOR
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000100";
				when "000111" => --XNOR
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000101";
				when "000000" => --ADD
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000110";		
				when "000100" => --SUB
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000111";
				when "010000" => --ADDcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001000";
				when "011000" => --ADDXcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001001";
				when "010100" => --SUBcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001010";
				when "011100" => --SUBXcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001011";
				when "010001" => --ANDcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001100";
				when "010101" => --ANDncc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001101";
				when "010010" => --ORcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001110";
				when "010110" => --ORncc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "001111";
				when "010011" => --XORcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010000";
				when "010111" => --XNORcc
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010001";
				when "001000" => --ADDx
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010010";
				when "001100" => --SUBx
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010011";
				when "100101" => --SLL
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010100";
				when "100110" => --SRL
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "010101";
				when "111100" => --SAVE
					pcSource <= "11";
					wrEnRF <= '1';
					rfsource <= "01";
					rfdest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000110";
				when "111101"=> --Restore
					pcSource <= "11";
					wrEnRF <= '1';
					rfSource <= "01";
					rfDest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000110";
				when "111000"=> --Jump and Link
					pcSource <= "00";
					wrEnRF <= '1';
					rfSource <= "10";
					rfDest <= '0';
					wrEnMem <= '0';
					ALUOP <= "000110";
				when others => 
					ALUOP <= "111111";
			end case;
		end if;	
	end process;
					

end Behavioral;

