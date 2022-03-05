library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mem_BANCNOTE is
	port(	 
	CLK:in std_logic;						   						   
	D_UP5,D_UP10,D_UP20,D_UP50,D_UP100,D_UP500:in std_logic_vector(3 downto 0);
	R_UP5,R_UP10,R_UP20,R_UP50,R_UP100,R_UP500:in std_logic_vector(3 downto 0);
	WE: in std_logic;						   
	CS: in std_logic;	
	DEPUNERE, RETRAGERE:in std_logic;
	DISP5,DISP10,DISP20,DISP50,DISP100,DISP500:out std_logic_vector(3 downto 0)  
	);
end entity;


architecture comportamentala of mem_BANCNOTE is
type MEMORIE is array(0 to 5) of std_logic_vector(3 downto 0);
signal BANCNOTA: MEMORIE :=("1111","1111","1111","1111","1111","1111");	
signal LOAD0, LOAD1, LOAD2, LOAD3, LOAD4, LOAD5: std_logic_vector(3 downto 0);
begin
	process(CS,CLK)
	begin		
		if CS = '0' then   
			DISP5<="ZZZZ";
			DISP10<="ZZZZ";
			DISP20<="ZZZZ";
			DISP50<="ZZZZ";
			DISP100<="ZZZZ";
			DISP500<="ZZZZ";
		else   	   
			if(CLK'event and CLK='1') then
				if WE='0' then 	 
					DISP5<=BANCNOTA(0);
					DISP10<=BANCNOTA(1);
					DISP20<=BANCNOTA(2);
					DISP50<=BANCNOTA(3);
					DISP100<=BANCNOTA(4);
					DISP500<=BANCNOTA(5);
				else  
					if(DEPUNERE='1') then 
						BANCNOTA(0)<=D_UP5;
						BANCNOTA(1)<=D_UP10;
						BANCNOTA(2)<=D_UP20;
						BANCNOTA(3)<=D_UP50;
						BANCNOTA(4)<=D_UP100;
						BANCNOTA(5)<=D_UP500;
					elsif(RETRAGERE='1') then 
						BANCNOTA(0)<=R_UP5;
						BANCNOTA(1)<=R_UP10;
						BANCNOTA(2)<=R_UP20;
						BANCNOTA(3)<=R_UP50;
						BANCNOTA(4)<=R_UP100;
						BANCNOTA(5)<=R_UP500;		
					end if;
				end if;			  		
			end if;
		end if;
	end process;
	
end architecture;