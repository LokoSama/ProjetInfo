--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:27:09 04/25/2017
-- Design Name:   
-- Module Name:   /home/basso/Bureau/Projet_Info/vhdl/RISC/testdecode.vhd
-- Project Name:  RISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decode
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
 
ENTITY testdecode IS
END testdecode;
 
ARCHITECTURE behavior OF testdecode IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decode
    PORT ( ins_di : in STD_LOGIC_VECTOR (31 downto 0);
           COPout : out  STD_LOGIC_VECTOR (7 downto 0);
           Aout : out  STD_LOGIC_VECTOR (15 downto 0);
           Bout : out  STD_LOGIC_VECTOR (15 downto 0);
           Cout : out  STD_LOGIC_VECTOR (15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal COPin : std_logic_vector(7 downto 0) := (others => '0');
   signal Ain : std_logic_vector(7 downto 0) := (others => '0');
   signal Bin : std_logic_vector(7 downto 0) := (others => '0');
   signal Cin : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal COPout : std_logic_vector(7 downto 0);
   signal Aout : std_logic_vector(15 downto 0);
   signal Bout : std_logic_vector(15 downto 0);
   signal Cout : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decode PORT MAP (
          ins_di => COPin & Ain & Bin & Cin,
          COPout => COPout,
          Aout => Aout,
          Bout => Bout,
          Cout => Cout
        );
		  
	COPin <= x"01" after 100 ns, x"06" after 200 ns, x"07" after 300 ns, x"08" after 400 ns;
	Ain <= x"07" after 100 ns;
	Bin <= x"42" after 100 ns;
	Cin <= x"1f" after 100 ns;
END;
