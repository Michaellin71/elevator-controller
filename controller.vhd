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
           EMVUP : out  STD_LOGIC;
           EMVDN : out  STD_LOGIC;
           EOPEN : out  STD_LOGIC;
           ECLOSE : out  STD_LOGIC;
           ECOMP : in  STD_LOGIC;
           EF : in  STD_LOGIC_VECTOR (3 downto 0));
end controller;

architecture Behavioral of controller is

begin


end Behavioral;

