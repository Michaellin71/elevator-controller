----------------------------------------------------------------------------------
-- Company:        The Ohio State University
-- Engineer:       Arvin Ignaci <ignaci.1@osu.edu>
--                 Alex Whitman <whitman.97@osu.edu>
-- 
-- Create Date:    12:56:43 04/18/2018 
-- Design Name: 
-- Module Name:    elevator - Behavioral 
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

entity elevator is
    Port ( UP_REQ : in  STD_LOGIC_VECTOR (2 downto 0);
           DN_REQ : in  STD_LOGIC_VECTOR (3 downto 1);
           GO_REQ : in  STD_LOGIC_VECTOR (3 downto 0);
           POC : in  STD_LOGIC;
           SYSCLK : in  STD_LOGIC;
           FLOOR_IND : out  STD_LOGIC_VECTOR (3 downto 0));
end elevator;

architecture Behavioral of elevator is

    component controller
    port(
        UP_REQ : in  STD_LOGIC_VECTOR(2 downto 0);
        DN_REQ : in  STD_LOGIC_VECTOR(3 downto 1);
        GO_REQ : in  STD_LOGIC_VECTOR(3 downto 0);
        POC : in  STD_LOGIC;
        SYSCLK : in  STD_LOGIC;
        FLOOR_IND : out  STD_LOGIC_VECTOR(3 downto 0);
        EMVUP : out  STD_LOGIC;
        EMVDN : out  STD_LOGIC;
        EOPEN : out  STD_LOGIC;
        ECLOSE : out  STD_LOGIC;
        ECOMP : in  STD_LOGIC;
        EF : in  STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component simulator
    port(
         POC : in  STD_LOGIC;
         SYSCLK : in  STD_LOGIC;
         EMVUP : in  STD_LOGIC;
         EMVDN : in  STD_LOGIC;
         EOPEN : in  STD_LOGIC;
         ECLOSE : in  STD_LOGIC;
         ECOMP : buffer STD_LOGIC;
         EF : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    --Controller Inputs
    signal ECOMP : STD_LOGIC;
    signal EF : STD_LOGIC_VECTOR(3 downto 0);

    --Controller Outputs
    signal EMVUP : STD_LOGIC;
    signal EMVDN : STD_LOGIC;
    signal EOPEN : STD_LOGIC;
    signal ECLOSE : STD_LOGIC;

begin

    con: controller port map(
        UP_REQ => UP_REQ,
        DN_REQ => DN_REQ,
        GO_REQ => GO_REQ,
        POC => POC,
        SYSCLK => SYSCLK,
        FLOOR_IND => FLOOR_IND,
        EMVUP => EMVUP,
        EMVDN => EMVDN,
        EOPEN => EOPEN,
        ECLOSE => ECLOSE,
        ECOMP => ECOMP,
        EF => EF );
        
    sim: simulator port map(
        POC => POC,
        SYSCLK => SYSCLK,
        EMVUP => EMVUP,
        EMVDN => EMVDN,
        EOPEN => EOPEN,
        ECLOSE => ECLOSE,
        ECOMP => ECOMP,
        EF => EF );

end Behavioral;

