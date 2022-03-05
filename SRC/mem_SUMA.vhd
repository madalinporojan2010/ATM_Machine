library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mem_SUMA is
	port(	 
	CLK:in std_logic;						   					
	DATA:in std_logic_vector(15 downto 0);
	IN_ADR:in std_logic_vector(1 downto 0);
	WE: in std_logic;						   
	CS: in std_logic;		
	SUMA_OUT: out std_logic_vector(15 downto 0)  
	);
end entity;


architecture comportamentala of mem_SUMA is
type MEMORIE is array(0 to 3) of std_logic_vector(15 downto 0);
signal SUMA: MEMORIE :=(x"2710",x"3A98",x"E801",x"3A98");
begin
	process(CS,CLK)
	begin		
		if CS = '0' then   
			SUMA_OUT<="ZZZZZZZZZZZZZZZZ";
		else   	   
			if(CLK'event and CLK='1') then
				if WE='0' then 	 
					if IN_ADR = "00" then
						SUMA_OUT<=SUMA(0);
					elsif IN_ADR = "01" then  
						SUMA_OUT<=SUMA(1);
					elsif IN_ADR = "10" then 
						SUMA_OUT<=SUMA(2);
					elsif IN_ADR = "11" then
						SUMA_OUT<=SUMA(3);
					end if;
				else  			   		  
					SUMA(conv_integer(IN_ADR))<=DATA;
				end if;			  		
			end if;
		end if;
	end process;	
end architecture;