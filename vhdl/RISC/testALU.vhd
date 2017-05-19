--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:06:31 04/18/2017
-- Design Name:   
-- Module Name:   /home/basso/Bureau/Projet_Info/vhdl/RISC/testALU.vhd
-- Project Name:  RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY testALU IS
END testALU;
 
ARCHITECTURE behavior OF testALU IS 

    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         Ctrl_Alu : IN  std_logic_vector(1 downto 0);
         Flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal Ctrl_Alu : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal Flags : std_logic_vector(3 downto 0);
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          S => S,
          Ctrl_Alu => Ctrl_Alu,
          Flags => Flags
        );
	
	A <= x"f943" after 100 ns;
	B <= x"f243" after 100 ns;
	Ctrl_Alu <= "10" after 100 ns, "00" after 200 ns;

END;
