--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:08:07 04/18/2017
-- Design Name:   
-- Module Name:   /home/basso/Bureau/Projet_Info/vhdl/RISC/testbancRegistres.vhd
-- Project Name:  RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bancRegistres
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testbancRegistres IS
END testbancRegistres;
 
ARCHITECTURE behavior OF testbancRegistres IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bancRegistres
    PORT(
         adrA : IN  std_logic_vector(3 downto 0);
         adrB : IN  std_logic_vector(3 downto 0);
         adrW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(15 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal adrA : std_logic_vector(3 downto 0) := (others => '0');
   signal adrB : std_logic_vector(3 downto 0) := (others => '0');
   signal adrW : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bancRegistres PORT MAP (
          adrA => adrA,
          adrB => adrB,
          adrW => adrW,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for CLK_period*2;--writing of R3=(0x1000) 	
		RST <= '1';
		W <= '1';
		DATA <= x"1000";
		adrW <= "0011";
      wait for CLK_period; --writing of R7=(0x2000)
		W <= '1';
		DATA <= x"2000";
		adrW <= "0111";	
      wait for CLK_period; --reading of R3 & R7
		W <= '0';
		adrA <= "0011";
		adrB <= "0111";
		wait for CLK_period; --reset in the end
		RST <= '0';
		
		--test simultaneous read and write operations
		wait for CLK_period;
		RST <= '1';
		wait for CLK_period;
		W <= '1';
		DATA <= x"3000";
		adrW <= "0101";
		adrA <= "0101";
		adrB <= "0101";
      -- insert stimulus here 

      wait;
   end process;

END;
