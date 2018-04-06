----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:34:57 04/04/2018 
-- Design Name: 
-- Module Name:    controller - Behavioral 
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
use IEEE.NUMERIC.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

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
           EMVUP : buffer  STD_LOGIC;
           EMVDN : buffer  STD_LOGIC;
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
begin
    BL_MASK <= - unsigned(EF);
    AB_MASK <= not(BL_MASK) sll 1;
    ALL_REQ <= UP_REQ or DN_REQ or GO_REQ;
    AB_REQ <= (ALL_REQ and AB_MASK) > 0;
    BL_REQ <= (ALL_REQ and BL_MASK) > 0;
    
    -- Handle active clock edge
    process (SYSCLK)
    begin
        if SYSCLK'event and SYSCLK='1' then
            -- Power-on clear
            if POC='1' then
                
            -- Elevator has no running operations
            elsif ECOMP='1' then
                
            end if;
        end if;
    end process;
end Behavioral;

