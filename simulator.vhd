----------------------------------------------------------------------------------
-- Company:        The Ohio State University
-- Engineers:      Arvin Ignaci <ignaci.1@osu.edu>
--                 Alex Whitman <whitman.97@osu.edu>
-- 
-- Create Date:    12:40:17 04/11/2018 
-- Design Name: 
-- Module Name:    simulator - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simulator is
    Port ( POC : in  STD_LOGIC;
           SYSCLK : in  STD_LOGIC;
           EMVUP : in  STD_LOGIC;
           EMVDN : in  STD_LOGIC;
           EOPEN : in  STD_LOGIC;
           ECLOSE : in  STD_LOGIC;
           ECOMP : buffer STD_LOGIC;
           EF : out  STD_LOGIC_VECTOR (3 downto 0));
end simulator;

architecture Behavioral of simulator is
    -- Internal signals
    signal EDOOR : std_logic; -- asserted for door command from controller
    signal EINPUT : std_logic; -- asserted for inputs from controller
    signal EFLOOR : unsigned(3 downto 0); -- current floor as unsigned int
    
    signal COUNTER : unsigned(2 downto 0); -- counter for delay operations
    
begin
    EDOOR <= EOPEN or ECLOSE;
    EINPUT <= EMVUP or EMVDN or EDOOR;
    EF <= std_logic_vector(EFLOOR);

    process (SYSCLK)
    begin
        if SYSCLK'event and SYSCLK='1' then
        
            -- Power-on clear
            if POC='1' then
                EFLOOR <= "0001";   -- reset floor to 1
                ECOMP <= '1';
                
            -- Ongoing operation
            elsif ECOMP='0' then
                if COUNTER="000" then
                    ECOMP <= '1';
                else
                    COUNTER <= COUNTER - 1;
                end if;
            
            -- Handle input from controller
            elsif EINPUT='1' then
                ECOMP <= '0';   -- start blocking operation
                
                if EDOOR='1' then
                    COUNTER <= "110";   -- set counter to 6
                else
                    COUNTER <= "100";   -- set counter to 4
                    if EMVUP='1' then
                        EFLOOR <= EFLOOR sll 1;
                    elsif EMVDN='1' then
                        EFLOOR <= EFLOOR srl 1;
                    end if;
                end if;

            end if;
        end if;
    end process;
end Behavioral;

