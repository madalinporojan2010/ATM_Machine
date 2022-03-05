library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debouncer is
	port(
	CLK,BTN,RST:in std_logic;	
	BTN_DB:out std_logic
	);
end entity;

architecture comportamentala of debouncer is   
component bistabil_D is
	port(
	CLK,D,RST:in std_logic;
	Q:out std_logic
	);
end component;			   
signal a,b,c:std_logic;
begin
	D1:bistabil_D port map(CLK=>CLK,D=>BTN,RST=>RST,Q=>a); 
	D2:bistabil_D port map(CLK=>CLK,D=>a,RST=>RST,Q=>b);
	D3:bistabil_D port map(CLK=>CLK,D=>b,RST=>RST,Q=>c);
	
	BTN_DB<=a and b and c;
end architecture;