library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ID_CARD is
	port(	 
	CLK:in std_logic;
	IN_PIN:in std_logic_vector(15 downto 0);
	VW_PIN:in std_logic;
	IN_ADR:in std_logic_vector(1 downto 0);		
	ENABLE_MEM_PIN:in std_logic;
	PIN_CORECT: out std_logic:='0'
	);
end entity;	


architecture comportamentala of ID_CARD is	 
component mem_PIN is
	port(	 
	CLK:in std_logic;
	WE: in std_logic;
	IN_ADR: in std_logic_vector(1 downto 0);	 
	CS: in std_logic;
	IN_PIN:in std_logic_vector(15 downto 0);
	PIN_CORECT: out std_logic
	);
end component;
begin
	mem: mem_PIN port map(CLK=>CLK,WE=>VW_PIN, IN_ADR=>IN_ADR, CS=>ENABLE_MEM_PIN, IN_PIN=>IN_PIN,PIN_CORECT => PIN_CORECT);  
end architecture;