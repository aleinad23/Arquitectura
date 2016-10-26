
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           carry: in STD_LOGIC;
           ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	process(A,B,ALUOP)
	begin
		case (ALUOP) is 
			when "000000" => --AND
				ALUResult <= A and B;
			when "000001" => --ANDn
				ALUResult <= not(A and B);
			when "000010" => --OR
				ALUResult <= A or B;
			when "000011" => --ORN
				ALUResult <= not(A or B);
			when "000100" => --XOR
				ALUResult <= A xor B;
			when "000101" => --XNOR
				ALUResult <= not(A xor B);
			when "000110" => --ADD
				ALUResult <= A + B;
			when "000111" => --SUB
				ALUResult <= A - B;
			when "001000" => --ADDcc
				ALUResult <= A + B;
			when "001001" => --ADDxcc
				ALUResult <= A + B + carry;
			when "001010" => --SUBcc
				ALUResult <= A - B;
			when "001011" => --SUBxcc
				ALUResult <= A - B + carry;
			when "001100" => --ANDcc
				ALUResult <= A and B;
			when "001101" => --ANDncc
				ALUResult <= not(A and B);
			when "001110" => --ORcc
				ALUResult <= A or B;
			when "001111" => --ORncc
				ALUResult <= not(A or B);
			when "010000" => --XORcc
				ALUResult <= A xor B;
			when "010001" => --XNORcc
				ALUResult <= not(A xor B);
			when "010010" => --ADDx
				ALUResult <= A + B + carry;
			when "010011" => --SUBx
				ALUResult <= A - B + carry;
			when "010100" => --SLL
				ALUResult <= to_stdlogicvector(to_bitvector(A)sll conv_integer(B));
			when "010101" => --SRL
				ALUResult <= to_stdlogicvector(to_bitvector(A)srl conv_integer(B));
			when others =>
				ALUResult <= "11111111111111111111111111111111";
		end case;
	end process;
	
end Behavioral;

