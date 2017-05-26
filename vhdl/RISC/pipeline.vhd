----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:03 05/02/2017 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

entity pipeline is
    Port ( COPin : in  STD_LOGIC_VECTOR (7 downto 0);
           Ain : in  STD_LOGIC_VECTOR (15 downto 0);
           Bin : in  STD_LOGIC_VECTOR (15 downto 0);
           Cin : in  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC ;
			  alea : in STD_LOGIC ;
           COPout : out  STD_LOGIC_VECTOR (7 downto 0);
           Aout : out  STD_LOGIC_VECTOR (15 downto 0);
           Bout : out  STD_LOGIC_VECTOR (15 downto 0);
           Cout : out  STD_LOGIC_VECTOR (15 downto 0));
end pipeline;

architecture Behavioral of pipeline is

begin
	process(CLK)
	begin
		if (CLK='1') then
			if alea='1' then
				COPout <= x"00";
			else
				COPout <= COPin;
			end if;
			Aout <= Ain;
			Bout <= Bin;
			Cout <= Cin;
		end if;
	end process;
end Behavioral;

