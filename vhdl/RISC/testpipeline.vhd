--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:29:48 05/02/2017
-- Design Name:   
-- Module Name:   /home/basso/Bureau/Projet_Info/vhdl/RISC/testpipeline.vhd
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
 
ENTITY testpipeline IS
END testpipeline;
 
ARCHITECTURE behavior OF testpipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
         COPin : IN  std_logic_vector(7 downto 0);
         Ain : IN  std_logic_vector(15 downto 0);
         Bin : IN  std_logic_vector(15 downto 0);
         Cin : IN  std_logic_vector(15 downto 0);
         COPout : OUT  std_logic_vector(7 downto 0);
         Aout : OUT  std_logic_vector(15 downto 0);
         Bout : OUT  std_logic_vector(15 downto 0);
         Cout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal COPin : std_logic_vector(7 downto 0) := (others => '0');
   signal Ain : std_logic_vector(15 downto 0) := (others => '0');
   signal Bin : std_logic_vector(15 downto 0) := (others => '0');
   signal Cin : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal COPout : std_logic_vector(7 downto 0);
   signal Aout : std_logic_vector(15 downto 0);
   signal Bout : std_logic_vector(15 downto 0);
   signal Cout : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          COPin => COPin,
          Ain => Ain,
          Bin => Bin,
          Cin => Cin,
          COPout => COPout,
          Aout => Aout,
          Bout => Bout,
          Cout => Cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
