--------------------------------------------------------------------------------
-- Company:       The Ohio State University
-- Engineer:      Arvin Ignaci <ignaci.1@osu.edu>
--                Alex Whitman <whitman.97@osu.edu>
--
-- Create Date:   08:06:46 04/18/2018
-- Design Name:   
-- Module Name:   test - behavior
-- Project Name:  ece3561_proj3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: elevator
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT elevator
    PORT(
         UP_REQ : IN  std_logic_vector(2 downto 0);
         DN_REQ : IN  std_logic_vector(3 downto 1);
         GO_REQ : IN  std_logic_vector(3 downto 0);
         POC : IN  std_logic;
         SYSCLK : IN  std_logic;
         FLOOR_IND : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    -- Inputs
    signal UP_REQ : std_logic_vector(2 downto 0) := (others => '0');
    signal DN_REQ : std_logic_vector(3 downto 1) := (others => '0');
    signal GO_REQ : std_logic_vector(3 downto 0) := (others => '0');
    signal POC : std_logic := '1';
    signal SYSCLK : std_logic := '0';
    
    -- Outputs
    signal FLOOR_IND : std_logic_vector(3 downto 0) := (others => '0');

    -- Clock period definitions
    constant SYSCLK_period : time := 500 ms;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
    uut: elevator PORT MAP (
          UP_REQ => UP_REQ,
          DN_REQ => DN_REQ,
          GO_REQ => GO_REQ,
          POC => POC,
          SYSCLK => SYSCLK,
          FLOOR_IND => FLOOR_IND );
    

    -- Clock process definitions
    SYSCLK_process: process
    begin
        SYSCLK <= '0';
        wait for SYSCLK_period/2;
        SYSCLK <= '1';
        wait for SYSCLK_period/2;
    end process;


    -- Stimulus process
    stim_proc: process
    begin		

        wait for SYSCLK_period;

        -- insert stimulus here
        POC <= '0';

        wait;
    end process;

END;
