library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  

entity mem_IO is
	port(
	NEXT_ONE, PREV_ONE, INC, DEC, LOAD, RESET, CONFIRM:in std_logic;   
	CLK:in std_logic;
	SELECTED:inout std_logic_vector(2 downto 0);
	VALIDARE:out std_logic;			
	DATA0, DATA1, DATA2, DATA3, DATA4, DATA5:in std_logic_vector(3 downto 0);
	A0, A1, A2, A3, A4, A5:out std_logic_vector(3 downto 0)
	);
end entity;


architecture comportamentala of mem_IO is
component NUMARATOR_N_BITI is
	generic(N:NATURAL range 0 to 16);			 		
	port(  
	CLK:in std_logic;
	RESET:in std_logic;	
	COUNT:in std_logic;
	LOAD:in std_logic;	 
	DATA:in std_logic_vector(N-1 downto 0);
	Q:out std_logic_vector(N-1 downto 0)
	);
end component;
signal select_CMD:std_logic;
signal EN:std_logic_vector(5 downto 0):="000000";
signal COUNT0, LOAD0, COUNT1, LOAD1, COUNT2, LOAD2, COUNT3, LOAD3, COUNT4, LOAD4, COUNT5, LOAD5:std_logic:='0';
begin	
	VALIDARE<=CONFIRM;
	select_CMD<=NEXT_ONE or PREV_ONE;
	SELECTIE:NUMARATOR_N_BITI generic map(N=>3)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>select_CMD,LOAD=>PREV_ONE,Q=>SELECTED,DATA=>"000");
	  
	EN(0)<=not(SELECTED(0) or SELECTED(1) or SELECTED(2));
	EN(1)<=not(SELECTED(0) or SELECTED(1)) and SELECTED(2);
	EN(2)<=not(SELECTED(0) or SELECTED(2)) and SELECTED(1);
	EN(3)<=not(SELECTED(0)) and SELECTED(1) and SELECTED(2);
	EN(4)<=SELECTED(0) and not(SELECTED(1) or SELECTED(2));
	EN(5)<=SELECTED(0) and SELECTED(2) and (not( SELECTED(2)));
	
	COUNT0<=(INC and EN(0)) or (DEC and EN(0));
	LOAD0<=LOAD or (DEC and EN(0));  
	
	COUNT1<=(INC and EN(1)) or (DEC and EN(1));
	LOAD1<=LOAD or (DEC and EN(1));  
	
	COUNT2<=(INC and EN(2)) or (DEC and EN(2));
	LOAD2<=LOAD or (DEC and EN(2));  
	
	COUNT3<=(INC and EN(3)) or (DEC and EN(3));
	LOAD3<=LOAD or (DEC and EN(3));  
	
	COUNT4<=(INC and EN(4)) or (DEC and EN(4));
	LOAD4<=LOAD or (DEC and EN(4));  
	
	COUNT5<=(INC and EN(5)) or (DEC and EN(5));
	LOAD5<=LOAD or (DEC and EN(5));  
	
						
						
	N0:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT0,LOAD=>LOAD0,Q=>A0,DATA=>DATA0);
	N1:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT1,LOAD=>LOAD1,Q=>A1,DATA=>DATA1);
	N2:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT2,LOAD=>LOAD2,Q=>A2,DATA=>DATA2);
	N3:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT3,LOAD=>LOAD3,Q=>A3,DATA=>DATA3);
	N4:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT4,LOAD=>LOAD4,Q=>A4,DATA=>DATA4);
	N5:NUMARATOR_N_BITI generic map(N=>4)
						port map(CLK=>CLK,RESET=>RESET,COUNT=>COUNT5,LOAD=>LOAD5,Q=>A5,DATA=>DATA5);
		
						
							
end architecture;