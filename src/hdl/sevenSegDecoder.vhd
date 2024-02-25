----------------------------------------------------------------------------------
-- Company: USAFA 281 T5
-- Engineer: Jack Culp
-- 
-- Create Date: 02/20/2024 01:53:51 PM
-- Design Name: 
-- Module Name: sevenSegDecoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Documentation Statement, C/Shin checked my k map for g and d to make sure that I had done that step coorectly. Lt Col Trimble helped me correctly do my test cases where I had them reversed c/ mock explained that letters must be capitalized for the test cases to work. 

-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity sevenSegDecoder is
    Port ( i_D : in STD_LOGIC_VECTOR (3 downto 0);
           o_S : out STD_LOGIC_VECTOR (6 downto 0));
       
end sevenSegDecoder;

architecture Behavioral of sevenSegDecoder is
    signal d0 : std_logic; -- this is done to make life much easier, it reduces the number of underscores when 
    signal d1 : std_logic; -- you go and write out the truth tables.
    signal d2 : std_logic;
    signal d3 : std_logic;
    
    signal c_Sa : std_logic;
    signal c_Sb : std_logic;
    signal c_Sc : std_logic;
    signal c_Sd : std_logic;
    signal c_Se : std_logic;
    signal c_Sf : std_logic;
    signal c_Sg : std_logic;
    
    
begin
    d0 <= i_D(0);
    d1 <= i_D(1);
    d2 <= i_D(2);
    d3 <= i_D(3);
    
    
    -- Logic for the turning on of each segment in the seven segment display
        -- segment a
    c_Sa <= '1' when ((i_D = x"1") or (i_D = x"4") or (i_D = x"B") or (i_D = x"C") or (i_D = x"D")) else '0';-- removed to use second method( not(d1) and d2 and (not (d0) or d3)  ) or (d0 and not(d3) and not (d2)); -- good
    o_S(0) <= c_Sa;
    
    -- segment b
    c_Sb <= '1' when ((i_D = x"5") or (i_D = x"6") or (i_D = x"B") or (i_D = x"C") or(i_D = x"E") or (i_D = x"F")) else '0';-- removed to try the second method(d1 and d0) or (not(d0) and d2 and not(d1)); -- good
    o_S(1) <= c_Sb;
    
    -- segment c
    c_Sc <= '1' when ((i_D = x"2") or (i_D = x"C") or ( i_D = x"E") or  ( i_D = x"F")) else '0';-- removed to use second method (d1 and d3) or (not(d0) and not(d1) and d2 and d3) or (d0 and d1 and not(d2) and not (d3)); -- help i think this is good but my math says otherwise
    o_S(2) <= c_Sc;
    
    -- segment d
    -- c_Sd <=  (d0 and d1 and d2 )or (not(d2)) or (not(d0) and not(d1) and d2 and d3) or (not(d0) and d1 and not(d2) and d3); -- removed for debugging
    c_Sd <= '1' when ((i_D =x"1") or (i_D = x"4") or (i_D = x"7") or (i_D = x"9") or (i_D = x"A") or (i_D = x"F")) else '0';
    o_S(3) <= c_Sd;
    
    -- segment e
    c_Se <= '1' when ((i_D = x"1") or (i_D = x"3") or (i_D = x"4") or (i_D = x"5") or (i_D = x"7") or (i_D = x"9")) else '0';-- removed to use second method (d0 and not d3) or (not d0 and not d2 and d3) or (d0 and not d1 and not d1);
    o_S(4) <= c_Se;
    
    
    -- segment f
    c_Sf <= '1' when ((i_D = x"1") or (i_D = x"2")or (i_D = x"3") or (i_D = x"7") or (i_D = x"c") or (i_D = x"d")) else '0';-- removed to try second method (not(d2) and not(d3) and (d0 or d1)) or (not(d1) and d2 and d3) or (d0 and d1 and not(d3));
    o_S(5) <= c_Sf;
    
    -- segment g
    -- c_Sg <= (not(d0) and not(d2) and not (d3)) or (d0 and d1 and d2 and not(d3)); -- temporally removed for debugging
    
    c_Sg <= '1' when ((i_D = x"0") or (i_D = x"1") or (i_D = x"7")) else '0';     
    o_S(6) <= c_Sg;
    
    
    
    
    
    
    
    
     
    
    
    

end Behavioral;
