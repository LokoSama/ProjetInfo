----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:28:28 04/18/2017 
-- Design Name: 
-- Module Name:    bancRegistres - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bancRegistres is
    Port ( adrA : in  STD_LOGIC_VECTOR (3 downto 0);
           adrB : in  STD_LOGIC_VECTOR (3 downto 0);
           adrW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (15 downto 0);
           QB : out  STD_LOGIC_VECTOR (15 downto 0));
end bancRegistres;

architecture Behavioral of bancRegistres is
type bancReg is array (0 to 15) of STD_LOGIC_VECTOR (15 downto 0);
SIGNAL R: bancReg;
begin
	process(R, adrA, adrB, W, adrW, DATA)
	begin
		QA <= R(to_integer(IEEE.numeric_std.unsigned(adrA)));
		QB <= R(to_integer(IEEE.numeric_std.unsigned(adrB)));
		if W = '1' then
			if adrW = adrA then
				QA <= DATA;
			end if;
			if adrW = adrB then
				QB <= DATA;
			end if;
		end if;
	end process;
	
	process
	begin
		wait until CLK'event and CLK='1';
		if RST = '0' then
			-- tout mettre à 0
			for I in 0 to 15 loop
				R(I) <= (others => '0');
			end loop;
		else 
			if W = '1' then
				-- on écrit DATA dans le registre adrW
				R(to_integer(IEEE.numeric_std.unsigned(adrW))) <= DATA;
				
				-- checks for simultaneous reading and writing on the same register
				-- if it happens, return the new value (DATA)
--				if adrW = adrA and adrW = adrB then
--					QA <= DATA;
--					QB <= DATA;
--				elsif adrW = adrB then
--					QA <= R(to_integer(IEEE.numeric_std.unsigned(adrA)));
--					QB <= DATA;
--				elsif adrW = adrA then
--					QA <= DATA;
--					QB <= R(to_integer(IEEE.numeric_std.unsigned(adrB)));
--				else
--					QA <= R(to_integer(IEEE.numeric_std.unsigned(adrA)));
--					QB <= R(to_integer(IEEE.numeric_std.unsigned(adrB)));
--				end if;
			end if;
		end if;
	end process;
end Behavioral;

