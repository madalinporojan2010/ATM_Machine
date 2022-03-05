library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity div_freq is
	port(
	CLK,RST:in std_logic;
	CLK_div:inout std_logic
	);				
end entity;

architecture comportamentala of div_freq is
component bistabil_D is	
	port(
	CLK,D,RST:in std_logic;
	Q:out std_logic
	);
end component;	 
signal not_Q:std_logic;
signal CLK_div1, CLK_div2, CLK_div3, CLK_div4, CLK_div5, CLK_div6, CLK_div7, CLK_div8, CLK_div9, CLK_div10, CLK_div11, CLK_div12, CLK_div13, CLK_div14, CLK_div15, CLK_div16, CLK_div17, CLK_div18, CLK_div19: std_logic;
begin											 
	not_Q<=not CLK_div;						 
	-----100mhz/2^20 = 95 hz									   							  
	D1:bistabil_D port map(CLK=>CLK, RST=>RST,D=>not_Q,Q=>CLK_div1);
	D2:bistabil_D port map(CLK=>CLK_div1, RST=>RST,D=>not_Q,Q=>CLK_div2);
	D3:bistabil_D port map(CLK=>CLK_div2, RST=>RST,D=>not_Q,Q=>CLK_div3);
	D4:bistabil_D port map(CLK=>CLK_div3, RST=>RST,D=>not_Q,Q=>CLK_div4);
	D5:bistabil_D port map(CLK=>CLK_div4, RST=>RST,D=>not_Q,Q=>CLK_div5);
	D6:bistabil_D port map(CLK=>CLK_div5, RST=>RST,D=>not_Q,Q=>CLK_div6);
	D7:bistabil_D port map(CLK=>CLK_div6, RST=>RST,D=>not_Q,Q=>CLK_div7);
	D8:bistabil_D port map(CLK=>CLK_div7, RST=>RST,D=>not_Q,Q=>CLK_div8);
	D9:bistabil_D port map(CLK=>CLK_div8, RST=>RST,D=>not_Q,Q=>CLK_div9);
	D10:bistabil_D port map(CLK=>CLK_div9, RST=>RST,D=>not_Q,Q=>CLK_div10);						   							  
	D11:bistabil_D port map(CLK=>CLK_div10, RST=>RST,D=>not_Q,Q=>CLK_div11);
	D12:bistabil_D port map(CLK=>CLK_div11, RST=>RST,D=>not_Q,Q=>CLK_div12);
	D13:bistabil_D port map(CLK=>CLK_div12, RST=>RST,D=>not_Q,Q=>CLK_div13);
	D14:bistabil_D port map(CLK=>CLK_div13, RST=>RST,D=>not_Q,Q=>CLK_div14);
	D15:bistabil_D port map(CLK=>CLK_div14, RST=>RST,D=>not_Q,Q=>CLK_div15);
	D16:bistabil_D port map(CLK=>CLK_div15, RST=>RST,D=>not_Q,Q=>CLK_div16);
	D17:bistabil_D port map(CLK=>CLK_div16, RST=>RST,D=>not_Q,Q=>CLK_div17);
	D18:bistabil_D port map(CLK=>CLK_div17, RST=>RST,D=>not_Q,Q=>CLK_div18);
	D19:bistabil_D port map(CLK=>CLK_div18, RST=>RST,D=>not_Q,Q=>CLK_div19);
	D20:bistabil_D port map(CLK=>CLK_div19, RST=>RST,D=>not_Q,Q=>CLK_div);
end architecture;