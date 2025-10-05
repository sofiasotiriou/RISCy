--author: Sofia-Zoi Sotiriou p3210192

library ieee;
use ieee.std_logic_1164.all;

entity processor is 
	generic ( 
		n : integer := 16;
		addressSize : integer := 3 
	);
	port (
		keyData, fromData, instruction : in std_logic_vector (15 downto 0);
		clock1, clock2 : in std_logic;
		printEnable, keyEnable, DataWriteFlag : out std_logic;
		dataAD, toData, printCode, printData : out std_logic_vector (15 downto 0);
		instructionAddress : out std_logic_vector (15 downto 0);
		regOut  : out std_logic_vector (143 downto 0)
	);
end processor;

architecture structure of processor is 
	component trapUnit is 
		port (
			opcode : in std_logic_vector (3 downto 0);
			eor : out std_logic
		);
	end component;
	
	component jrSelector 	
		generic ( 
			n : integer := 16
		);
		port( 
			jumpAD, branchAD, pcp2add : in std_logic_vector (n-1 downto 0);
			opcode : in std_logic_vector (1 downto 0);
			result: out std_logic_vector (n-1 downto 0)
		);
	end component;
	
	component mux2to1 is 
		generic ( 
			n : integer := 16
		);
		 port (
			  sel : in std_logic;
			  dataA, dataB : in std_logic_vector(n-1 downto 0);
			  output : out std_logic_vector(n-1 downto 0)
		 );
	end component;
	
	component programCounter is
		 port (
			input    : in  STD_LOGIC_VECTOR(15 downto 0);
			clock, enable  : in  STD_LOGIC;
			output   : out STD_LOGIC_VECTOR(15 downto 0)
		 );
	end component;
	
	component mem_wb is 
		generic (
			n: INTEGER := 16;
			addressSize : INTEGER := 3
		);
		port (
			clock : in std_logic;
			result : in std_logic_vector (n-1 downto 0);
			regAddr : in std_logic_vector (addressSize-1 downto 0);
			writeData : out std_logic_vector (n-1 downto 0);
			writeAddr : out std_logic_vector (addressSize-1 downto 0)
		);
	end component; 
	
	component if_id is 
		generic ( 
			n : integer := 16
		);
		port( 
			pcIn, inInstruction : in std_logic_vector (n-1 downto 0);
			clock, enable, flush : in std_logic;
			pcOut, outInstruction: out std_logic_vector (n-1 downto 0)
		);
	end component;
		
	component forwarder is 
		generic ( 
			addressSize : integer := 3
		);
		port ( 
			adr1, adr2, exmem, memwb : in std_logic_vector (addressSize-1 downto 0);
			out1, out2 : out std_logic_vector(1 downto 0)
		);
	end component; 

	component selector is 
		generic ( 
			n : integer := 16
		);
		port ( 
			op : in std_logic_vector(1 downto 0);
			regFile, mem, wb : in std_logic_vector (n-1 downto 0);
			output : out std_logic_vector(n-1 downto 0)
		);
	end component;

	component alu_control is
		port (
		  opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
		  func   : in  STD_LOGIC_VECTOR(2 downto 0);
		  aluOperation  : out STD_LOGIC_VECTOR(3 downto 0)
		);
	end component;

	component sign_extender is
		port ( 
			  input : in std_logic_vector(5 downto 0);
			  output : out std_logic_vector(15 downto 0)
		);
	end component;

	component ALU16 is 
		port (
			 a, b : in std_logic_vector (15 downto 0);
			 opcode : in std_logic_vector (2 downto 0);
			 endResult : out std_logic_vector (15 downto 0);
			 overflow : out std_logic
		);
	end component;
			
	component hazardUnit is 
		port ( 
			jr, isJump, wasJump, mustBranch : in std_logic;
			flush, wasJumpOut : out std_logic;
			opcodeJR : out std_logic_vector(1 downto 0)
		);
	end component;
	
	--Different from the control circuit which is a component of the ALU 
	component controlUnit is
		port (
			opcode : in std_logic_vector (3 downto 0);
			func : in std_logic_vector (2 downto 0);
			flush : in std_logic; 
			isBranch, isJReg, isJtype, isLoad, isMFPC, isRtype, isRead, isStore, isWrite : out std_logic
		);
	end component;
	
	--8 registers
	component reg_file is 
		port (
				clock : in std_logic;
				read1AD, read2AD, write1AD: in std_logic_vector(2 downto 0);
				write1 : in std_logic_vector(15 downto 0);
				OUTall : out std_logic_vector(127 downto 0); 
				read1, read2 : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component id_ex is 
		generic (
			n : integer := 16;
			addressSize : integer := 3 
		);
		port ( 
			clock, inEOR, inWasJumpOut, inJump, inJR, inBranch, inR, inMFPC, inLW, inSW, inReadDigit, inPrintDigit : in std_logic;
			inALUfunc : in std_logic_vector(3 downto 0);
			inR1, inR2, inImmediate16 : in std_logic_vector(n-1 downto 0);
			inR1address, inR2address : in std_logic_vector(addressSize-1 downto 0); 
			inJumpShortAddr  : in std_logic_vector(11 downto 0);
			
			outEOR, outWasJumpOut, outJump, outJR, outBranch, outR, outMFPC, outLW, outSW, outReadDigit, outPrintDigit : out std_logic;
			outALUfunc : out std_logic_vector(3 downto 0);
			outR1, outR2, outImmediate16 : out std_logic_vector(n-1 downto 0);
			outR1address, outR2address : out std_logic_vector(addressSize-1 downto 0); 
			outJumpShortAddr  : out std_logic_vector(11 downto 0)
		);
	end component;
		
	component ex_mem is 
		generic (
			n: INTEGER := 16;
			addressSize : INTEGER := 3
		);
		port (
			clock, inPrintDigit, inReadDigit, inWriteEnable, inLW : in std_logic;
			inR2, inALUres : in std_logic_vector (n-1 downto 0);
			inAddr : in std_logic_vector (addressSize-1 downto 0);
			
			outPrintDigit, outReadDigit, outWriteEnable, outLW : out std_logic;
			outR2, outALUres : out std_logic_vector (n-1 downto 0);
			outAddr : out std_logic_vector (addressSize-1 downto 0)
		);
	end component; 
	
	
	component jump_add is
		 port ( 
				jumpAD: in std_logic_vector(11 downto 0);
				instrP2AD : in std_logic_vector(15 downto 0);
				EjumpAD : out std_logic_vector(15 downto 0)
		 );
	end component;
	
	-- Signal Declarations 
	signal exMemOutLW, flushC, ControllerOutTypeR, IdExMFPCout, IdExRout, PCenable, IdExEORout, trapOut, flushHazToCont, 
				 exMemOutReadDigit, carryOut, IdExBranchOut, hazardOutWasJump, ControllerOutJR, ControllerOutJump, ControllerOutIsBranch,
					ControllerOutisLoad, ControllerOutisMFPC, ControllerOutRead, ControllerOutStore, ControllerOutWrite, IdExJRout, IdExLoadOut, 
						IdExStoreOut, IdExReadOut, IdExPrintOut, exMemOutPrintDigit, exMemOutWriteEnable, mustBranch, IdExJOout, IdExJumpOutput : std_logic;
						
	signal forwarderOut1, forwarderOut2, opcodeHazardToJR : std_logic_vector (1 downto 0);
						
	signal muxToRegFile, memWBoutAddress, exMemOutAdress, IdExOutR1address, IdExOutR2address  : std_logic_vector (2 downto 0);

	signal ALUcontrolOutput, IdExOutALUfunc : std_logic_vector (3 downto 0);
	
	signal IdExOutJumpShortAddress : std_logic_vector ( 11 downto 0);
	
	signal pcOut, IfIdOut, IfIdOutInstruction, jrResult, muxToSelectors, signExtenderOut, memWBoutData, IdExOutReg1, IdExOutReg2, selector1Out, JRjumpAddr,
				selector2Out, ALUin1, ALUin2, IdExOutImmediate16,  exMemALURes, ALUoutput, exMemOutR2, muxToMux, regFileToIdEx1, regFileToIdEx2 : std_logic_vector (n-1 downto 0);
				
	signal regFileAll : std_logic_vector(127 downto 0);
	
begin 
	--EX/MEM to MEM/WB multiplexers 
	mem_wbResult1: mux2to1 port map (exMemOutReadDigit, exMemALURes, keyData, muxToMux);   
	mem_wbResult2: mux2to1 port map (exMemOutLW, muxToMux, fromData, muxToSelectors);   
	
	-- Trap unit
	trap: trapUnit port map (IfIdOutInstruction(15 downto 12), trapOut);    

	-- JR Selector 
	JRjumpAd: jump_add port map (IdExOutJumpShortAddress, IfIdOut, JRjumpAddr);
	jrSel: jrSelector port map (JRjumpAddr, IdExOutImmediate16, IfIdOut, opcodeHazardToJR, jrResult); 			

	-- PC register 
	PCenable <= not(trapOut or IdExEORout);
	PC: programCounter port map (jrResult, clock1, PCenable, pcOut);  
	
	--MEM/WB register 
	mem_wbReg: mem_wb port map (clock1, muxToSelectors, exMemOutAdress, memWBoutData, memWBoutAddress);
	
	-- IF/ID register 
	if_idReg: if_id port map (pcOut, instruction, clock1, '1', '0', IfIdOut, IfIdOutInstruction);    

	--Forwarder
	forwardUnit: forwarder port map (IdExOutR1address, IdExOutR2address, exMemOutAdress, memWBoutAddress, forwarderOut1, forwarderOut2); 
	
	--ALU contro unit 
	ALUcontroller: alu_control port map (IfIdOutInstruction(15 downto 12), IfIdOutInstruction(2 downto 0), ALUcontrolOutput);   
	
	-- Sign extender
	signExtender: sign_extender port map ( IfIdOutInstruction(5 downto 0), signExtenderOut);    
	
	--Selector units for the two ALU inputs 
	selector1: selector port map (forwarderOut1, IdExOutReg1, muxToSelectors, memWBoutData, selector1Out);   
	selector2: selector port map (forwarderOut2, IdExOutReg2, muxToSelectors, memWBoutData, selector2Out);	

	-- Multiplexers between the selectors and the ALU
	ALUinput1: mux2to1 port map (IdExMFPCout, IfIdOut, selector1Out, ALUin1); 		
	ALUinput2: mux2to1 port map (IdExRout, selector2Out, IdExOutImmediate16, ALUin2);			
	
	--ALU unit 
	ALUunit: ALU16 port map (ALUin1, ALUin2, IdExOutALUfunc(2 downto 0), ALUoutput, carryOut);

	--Hazard detection unit 
	HazardMustBranch: mustBranch <= carryOut and IdExBranchOut;
	hazard: hazardUnit port map (ControllerOutJR, ControllerOutJump, '0', mustBranch, flushHazToCont, hazardOutWasJump, opcodeHazardToJR);   
	
	--Control Unit 
	flushController: flushC <= IdExEORout or flushHazToCont;
	controller: controlUnit port map (IfIdOutInstruction(15 downto 12), IfIdOutInstruction(2 downto 0), flushC, ControllerOutIsBranch, ControllerOutJR, 
										ControllerOutJump, ControllerOutisLoad, ControllerOutisMFPC, ControllerOutTypeR, ControllerOutRead, ControllerOutStore, 
										ControllerOutWrite);  

	--Multiplexer feeding the regFile the second read address 
	dataToReg: mux2to1 generic map ( n=> 3)
							 port map (ControllerOutTypeR, IfIdOutInstruction(5 downto 3), IfIdOutInstruction(8 downto 6), muxToRegFile); 
	--Register file 
	registerFile: reg_file port map (clock2, IfIdOutInstruction(8 downto 6), muxToRegFile, memWBoutAddress, memWBoutData, regFileAll, regFileToIdEx1, regFileToIdEx2);  
	
	--ID/EX register 
	--the inputs in order are 			isEOR     wasJumpOut         		isJump           isJR					isBranch						isTypeR				isMFPC  
	id_exReg: id_ex port map(clock1, trapOut, hazardOutWasJump, ControllerOutJump, ControllerOutJR, ControllerOutIsBranch, ControllerOutTypeR, ControllerOutisMFPC,
								--isLoadWord 			isStoreWord 			readDigit 			writeDigit 				ALUfunction 		reg1				reg2
							ControllerOutisLoad, ControllerOutStore, ControllerOutRead, ControllerOutWrite, ALUcontrolOutput, regFileToIdEx1, regFileToIdEx2, 
							--immediate16			--Reg1Address					--Reg2Address		--jumpShortAddress
							signExtenderOut, IfIdOutInstruction(8 downto 6), muxToRegFile, IfIdOutInstruction(11 downto 0), 
							IdExEORout, IdExJOout, IdExJumpOutput,
							IdExJRout, IdExBranchOut, IdExRout,	IdExMFPCout, IdExLoadOut, IdExStoreOut, IdExReadOut, IdExPrintOut, IdExOutALUfunc, IdExOutReg1, 
							IdExOutReg2, IdExOutImmediate16, IdExOutR1address, IdExOutR2address, IdExOutJumpShortAddress);	
																																			
	--EX/MEM register 
	--the inputs in order are 				printDigit    readDigit    writeEnable   loadWord      reg2       ALUresult   inputAddress
	ex_memReg: ex_mem port map(clock1, IdExPrintOut, IdExReadOut, IdExStoreOut, IdExLoadOut, IdExOutReg2, ALUoutput, IdExOutR2address, 
								exMemOutPrintDigit, exMemOutReadDigit, exMemOutWriteEnable, exMemOutLW, exMemOutR2, exMemALURes, exMemOutAdress);     	
	
	printEnable <= exMemOutPrintDigit;
	DataWriteFlag <= exMemOutWriteEnable;
	dataAD <= exMemOutR2;
	printCode <= exMemOutR2;
	keyEnable <= exMemOutReadDigit;
	toData <= exMemALURes;
	printData <= exMemALURes;
	regOut(143 downto 16) <= regFileAll;
	regOut(15 downto 0) <= pcOut;
	instructionAddress <= pcOut;
	
end structure;