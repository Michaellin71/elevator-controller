--------------------------------------------------------------------------------
-- Company:       The Ohio State University
-- Engineers:     Arvin Ignaci <ignaci.1@osu.edu>
--                Alex Whitman <whitman.97@osu.edu>
--
-- Create Date:   11:39:06 04/07/2018
-- Design Name:   ElevatorController
-- Module Name:   simulator
-- Project Name:  ece3561_proj3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: controller
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY simulator IS
END simulator;
 
ARCHITECTURE behavior OF simulator IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT controller
    PORT(
         UP_REQ : IN  std_logic_vector(2 downto 0);
         DN_REQ : IN  std_logic_vector(3 downto 1);
         GO_REQ : IN  std_logic_vector(3 downto 0);
         POC : IN  std_logic;
         SYSCLK : IN  std_logic;
         FLOOR_IND : OUT  std_logic_vector(3 downto 0);
         EMVUP : OUT  std_logic;
         EMVDN : OUT  std_logic;
         EOPEN : OUT  std_logic;
         ECLOSE : OUT  std_logic;
         ECOMP : IN  std_logic;
         EF : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal UP_REQ : std_logic_vector(2 downto 0) := (others => '0');
   signal DN_REQ : std_logic_vector(3 downto 1) := (others => '0');
   signal GO_REQ : std_logic_vector(3 downto 0) := (others => '0');
   signal POC : std_logic := '0';
   signal SYSCLK : std_logic := '0';
   signal ECOMP : std_logic := '0';
   signal EF : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal FLOOR_IND : std_logic_vector(3 downto 0);
   signal EMVUP : std_logic;
   signal EMVDN : std_logic;
   signal EOPEN : std_logic;
   signal ECLOSE : std_logic;

   -- Clock period definitions
   constant SYSCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: controller PORT MAP (
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
          EF => EF
        );

   -- Clock process definitions
   SYSCLK_process :process
   begin
		SYSCLK <= '0';
		wait for SYSCLK_period/2;
		SYSCLK <= '1';
		wait for SYSCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for SYSCLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
