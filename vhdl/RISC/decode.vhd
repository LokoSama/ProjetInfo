----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:33 04/25/2017 
-- Design Name: 
-- Module Name:    decode - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decode is
    Port ( ins_di : in STD_LOGIC_VECTOR (31 downto 0);
           COPout : out  STD_LOGIC_VECTOR (7 downto 0);
           Aout : out  STD_LOGIC_VECTOR (15 downto 0);
           Bout : out  STD_LOGIC_VECTOR (15 downto 0);
           Cout : out  STD_LOGIC_VECTOR (15 downto 0));
end decode;

architecture Behavioral of decode is

signal COPin : STD_LOGIC_VECTOR (7 downto 0);
signal Ain : STD_LOGIC_VECTOR (7 downto 0);
signal Bin : STD_LOGIC_VECTOR (7 downto 0);
signal Cin : STD_LOGIC_VECTOR (7 downto 0);

begin
	
	COPin <= ins_di (31 downto 24);
	Ain <= ins_di (23 downto 16);
	Bin <= ins_di (15 downto 8);
	Cin <= ins_di ( 7 downto 0);
	
	process (COPin,Ain,Bin,Cin)
	begin
		COPout <= COPin ;
		case COPin is
			when x"06"  => --AFC
				Aout <= x"00" & Ain ;
				Bout <= Bin & Cin ;
				Cout <= x"0000";
			when x"07" => --LOAD
				Aout <= x"00" & Ain ;
				Bout <= Bin & Cin ;
				Cout <= x"0000";
			when x"08" => --STORE
				Aout <= Ain & Bin ;
				Bout <= x"00" & Cin;
				Cout <= x"0000";
			when others => --others 
				Aout <= x"00" & Ain ;
				Bout <= x"00" & Bin ;
				Cout <= x"00" & Cin ;
		end case;
	end process;
end Behavioral;

