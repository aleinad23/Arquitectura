
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Procesador6 is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  Result : out  STD_LOGIC_VECTOR(31 downto 0));
end Procesador6;

architecture Behavioral of Procesador6 is

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
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
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
		RegO7 : OUT std_logic_vector(5 downto 0);
		srd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MuxRegister
	PORT(
		rsd : IN std_logic_vector(5 downto 0);
		RegO7 : IN std_logic_vector(5 downto 0);
		rfDest : IN std_logic;          
		nRds : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		we : IN std_logic;
		DataWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crd : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT ExtSign
	PORT(
		Ext_in : IN std_logic_vector(12 downto 0);          
		Ext_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MuxAlu
	PORT(
		crs2 : IN std_logic_vector(31 downto 0);
		imm : IN std_logic_vector(31 downto 0);
		selector : IN std_logic;          
		op2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT UC
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		op2 : IN std_logic_vector(2 downto 0);
		icc : IN std_logic_vector(3 downto 0);
		cond : IN std_logic_vector(3 downto 0);          
		ALUOP : OUT std_logic_vector(5 downto 0);
		rfdest : OUT std_logic;
		rfsource : OUT std_logic_vector(1 downto 0);
		wrEnMem : OUT std_logic;
		pcSource : OUT std_logic_vector(1 downto 0);
		wrEnRF : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		carry : IN std_logic;
		ALUOP : IN std_logic_vector(5 downto 0);          
		ALUResult : OUT std_logic_vector(31 downto 0)
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
	
	COMPONENT PSR
	PORT(
		rst : IN std_logic;
		clk : IN std_logic;
		nzvc : IN std_logic_vector(3 downto 0);
		ncwp : IN std_logic;          
		cwp : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0);
		carry : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT SEU22
	PORT(
		Ext_in : IN std_logic_vector(21 downto 0);          
		Ext_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT SEU30
	PORT(
		Ext_in : IN std_logic_vector(29 downto 0);          
		Ext_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MuxPC
	PORT(
		PCdisp30 : IN std_logic_vector(31 downto 0);
		PCdisp22 : IN std_logic_vector(31 downto 0);
		PC1 : IN std_logic_vector(31 downto 0);
		Address : IN std_logic_vector(31 downto 0);
		PCSource : IN std_logic_vector(1 downto 0);          
		PCout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT DataMemory
	PORT(
		address : IN std_logic_vector(4 downto 0);
		dato : IN std_logic_vector(31 downto 0);
		WE : IN std_logic;
		rst : IN std_logic;          
		DataToMem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MuxRFSource
	PORT(
		DataMemory : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		RFSource : IN std_logic_vector(1 downto 0);          
		DataOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal snpc,spc,smpc,ss_1,sim,smrfs,scrs1,scrs2,scrd,ses,sma,salu,sseu22,sseu30,ss_2,ss_3,sdm : std_logic_vector(31 downto 0);
signal snrs1,snrs2,srd,sro7_wm,snrd,saluop_uc : std_logic_vector(5 downto 0);
signal sicc_psr,snzvc : std_logic_vector(3 downto 0);
signal srfs_uc,spcs_uc : std_logic_vector(1 downto 0);
signal scwp_pcr,sncwp_wm,srfd_uc,swerf_uc,swem_uc,sc_psr : std_logic;

begin

	Inst_ProgramCounter: ProgramCounter PORT MAP(
		PC_in => snpc,
		rst => reset,
		clk => clk,
		PC_out => spc
	);
	
	Inst_NProgramCounter: ProgramCounter PORT MAP(
		PC_in => smpc,
		rst => reset,
		clk => clk,
		PC_out => snpc
	);
	
	Inst_Sumador_1: Sumador PORT MAP(
		A => x"00000001",
		B => snpc,
		C => ss_1
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => spc,
		reset => reset,
		outInstruction => sim
	);
	
	Inst_Win_man: Win_man PORT MAP(
		rs1 => sim(18 downto 14),
		rs2 => sim(4 downto 0),
		rsd => sim(29 downto 25),
		op => sim(31 downto 30),
		op3 => sim(24 downto 19),
		cwp => scwp_pcr,
		ncwp => sncwp_wm,
		srs1 => snrs1,
		srs2 => snrs2,
		RegO7 => sro7_wm,
		srd =>srd 
	);
	
	Inst_MuxRegister: MuxRegister PORT MAP(
		rsd => srd,
		RegO7 => sro7_wm,
		rfDest => srfd_uc,
		nRds => snrd
	);
	
	Inst_RF: RF PORT MAP(
		rs1 => snrs1,
		rs2 => snrs2,
		rd => snrd,
		rst => reset,
		we => swerf_uc,
		DataWrite => smrfs,
		Crs1 => scrs1,
		Crd => scrd,
		Crs2 =>scrs2 
	);
	
	Inst_ExtSign: ExtSign PORT MAP(
		Ext_in => sim(12 downto 0),
		Ext_out => ses
	);
	
	Inst_MuxAlu: MuxAlu PORT MAP(
		crs2 => scrs2,
		imm => ses,
		selector => sim(13),
		op2 => sma
	);
	
	Inst_UC: UC PORT MAP(
		op => sim(31 downto 30),
		op3 => sim(24 downto 19),
		op2 => sim(24 downto 22),
		icc => sicc_psr,
		cond => sim(28 downto 25),
		ALUOP => saluop_uc,
		rfdest => srfd_uc,
		rfsource => srfs_uc,
		wrEnMem => swem_uc,
		pcSource => spcs_uc,
		wrEnRF => swerf_uc
	);
	
	Inst_ALU: ALU PORT MAP(
		A => scrs1,
		B => sma,
		carry => sc_psr,
		ALUOP => saluop_uc,
		ALUResult =>salu  
	);
	
	Inst_PSRModifier: PSRModifier PORT MAP(
		ALUResult => salu,
		oper131 => scrs1(31),
		oper231 => sma(31),
		rst => reset,
		ALUOP => saluop_uc,
		nzvc => snzvc 
	);
	
	Inst_PSR: PSR PORT MAP(
		rst => reset,
		clk => clk,
		nzvc => snzvc,
		ncwp => sncwp_wm,
		cwp => scwp_pcr,
		icc => sicc_psr,
		carry => sc_psr 
	);
	
	Inst_SEU22: SEU22 PORT MAP(
		Ext_in => sim(21 downto 0),
		Ext_out =>sseu22 
	);
	
	Inst_SEU30: SEU30 PORT MAP(
		Ext_in => sim(29 downto 0),
		Ext_out => sseu30
	);
	
	Inst_Sumador_2: Sumador PORT MAP(
		A => spc,
		B => sseu22,
		C => ss_2
	);
	
	Inst_Sumador_3: Sumador PORT MAP(
		A => sseu30,
		B => spc,
		C => ss_3
	);
	
	Inst_MuxPC: MuxPC PORT MAP(
		PCdisp30 => ss_3,
		PCdisp22 => ss_2,
		PC1 => ss_1,
		Address => salu,
		PCSource => spcs_uc,
		PCout => smpc
	);
	
	Inst_DataMemory: DataMemory PORT MAP(
		address => salu(4 downto 0),
		dato => scrd,
		WE => swem_uc,
		rst => reset,
		DataToMem => sdm
	);
	
	Inst_MuxRFSource: MuxRFSource PORT MAP(
		DataMemory => sdm,
		AluResult => salu,
		PC => spc,
		RFSource => srfs_uc,
		DataOut => smrfs
	);

Result <= smrfs;
		
end Behavioral;

