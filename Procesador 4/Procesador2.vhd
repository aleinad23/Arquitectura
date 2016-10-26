
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Procesador4 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  Result : out  STD_LOGIC_VECTOR(31 downto 0));
end Procesador4;

architecture Behavioral of Procesador4 is

COMPONENT ALU
	PORT(
		A : in  STD_LOGIC_VECTOR (31 downto 0);
          B : in  STD_LOGIC_VECTOR (31 downto 0);
          carry: in STD_LOGIC;
          ALUOP : in  STD_LOGIC_VECTOR (5 downto 0);
          ALUResult : out  STD_LOGIC_VECTOR (31 downto 0)
		);
	END COMPONENT;
	
COMPONENT PSR
	Port ( 
	  rst : in  STD_LOGIC;
	  clk : in  STD_LOGIC;
	  nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
	  ncwp : in  STD_LOGIC;
	  cwp : out  STD_LOGIC;
	  carry : out  STD_LOGIC
			);
	END COMPONENT;
	
COMPONENT ExtSign
	PORT(
		Ext_in : IN std_logic_vector(12 downto 0);          
		Ext_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Multiplexor
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		selector : IN std_logic;          
		Mux_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;	

COMPONENT ProgramCounter
	PORT(
		PC_in : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		PC_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Sumador
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);          
		C : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		DataWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT UC
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
COMPONENT PSRModifier
	PORT(
		ALUResult : IN std_logic_vector(31 downto 0);
		oper131 : IN std_logic;
		oper231 : IN std_logic;
		rst : IN std_logic;
		ALUOP : IN std_logic_vector(5 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
COMPONENT Win_man
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rsd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		ncwp : OUT std_logic;
		srs1 : OUT std_logic_vector(5 downto 0);
		srs2 : OUT std_logic_vector(5 downto 0);
		srd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

signal snpc,ssumador,spc,sins,scrs1,scrs2,smux,ses,Resultado : std_logic_vector(31 downto 0);
signal scu,nrs1,nrs2,nrd : std_logic_vector(5 downto 0);
signal snzvc : std_logic_vector(3 downto 0);
signal scwp,sncwp,scarry : std_logic;

begin

Inst_Win_man: Win_man PORT MAP(
		rs1 => sins(18 downto 14),
		rs2 => sins(4 downto 0),
		rsd => sins(29 downto 25),
		op => sins(31 downto 30),
		op3 => sins(24 downto 19),
		cwp => scwp,
		ncwp => sncwp,
		srs1 => nrs1,
		srs2 => nrs2,
		srd => nrd
	);

Inst_PSR: PSR PORT MAP (
    rst => reset, 
    clk => clk, 
    nzvc => snzvc, 
    ncwp => sncwp, 
    cwp => scwp, 
    carry => scarry
    );
	 
Inst_PSRModifier: PSRModifier PORT MAP(
		ALUResult => Resultado,
		oper131 => scrs1(31),
		oper231 => scrs2(31),
		rst => reset,
		ALUOP => scu,
		nzvc => snzvc
	);


Inst_ALU: ALU PORT MAP(
		A => scrs1,
		B => smux,
		carry => scarry,
		ALUOP => scu,
		ALUResult => Resultado
	);

Inst_ExtSign: ExtSign PORT MAP(
		Ext_in => sins(12 downto 0),
		Ext_out => ses
	);

Inst_Multiplexor: Multiplexor PORT MAP(
		A => scrs2,
		B => ses,
		selector => sins(13),
		Mux_out => smux
	);
	
Inst_ProgramCounter: ProgramCounter PORT MAP(
		PC_in => snpc,
		rst => reset,
		clk => clk,
		PC_out => spc
	);

Inst_NProgramCounter: ProgramCounter PORT MAP(
		PC_in => ssumador,
		rst => reset,
		clk => clk,
		PC_out => snpc
	);
	
Inst_Sumador: Sumador PORT MAP(
		A => x"00000001",
		B => snpc,
		C => ssumador
	);
	
Inst_instructionMemory: instructionMemory PORT MAP(
		address => spc,
		reset => reset,
		outInstruction => sins
	);
	
Inst_RF: RF PORT MAP(
		rs1 => nrs1,
		rs2 => nrs2,
		rd => nrd,
		rst => reset,
		DataWrite => Resultado,
		Crs1 => scrs1,
		Crs2 => scrs2
	);
	
Inst_UC: UC PORT MAP(
		op => sins(31 downto 30),
		op3 => sins(24 downto 19),
		ALUOP => scu
	);
	
Result<=Resultado;
end Behavioral;

