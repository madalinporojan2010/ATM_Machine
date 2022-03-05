library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity DCD_7seg is
	port(VALUE:in STD_LOGIC_VECTOR(3 downto 0);
	CS_ROM:in STD_LOGIC;				
	SEL:in STD_LOGIC;
	SELECTION:out STD_LOGIC;
	D_ROM:out STD_LOGIC_vector(6 downto 0));
end entity;

architecture comportamentala of DCD_7seg is
type MEMORIE is array(0 to 15) of STD_LOGIC_vector(6 downto 0);
signal S: MEMORIE :=("0000001","1001111","0010010","0000110","1001100","0100100","0100000","0001111","0000000","0000100","0000010","1100000","0110001","1000010","0110000","0111000");
begin			   		   
	process(SEL,VALUE,CS_ROM,S)
	begin	   
	   SELECTION<=SEL;
		if (CS_ROM='1') then
			if VALUE=x"0" then
				D_ROM<=S(0);	   	  
			elsif VALUE=x"1" then
				D_ROM<=S(1);
			elsif VALUE=x"2" then
				D_ROM<=S(2);
			elsif VALUE=x"3" then	
				D_ROM<=S(3);
			elsif VALUE=x"4" then
				D_ROM<=S(4);
			elsif VALUE=x"5" then
				D_ROM<=S(5);
			elsif VALUE=x"6" then
				D_ROM<=S(6);
			elsif VALUE=x"7" then
				D_ROM<=S(7);
			elsif VALUE=x"8" then
				D_ROM<=S(8);
			elsif VALUE=x"9" then
				D_ROM<=S(9);
			elsif VALUE=x"A" then
				D_ROM<=S(10);
			elsif VALUE=x"B" then 
				D_ROM<=S(11);
			elsif VALUE=x"C" then 
				D_ROM<=S(12);
			elsif VALUE=x"D" then	
				D_ROM<=S(13);   
			elsif VALUE=x"E" then 
				D_ROM<=S(14);
			else
				D_ROM<=S(15); 
			end if;
		else
		  D_ROM<=S(0);
		end if;
	end process;
end	architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bistabil_D is
	port(
	CLK,D,RST:in std_logic;
	Q:out std_logic
	);
end entity;		

	  
architecture comportamentala of bistabil_D is
begin
	process(RST,CLK)
		begin
		if(RST='1') then
			Q<='0';
		else
			if(CLK'event and CLK = '1') then
				Q<=D;
			end if;
		end if;		  
	end process;
end architecture; 



library ieee;
use ieee.std_logic_1164.all;	   
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity NUMARATOR_N_BITI is
	generic(N:NATURAL range 0 to 17);			 		
	port(  
	CLK:in std_logic;
	RESET:in std_logic;	
	COUNT:in std_logic;
	LOAD:in std_logic;	 
	DATA:in std_logic_vector(N-1 downto 0);
	Q:out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture comportamentala of NUMARATOR_N_BITI is	 
begin			 
	process(CLK,RESET)	
	variable Q_CURENT:std_logic_vector(N-1 downto 0);									 						   					  
	begin		
		
		
		if RESET='1' then
			Q_CURENT:=conv_std_logic_vector(0,Q_CURENT'length);
		else
			if CLK'event and CLK = '1' then	 
				
				if COUNT='0' and LOAD='1' then
					Q_CURENT := DATA; 
				elsif COUNT='1' then
					if LOAD='1' then
					   	Q_CURENT:=Q_CURENT-1;  
						if N=3 and Q_CURENT>"101" then	
							Q_CURENT:=conv_std_logic_vector(5,Q_CURENT'length);
						end if;	
					else	  	 
						Q_CURENT:=Q_CURENT+1;
						if N=3 and Q_CURENT>"101" then	
							Q_CURENT:=conv_std_logic_vector(0,Q_CURENT'length);
						end if;				 
					end if;
				end if;
			end if;
		end if;	  
		
		Q<=Q_CURENT;
	end process;	
end architecture;






