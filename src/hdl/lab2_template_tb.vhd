--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2017 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : sevenSegDecoder_tb.vhd (TEST BENCH)
--| AUTHOR(S)     : Lt Col Trimble & Jack Culp
--| CREATED       : 02/10/2024
--| DESCRIPTION   : This file simply provides a template for all VHDL assignments
--|
--| DOCUMENTATION : Include all documentation statements in README.md Lt. Col Trimble helped me flip my test case bits.
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std, unisim
--|    Files     : LIST ANY DEPENDENCIES
--|
--+----------------------------------------------------------------------------
--|
--| NAMING CONVENSIONS :
--|
--|    xb_<port name>           = off-chip bidirectional port ( _pads file )
--|    xi_<port name>           = off-chip input port         ( _pads file )
--|    xo_<port name>           = off-chip output port        ( _pads file )
--|    b_<port name>            = on-chip bidirectional port
--|    i_<port name>            = on-chip input port
--|    o_<port name>            = on-chip output port
--|    c_<signal name>          = combinatorial signal
--|    f_<signal name>          = synchronous signal
--|    ff_<signal name>         = pipeline stage (ff_, fff_, etc.)
--|    <signal name>_n          = active low signal
--|    w_<signal name>          = top level wiring signal
--|    g_<generic name>         = generic
--|    k_<constant name>        = constant
--|    v_<variable name>        = variable
--|    sm_<state machine type>  = state machine type definition
--|    s_<signal name>          = state name
--|
--+----------------------------------------------------------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
  
entity sevenSegDecoder_tb is
end sevenSegDecoder_tb;

architecture test_bench of sevenSegDecoder_tb is 

    --signal d0 : std_logic; -- this is done to make life much easier, it reduces the number of underscores when 
    --signal d1 : std_logic; -- you go and write out the truth tables.
    --signal d2 : std_logic;
    --signal d3 : std_logic;
    
    signal c_Sa : std_logic;
    signal c_Sb : std_logic;
    signal c_Sc : std_logic;
    signal c_Sd : std_logic;
    signal c_Se : std_logic;
    signal c_Sf : std_logic;
    signal c_Sg : std_logic;
    
	
  -- declare the component of your top-level design unit under test (UUT)
  component sevenSegDecoder is
    port(
	   i_D : in std_logic_vector (3 downto 0);
       o_S : out std_logic_vector (6 downto 0)
    );	
  end component;

  -- signals for the UUT
  signal w_sw : std_logic_vector (3 downto 0);
  signal w_seg : std_logic_vector (6 downto 0);
  
begin
	-- PORT MAPS ----------------------------------------
    -- map ports for any component instances (port mapping is like wiring hardware)
	uut_inst : sevenSegDecoder port map (
	  -- use comma (not a semicolon)
	  -- no comma on last line
      i_D => w_sw,
	  o_S => w_seg
	);
		
	-- Test Plan Process --------------------------------
	-- Implement the test plan here.  Body of process is continuous from time = 0  
	test_process : process 
	begin
		-- assign 0 to w_sw, wait, then check the value of seg
		w_sw <= x"0"; wait for 10 ns;
		  assert w_seg = "1000000" report "error on x0" severity failure; -- good
		  
		w_sw <= x"1"; wait for 10 ns;
           assert w_seg = "1111001" report "error on x0" severity failure; -- good
           
        w_sw <= x"2"; wait for 10 ns;
           assert w_seg = "0100100" report "error on x0" severity failure; -- this one is bad so i commented it out to check if this is where it was getting hung up
           
        w_sw <= x"3"; wait for 10 ns;
           assert w_seg = "0110000" report "error on x0" severity failure;  
            
		w_sw <= x"4"; wait for 10 ns;
           assert w_seg = "0011001" report "error on x0" severity failure;-- this one is bad so i commented it out to check if this is where it was getting hung up
           
        w_sw <= x"5"; wait for 10 ns;
           assert w_seg = "0010010" report "error on x0" severity failure;
              
        w_sw <= x"6"; wait for 10 ns;
           assert w_seg = "0000010" report "error on x0" severity failure;
              
        w_sw <= x"7"; wait for 10 ns;
           assert w_seg = "1111000" report "error on x0" severity failure;   
           
        w_sw <= x"8"; wait for 10 ns;
           assert w_seg = "0000000" report "error on x0" severity failure;
                     
       w_sw <= x"9"; wait for 10 ns;
          assert w_seg = "0011000" report "error on x0" severity failure;
          
       w_sw <= x"A"; wait for 10 ns;
          assert w_seg = "0001000" report "error on x0" severity failure;
          
       w_sw <= x"B"; wait for 10 ns;
          assert w_seg = "0000011" report "error on x0" severity failure;  
           
       w_sw <= x"C"; wait for 10 ns;
          assert w_seg = "0100111" report "error on x0" severity failure;
          
       w_sw <= x"D"; wait for 10 ns;
          assert w_seg = "0100001" report "error on x0" severity failure;
             
       w_sw <= x"E"; wait for 10 ns;
          assert w_seg = "0000110" report "error on x0" severity failure;
             
       w_sw <= x"F"; wait for 10 ns;
          assert w_seg = "0001110" report "error on x0" severity failure;   
                                     

        -- Remaining test cases
          
          wait; -- wait forever
	end process;	
	-----------------------------------------------------	
	
end test_bench;
