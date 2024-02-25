--+----------------------------------------------------------------------------
--| 
--| COPYRIGHT 2018 United States Air Force Academy All rights reserved.
--| 
--| United States Air Force Academy     __  _______ ___    _________ 
--| Dept of Electrical &               / / / / ___//   |  / ____/   |
--| Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
--| 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
--| USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
--| 
--| ---------------------------------------------------------------------------
--|
--| FILENAME      : top_basys3.vhd
--| AUTHOR(S)     : Capt Phillip Warner & Jack Culp
--| CREATED       : 01/22/2018 Last modified 02/25/2024
--| DESCRIPTION   : This file implements the top level module for a BASYS 3 to utilize 
--|					a seven-segment decoder for displaying hex values on seven-segment 
--|					displays (7SD) according to 4-bit inputs provided by switches.
--|
--|					Inputs:  sw (3:0)  --> 4-bit signal to deternmine 7SD value to be diplayed
--|							 btnC	   --> activate 7SD
--|
--|					Output:  seg (6:0) --> 7-bit signal to activate the individual segments (active low)
--|							 an (3:0)  --> 4-bit signal to control which display turns on (active low)
--|
--|
--+----------------------------------------------------------------------------
--|
--| REQUIRED FILES :
--|
--|    Libraries : ieee
--|    Packages  : std_logic_1164, numeric_std
--|    Files     : sevenSegDecoder.vhd
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


entity top_basys3 is
	port(
		-- 7-segment display segments (cathodes CG ... CA)
		seg		:	out std_logic_vector(6 downto 0);  -- seg(6) = CG, seg(0) = CA

		-- 7-segment display active-low enables (anodes)
		an      :	out std_logic_vector(3 downto 0);

		-- Switches
		sw		:	in  std_logic_vector(3 downto 0);
		
		-- Buttons
		btnC	:	in	std_logic

	);
end top_basys3;

  -- declare the component of your top-level design unit under test (UUT)
architecture top_basys3_arch of top_basys3 is 
    component sevenSegDecoder is
        port(
            i_D : in STD_LOGIC_VECTOR (3 downto 0);
            o_S : out STD_LOGIC_VECTOR (6 downto 0)
        );
        end component sevenSegDecoder;
	
  -- create wire to connect button to 7SD enable (active-low)
       signal w_7SD_EN_n : std_logic; -- c/mock helped explain that a signal needed to be delcared before logic can be one on it
  
begin
	-- PORT MAPS ----------------------------------------
	sevSegDecoder_inst: sevenSegDecoder
    port map (
	--	Port map: wire your component up to the switches and seven-segment display cathodes
	   i_D => sw, --c/mock suggested assigning the entire element to the other vector as apposed to doing it manualy with a one to one
	   o_S => seg
	);
	-----------------------------------------------------	
	
	
	-- CONCURRENT STATEMENTS ----------------------------
	
	-- wire up active-low 7SD anode (active low) to button (active-high)
	   w_7SD_EN_n  <= not btnC;
	-- display 7SD 0 only when button pushed
	   an  <= (0 => w_7SD_EN_n, others => '1');
	-- other 7SD are kept off
	-----------------------------------------------------
	
end top_basys3_arch;
