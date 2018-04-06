----------------------------------------------------------------------------------
-- Company:        The Ohio State University
-- Engineers:      Arvin Ignaci <ignaci.1@osu.edu>
--                 Alex Whitman <whitman.97@osu.edu>
-- 
-- Create Date:    12:34:57 04/04/2018 
-- Design Name:    ElevatorController
-- Module Name:    controller - Behavioral 
-- Project Name:   ECE 3561 Project 3
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
    signal AB_MASK : unsigned(3 downto 0); -- bitmask for floors above current
    signal BL_MASK : unsigned(3 downto 0); -- bitmask for floors below current
    signal ALL_REQ : unsigned(3 downto 0); -- stores whether or not there is a
                                           -- request for each floor
    signal AB_REQ : std_logic; -- request above current floor
    signal BL_REQ : std_logic; -- request below current floor
    
    signal EF_UP_REQ : std_logic; -- up request at current floor
    signal EF_DN_REQ : std_logic; -- down request at current floor
    signal EF_GO_REQ : std_logic; -- go request at current floor
    
    signal QDOOR : std_logic; -- 0 when door closed, 1 if door open
    signal QUP   : std_logic; -- elevator travelling up
    signal QDOWN : std_logic; -- elevator travelling down
begin
    -- Internal signals
    BL_MASK <= unsigned(EF) - 1;
    AB_MASK <= not(BL_MASK) sll 1;
    ALL_REQ <= unsigned(('0' & UP_REQ) or (DN_REQ & '0') or GO_REQ);
    AB_REQ <= '1' when (ALL_REQ and AB_MASK) > 0 else '0';
    BL_REQ <= '1' when (ALL_REQ and BL_MASK) > 0 else '0';
    
    EF_UP_REQ <= '1' when unsigned(EF and ('0' & UP_REQ)) > 0 else '0';
    EF_DN_REQ <= '1' when unsigned(EF and (DN_REQ & '0')) > 0 else '0';
    EF_GO_REQ <= '1' when unsigned(EF and GO_REQ) > 0 else '0';
    
    -- Output
    FLOOR_IND <= EF; -- (honestly, why is this even here?)
    
    -- Handle active clock edge
    process (SYSCLK)
    begin
        if SYSCLK'event and SYSCLK='1' then
        
            -- Clear outputs
            EOPEN <= '0';
            ECLOSE <= '0';
            EMVUP <= '0';
            EMVDN <= '0';
            
            -- Power-on clear (clear state)
            if POC='1' then
                QDOOR <= '0';
                QUP <= '0';
                QDOWN <= '0';
                
            -- Elevator has no running operations
            elsif ECOMP='1' then
                
                -- Close door if open
                if QDOOR='1' then
                    ECLOSE <= '1';
                    QDOOR <= '0';
                
                -- Service 'go' request at current floor
                elsif EF_GO_REQ='1' then
                    QDOOR <= '1';
                    
                -- Elevator is travelling up
                elsif QUP='1' then
                    
                    -- Up request at current floor
                    if EF_UP_REQ='1' then
                        QDOOR <= '1';
                    
                    -- Request above current floor
                    elsif AB_REQ='1' then
                    
                    -- Request below current floor
                    elsif BL_REQ='1' then
                        QUP <= '0';
                        QDOWN <= '1';
                        
                    -- No requests
                    else
                        QUP <= '0';
                    end if;
                    
                -- Elevator is travelling down
                elsif QDOWN='1' then
                    
                    -- Up request at current floor
                    if EF_DN_REQ='1' then
                        QDOOR <= '1';
                    
                    -- Request below current floor
                    elsif BL_REQ='1' then
                    
                    -- Request above current floor
                    elsif AB_REQ='1' then
                        QUP <= '1';
                        QDOWN <= '0';
                        
                    -- No requests
                    else
                        QDOWN <= '0';
                    end if;
                    
                -- Elevator is standing still
                else
                    
                    if EF_UP_REQ='1' then
                        QUP <= '1';
                    elsif EF_DN_REQ='1' then
                        QDOWN <= '1';
                    end if;
                    
                end if;
                
                -- Set output based on state
                EOPEN <= QDOOR;
                EMVUP <= QUP and not(QDOWN);
                EMVDN <= QDOWN and not(QUP);
                -- NOTE: ECLOSE is set separately, only when necessary
                
            end if;
        end if;
    end process;
end Behavioral;

