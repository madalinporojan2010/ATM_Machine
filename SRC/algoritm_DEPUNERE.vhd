library ieee;
use ieee.std_logic_1164.all;	   
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;	  

entity DEPUNERE is
	port(
	CLK:in std_logic;  
	ENABLE:in std_logic;
	SUMA_CONT:in std_logic_vector(15 downto 0);	 
	DEP500,DEP100,DEP50,DEP20,DEP10,DEP5:in std_logic_vector(3 downto 0);
	DISP500,DISP100,DISP50,DISP20,DISP10,DISP5:in std_logic_vector(3 downto 0);
	UPDATE500,UPDATE100,UPDATE50,UPDATE20,UPDATE10,UPDATE5:out std_logic_vector(3 downto 0);		 
	POSIBIL: out std_logic:='0';
	SUMA_UPDATE:out std_logic_vector(15 downto 0)
	);
end entity;



architecture comportamentala of DEPUNERE is
begin	   					  			  
	UPDATE500<=DEP500+DISP500;
	UPDATE100<=DEP100+DISP100;
	UPDATE50<=DEP50+DISP50;
	UPDATE20<=DEP20+DISP20;
	UPDATE10<=DEP500+DISP10;
	UPDATE5<=DEP500+DISP5;
	process(CLK, DEP500, DEP100, DEP50, DEP20, DEP10, DEP5)
	variable SUM_IN,INT500,INT100,INT50,INT20,INT10,INT5:natural range 0 to 999999;
	begin
			INT500:=conv_integer(DEP500)*500;
			INT100:=conv_integer(DEP100)*100;
			INT50:=conv_integer(DEP50)*50;
			INT20:=conv_integer(DEP20)*20;
			INT10:=conv_integer(DEP10)*10;
			INT5:=conv_integer(DEP5)*5;	
			SUM_IN:=INT500+INT100+INT50+INT20+INT10+INT5;
			POSIBIL <= '0';
		if(CLK'event and CLK='1') then
				if(ENABLE='1' and SUM_IN<=1000) then
					  
					  SUMA_UPDATE<=conv_std_logic_vector(SUM_IN+conv_integer(SUMA_CONT),SUMA_UPDATE'length); 
					  POSIBIL<='1';
				end if;
		end if;
	end process;
end architecture;