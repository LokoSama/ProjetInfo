--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:11 05/02/2017
-- Design Name:   
-- Module Name:   /home/basso/Bureau/Projet_Info/vhdl/RISC/processeur.vhd
-- Project Name:  RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--------------------------------------------------------------------------------
LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY processeur IS
END processeur;
 
ARCHITECTURE behavior OF processeur IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 
	COMPONENT bram16
		GENERIC (
			init_file : String := "none";
			adr_width : Integer := 11);
		PORT(
			-- System
			sys_clk : IN std_logic;
			sys_rst : IN std_logic;
			-- Master
			di : OUT std_logic_vector(15 downto 0);
			we : IN std_logic;
			a : IN std_logic_vector(15 downto 0);
			do : IN std_logic_vector(15 downto 0)
			);
	END COMPONENT;
	
	COMPONENT bram32
		GENERIC (
			init_file : String := "none";
			adr_width : Integer := 11);
		PORT(
			-- System
			sys_clk : IN std_logic;
			sys_rst : IN std_logic;
			-- Master
			di : OUT std_logic_vector(31 downto 0);
			we : IN std_logic;
			a : IN std_logic_vector(15 downto 0);
			do : IN std_logic_vector(31 downto 0)
			);
	END COMPONENT;
	 
	--CLOCK
	signal CLK : std_logic;
   constant CLK_period : time := 100 ns;
	
	--AUX
	constant padding : std_logic_vector(14 downto 0) := (others => '0');
	 
   --SIGNAUX
	signal ins_di : std_logic_vector(31 downto 0) := (others => '0');
	signal ins_a : std_logic_vector(15 downto 0);
	
	signal data_a : std_logic_vector(15 downto 0);		--adr to read/write in memory
	signal data_di : std_logic_vector(15 downto 0);		--value at address data_a in memory
	signal data_we : std_logic;								--write order (true if 1)
	signal data_do : std_logic_vector (15 downto 0);
	
	signal devnull : std_logic_vector(15 downto 0);
	
   signal lidi_COPin : std_logic_vector(7 downto 0);
	signal lidi_Ain : std_logic_vector(15 downto 0);
	signal lidi_Bin : std_logic_vector(15 downto 0);
	signal lidi_Cin : std_logic_vector(15 downto 0);
	signal lidi_COPout : std_logic_vector(7 downto 0);
	signal lidi_Aout : std_logic_vector(15 downto 0);
	signal lidi_Bout : std_logic_vector(15 downto 0);
	signal lidi_Cout : std_logic_vector(15 downto 0);
	
	signal diex_Bin : std_logic_vector(15 downto 0);
	signal diex_Cin : std_logic_vector(15 downto 0);
	signal diex_COPout : std_logic_vector(7 downto 0);
	signal diex_Aout : std_logic_vector(15 downto 0);
	signal diex_Bout : std_logic_vector(15 downto 0);
	signal diex_Cout : std_logic_vector(15 downto 0);
	
	signal exmem_Bin : std_logic_vector(15 downto 0);
	signal exmem_COPout : std_logic_vector(7 downto 0);
	signal exmem_Aout : std_logic_vector(15 downto 0);
	signal exmem_Bout : std_logic_vector(15 downto 0);
	
	signal memre_COPout : std_logic_vector(7 downto 0);
	signal memre_Aout : std_logic_vector(15 downto 0);
	signal memre_Bout : std_logic_vector(15 downto 0);
	
	signal reg_w : std_logic ;
	signal reg_adrB : std_logic_vector(3 downto 0);
	signal reg_qa : std_logic_vector(15 downto 0);
	signal reg_qb : std_logic_vector(15 downto 0);
	signal reg_DATA : std_logic_vector(15 downto 0);
	signal reg_adrW : std_logic_vector(3 downto 0);
	
	signal alu_ctrl : std_logic_vector(1 downto 0);
	signal alu_S : std_logic_vector(15 downto 0);
	signal alu_flags : std_logic_vector (3 downto 0);
	
BEGIN

	--TODO:  mapper les devnull sur "open" et/ou x"0000"
	--			faire les jumps
	--			faire les fonctions du compilo
	
	--NOTE:	on a implémenté un compteur d'instructions et grâce au BRAM32 du prof
	--			on peut lire et exécuter le code dans notrecode.hex

	laram: bram16 PORT MAP (
			-- System
			sys_clk => CLK,
			sys_rst => '1', --pas le reset
			-- Master
			di => data_di,
			we => data_we,
			a => data_a,
			do => data_do
	    );
		 
	lecode: bram32
		GENERIC MAP (
			init_file => "notrecode.hex"
		)
		PORT MAP (
			-- System
			sys_clk => CLK,
			sys_rst => '1', --pas le reset
			-- Master
			di => ins_di,
			we => '0',
			a => ins_a,
			do => x"00000000"
	    );

	-- Instantiate the Decode
   decodeur: entity work.decode PORT MAP (
          ins_di => ins_di,	--TODO
          COPout => lidi_COPin,
          Aout => lidi_Ain,
          Bout => lidi_Bin,
          Cout => lidi_Cin
        );
		  
	pipeline_lidi: entity work.pipeline PORT MAP (
          COPin => lidi_COPin,
          Ain => lidi_Ain,
          Bin => lidi_Bin,
          Cin => lidi_Cin,
			 CLK => CLK,
          COPout => lidi_COPout,
          Aout => lidi_Aout,
          Bout => lidi_Bout,
          Cout => lidi_Cout
        );

	reg_w <= '1' when ((memre_COPout >= x"01" and memre_COPout <= x"07") or (memre_COPout >= x"09" and memre_COPout <= x"0D")) else
				'0';
	reg_adrW <= memre_Aout(3 downto 0);
	reg_DATA <= data_di when memre_COPout = x"07" else
					memre_Bout;
	
	reg_adrB <= lidi_Bout (3 downto 0) when lidi_COPout = x"08" else
					lidi_Cout (3 downto 0);

	-- Instantiate the Register bench
   reg: entity work.bancRegistres PORT MAP (
          adrA => lidi_Bout (3 downto 0),
          adrB => reg_adrB,
          adrW => reg_adrW,
          W => reg_W,
          DATA => reg_DATA,
          RST => '1', --TODO
          CLK => CLK,
          QA => reg_qa,
          QB => reg_qb
        );
	
	-- COP et AFC faits et fonctionnels, un "Undefined" a pop sans raison entre lidi_Bout et diex_Bin
	diex_Bin <= reg_qa when ((lidi_COPout >= x"01" and lidi_COPout <= x"05") or (lidi_COPout >= x"09" and lidi_COPout <= x"0D")) else
					reg_qb when lidi_COPout = x"08" else
					lidi_Bout;
					
	diex_Cin <= reg_qb when ((lidi_COPout >= x"01" and lidi_COPout <= x"04") or (lidi_COPout >= x"09" and lidi_COPout <= x"0D")) else
					lidi_Cout;
					
   pipeline_diex: entity work.pipeline PORT MAP (
          COPin => lidi_COPout,
          Ain => lidi_Aout,
          Bin => diex_Bin,
          Cin => diex_Cin,
			 CLK => CLK,
          COPout => diex_COPout,
          Aout => diex_Aout,
          Bout => diex_Bout,
          Cout => diex_Cout
        );
	
	alu_ctrl <= "01" when diex_COPout = x"01" else	--ADD
					"01" when diex_COPout = x"02" else	--MUL
					"10" when ((diex_COPout = x"03") or (diex_COPout >= x"09" and diex_COPout <= x"0D")) else	--SOU
					"11" when diex_COPout = x"04";		--DIV
					
-- Instantiate the ALU
   alulu: entity work.ALU PORT MAP (
          A => diex_Bout,
          B => diex_Cout,
          S => alu_S,
          Ctrl_Alu => alu_ctrl,
          Flags => alu_flags			--NOZC (3210)
        );

	exmem_Bin <= alu_S when (diex_COPout >= x"01" and diex_COPout <= x"04") else
					 (padding & alu_flags(1)) when diex_COPout = x"09" else													-- EQU	:	 		  Z = 1
					 (padding & alu_flags(3)) when diex_COPout = x"0A" else													-- INF	: N = 1
					 (padding & ( alu_flags(3) or alu_flags(1) ) ) when diex_COPout = x"0B" else						-- INFEQU: N = 1 || Z = 1
					 (padding & ( not(alu_flags(3)) and not (alu_flags(1)) )) when diex_COPout = x"0C" else		-- SUP	: N = 0 && Z = 0
					 (padding & ( not(alu_flags(3))) ) when diex_COPout = x"0D" else										-- SUPEQU: N = 0
					 diex_Bout;						
	
   pipeline_exmem: entity work.pipeline PORT MAP (
          COPin => diex_COPout,
          Ain => diex_Aout,
          Bin => exmem_Bin,
          Cin => x"0000",
			 CLK => CLK,
          COPout => exmem_COPout,
          Aout => exmem_Aout,
          Bout => exmem_Bout,
          Cout => devnull
        );
		  
	data_a <= exmem_Bout when exmem_COPout = x"07" else	--LOAD : get address from B
				 exmem_Aout when exmem_COPout = x"08";			--STORE: get address from A
	data_we <= '1' when exmem_COPout = x"08" else	--when STORE is called, we write to the memory
				  '0';
	data_do <= exmem_Bout;

   pipeline_memre: entity work.pipeline PORT MAP (
          COPin => exmem_COPout,
          Ain => exmem_Aout,
          Bin => exmem_Bout,
          Cin => x"0000",
			 CLK => CLK,
          COPout => memre_COPout,
          Aout => memre_Aout,
          Bout => memre_Bout,
          Cout => devnull
        );
		  
		  
		  
--	ins_di <= x"06034242" after 200 ns, x"06094343" after 300 ns, x"050103ff" after 400 ns,
--				 x"01020309" after 700 ns, x"03040903" after 800 ns, x"02050303" after 900 ns;
--	R3 <- 4242
--	R9 <- 4343
--	R1 <- R3
--	R2 <- R3 + R9
--	R4 <- R9 - R3
--	R5 <- R3 * R3


--	ins_di <= x"070812ff" after 200 ns, x"08ffff08" after 500 ns;

--	ins_di <= x"06054545" after 200 ns, x"06064848" after 500 ns, x"06074545" after 800 ns,
--				 x"09010507" after 1100 ns, x"0C020605" after 1500 ns, x"0C030506" after 1800 ns;
--
	data_di <= x"4242";


	process
	begin
		wait until CLK'event and CLK='1';
		ins_a <= std_logic_vector(to_unsigned(to_integer(IEEE.numeric_std.unsigned(ins_a)) + 1,16));
	end process;

	-- Clock process definitions
   CLK_process :process
   begin
		CLK <= '1';
		wait for CLK_period/2;
		CLK <= '0';
		wait for CLK_period/2;
   end process;

END;
