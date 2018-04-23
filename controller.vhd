----------------------------------------------------------------------------------
-- Company:        The Ohio State University
-- Engineers:      Arvin Ignaci <ignaci.1@osu.edu>
--                 Alex Whitman <whitman.97@osu.edu>
-- 
-- Create Date:    12:34:57 04/04/2018 
-- Design Name:    ElevatorController
-- Module Name:    controller - Behavioral 
-- Project Name:   ece3561_proj3
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

entity controller is
    Port ( UP_REQ : in  STD_LOGIC_VECTOR (2 downto 0);
           DN_REQ : in  STD_LOGIC_VECTOR (3 downto 1);
           GO_REQ : in  STD_LOGIC_VECTOR (3 downto 0);
           POC : in  STD_LOGIC;
           SYSCLK : in  STD_LOGIC;
           FLOOR_IND : out  STD_LOGIC_VECTOR (3 downto 0);
           EMVUP : out  STD_LOGIC;
           EMVDN : out  STD_LOGIC;
           EOPEN : out  STD_LOGIC;
           ECLOSE : out  STD_LOGIC;
           ECOMP : in  STD_LOGIC;
           EF : in  STD_LOGIC_VECTOR (3 downto 0));
end controller;

architecture Behavioral of controller is
    signal AB_MASK : UNSIGNED(3 downto 0); -- bitmask for floors above current
    signal BL_MASK : UNSIGNED(3 downto 0); -- bitmask for floors below current
    signal ALL_REQ : STD_LOGIC_VECTOR(3 downto 0); -- stores whether or not there is a
                                           -- request for each floor
    signal AB_REQ : STD_LOGIC; -- request above current floor
    signal BL_REQ : STD_LOGIC; -- request below current floor
    
    signal EF_UP_REQ : STD_LOGIC; -- up request at current floor
    signal EF_DN_REQ : STD_LOGIC; -- down request at current floor
    signal EF_GO_REQ : STD_LOGIC; -- go request at current floor
    
    signal EF_DOOR : STD_LOGIC; -- door needs to be opened at current floor
    
    signal QOPEN : STD_LOGIC; -- door is open
    signal QUP : STD_LOGIC; -- elevator travelling up
    signal QDOWN : STD_LOGIC; -- elevator travelling down
    
begin
    -- Internal signals
    BL_MASK <= unsigned(EF) - 1;
    AB_MASK <= not(BL_MASK) sll 1;
    ALL_REQ <= ('0' & UP_REQ) or (DN_REQ & '0') or GO_REQ;
    AB_REQ <= '1' when (UNSIGNED(ALL_REQ) and AB_MASK) > 0 else '0';
    BL_REQ <= '1' when (UNSIGNED(ALL_REQ) and BL_MASK) > 0 else '0';
    
    EF_UP_REQ <= '1' when UNSIGNED(EF and ('0' & UP_REQ)) > 0 else '0';
    EF_DN_REQ <= '1' when UNSIGNED(EF and (DN_REQ & '0')) > 0 else '0';
    EF_GO_REQ <= '1' when UNSIGNED(EF and GO_REQ) > 0 else '0';
    
    EF_DOOR <= EF_GO_REQ or (EF_UP_REQ and not(QDOWN)) or (EF_DN_REQ and not(QUP));
    
    -- Output
    FLOOR_IND <= EF; -- (honestly, why is this even here?)
    
    -- Handle active clock edge
    process (SYSCLK)
    begin
        if SYSCLK'event and SYSCLK='1' then
        
            -- Clear outputs
            EMVUP <= '0';
            EMVDN <= '0';
            EOPEN <= '0';
            ECLOSE <= '0';
            
            -- Power-on clear (clear elevator state)
            if POC='1' then
                QOPEN <= '0';
                QUP <= '0';
                QDOWN <= '0';
                
            -- Elevator has no running operations
            elsif ECOMP='1' then
                
                if QOPEN='1' then
                
                    if EF_DOOR='0' then
                        ECLOSE <= '1';
                        QOPEN <= '0';
                        
                    end if;
                else
                    if EF_DOOR='1' then
                        EOPEN <= '1';
                        QOPEN <= '1';
                        
                    elsif AB_REQ='1' and QDOWN='0' then
                        EMVUP <= '1';
                        QUP <= '1';
                        
                    elsif BL_REQ='1' and QUP='0' then
                        EMVDN <= '1';
                        QDOWN <= '1';
                    
                    else
                        QUP <= '0';
                        QDOWN <= '0';
                        
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;

