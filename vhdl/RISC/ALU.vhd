----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:18:32 03/28/2017 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (1 downto 0);
           Flags : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is
Signal N : integer ;
Signal Saux : std_logic_vector(15 downto 0) ;
Signal Sauxaux : std_logic_vector(31 downto 0) ;
begin
	process (A,B,Ctrl_Alu,N,Saux,Sauxaux)
	begin
		Flags <= (others => '0'); --reset des flags
		N <= 0;
		Sauxaux <= (others => '0');
		case Ctrl_Alu is
			when "00" => --ADD
				N <= to_integer(IEEE.numeric_std.signed(A)) + to_integer(IEEE.numeric_std.signed(B));
				Saux <= A + B;
			when "01" => -- MUL
				N <= to_integer(IEEE.numeric_std.signed(A)) * to_integer(IEEE.numeric_std.signed(B));
				Sauxaux <= A * B;
				Saux <= Sauxaux(15 downto 0);
			when "10" => -- SOU
				N <= to_integer(IEEE.numeric_std.signed(A)) - to_integer(IEEE.numeric_std.signed(B));
				Saux <= A - B;
			when "11" => -- DIV
				Saux <= (others => '0');
			when others => --NOT SUPPOSED TO HAPPEN
				Saux <= (others => '0');
		end case;
		--FLAGS (NOZC)
		if N < 0 then --Negative
			Flags(3) <= '1';
		end if;
		S <= Saux;
		
		-- Overflow for addition and substraction
		if Ctrl_Alu = "00" then
			Flags(2) <= ( A(15) and B(15) and not(Saux(15)) ) or ( not(A(15)) and not(B(15)) and Saux(15) );
		elsif Ctrl_Alu = "10" then
			Flags(2) <= ( not(A(15)) and B(15) and Saux(15) ) or ( A(15) and not(B(15)) and not(Saux(15)) );
		end if;
		if N = 0 then
			Flags(1) <= '1'; --Zero
		elsif (N >= 2**16 or N < 0) then
			Flags(0) <= '1'; --Carry
		end if;
	end process;
end Behavioral;

