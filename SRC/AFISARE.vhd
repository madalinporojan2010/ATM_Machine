 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  

entity afisare_7seg is
	port(
	RESET:in std_logic;			 		 
	DIGIT0,DIGIT1,DIGIT2,DIGIT3,DIGIT4,DIGIT5:in std_logic_vector(3 downto 0);
	CLOCK:in std_logic;					 
	SELECTED: in std_logic_vector(2 downto 0);
	CAT: out std_logic_vector(6 downto 0); 
	DP: out std_logic;
	ANODE:out std_logic_vector(5 downto 0)
	); 
end entity;

architecture comportamentala of afisare_7seg is
component NUMARATOR_N_BITI is
	generic(N:NATURAL range 0 to 17);			 		
	port(  
	CLK:in std_logic;
	RESET:in std_logic;	
	COUNT:in std_logic;
	LOAD:in std_logic;	 
	DATA:in std_logic_vector(N-1 downto 0);
	Q:out std_logic_vector(N-1 downto 0)
	);
end component; 	

component DCD_7seg is
	port(VALUE:in STD_LOGIC_VECTOR(3 downto 0);
	CS_ROM:in STD_LOGIC;				
	SEL:in STD_LOGIC;
	SELECTION:out STD_LOGIC;
	D_ROM:out STD_LOGIC_vector(6 downto 0));
end component; 

signal num_OUT:std_logic_vector(16 downto 0);
signal DATA_IN:std_logic_vector(3 downto 0);  
signal DATA_decoded:std_logic_vector(6 downto 0);
signal to_anode:std_logic_vector(5 downto 0); 
begin			 
	U1:NUMARATOR_N_BITI generic map(N=>17)
	port map(CLK=>CLOCK,RESET=>RESET,COUNT=>'1',LOAD=>'0',DATA=>"00000000000000000",Q=>num_OUT);
	DCD:DCD_7seg port map(VALUE=>DATA_IN,CS_ROM=>'1',SEL=>'1',D_ROM=>DATA_decoded);
	
	
	process(DIGIT0,DIGIT1,DIGIT2,DIGIT3,DIGIT4,DIGIT5,num_OUT,to_anode,DATA_IN)
	begin 
		if num_OUT(14)='0' and num_OUT(15)='0' and num_OUT(16)='0' then
			DATA_IN<=DIGIT0;
			to_anode<="111110";
		elsif num_OUT(14)='0' and num_OUT(15)='1' and num_OUT(16)='0' then
			DATA_IN<=DIGIT1; 
			to_anode<="111101";
		elsif num_OUT(14)='1' and num_OUT(15)='0' and num_OUT(16)='0' then
			DATA_IN<=DIGIT2; 
			to_anode<="111011";
		elsif num_OUT(14)='1' and num_OUT(15)='1' and num_OUT(16)='0' then
			DATA_IN<=DIGIT3; 
			to_anode<="110111";
		elsif num_OUT(14)='0' and num_OUT(15)='1' and num_OUT(16)='1' then
			DATA_IN<=DIGIT4; 
			to_anode<="101111";	
		elsif num_OUT(14)='1' and num_OUT(15)='0' and num_OUT(16)='1' then
			DATA_IN<=DIGIT5; 
			to_anode<="011111";
--		else
--		    DATA_IN<="0000";
--		    to_anode<="111110";
		end if;
	end process;  

	DP<='0';
	CAT<=DATA_decoded;
	ANODE<=to_anode;
end architecture;

