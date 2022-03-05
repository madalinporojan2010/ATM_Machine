library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity RETRAGERE is
	port (SUMA : in STD_LOGIC_VECTOR(15 downto 0);
		  CLK : in STD_LOGIC;
		  ENABLE : in STD_LOGIC;
		  d5, d10, d20, d50, d100, d500 : in STD_LOGIC_VECTOR(3 downto 0);
		  u5, u10, u20, u50, u100, u500 : out STD_LOGIC_VECTOR(3 downto 0);
		  o5, o10, o20, o50, o100, o500 : out STD_LOGIC_VECTOR(3 downto 0);
		  SUMA_UPDATE: out STD_LOGIC_VECTOR(15 downto 0);
		  POSIBIL : out STD_LOGIC:='0'); 
end entity;

architecture comportamentala of RETRAGERE is
begin
	process	(clk)
	variable aux_suma : NATURAL range 0 to 999999;
	variable min : NATURAL range 0 to 999999;  
	variable div : NATURAL range 0 to 999999;
	variable suma_int : NATURAL range 0 to 999999;
	variable ok : STD_LOGIC := '1';
	variable aux_d5, aux_d10, aux_d20, aux_d50, aux_d100, aux_d500 : NATURAL range 0 to 999999;
	variable aux_u5, aux_u10, aux_u20, aux_u50, aux_u100, aux_u500 : NATURAL range 0 to 999999;
	begin
	   POSIBIL <= '0';								  
		if (clk'event and clk = '1') then	
			suma_int := conv_integer(unsigned(SUMA));
			if (enable = '1' and suma_int <= 1000) then	
				aux_suma := conv_integer(unsigned(suma));
												
				aux_d5 := conv_integer(unsigned(d5));
				aux_d10 := conv_integer(unsigned(d10));
				aux_d20 := conv_integer(unsigned(d20));
				aux_d50 := conv_integer(unsigned(d50));
				aux_d100 := conv_integer(unsigned(d100));  
				aux_d500 := conv_integer(unsigned(d500));
					   
				aux_u5 := 0;	
				aux_u10 := 0;
				aux_u20 := 0;
				aux_u50 := 0;
				aux_u100 := 0; 	 
				aux_u500 :=  0;
				
				
					if (aux_suma / 500 < aux_d500) then
						min := aux_suma / 500;
					else
						min := aux_d500;
					end if;
					
					aux_suma := aux_suma - 500 * min;
					aux_u500 := min;
					aux_d500 := aux_d500 - min;
				 
					if (aux_suma / 100 < aux_d100) then
						min := aux_suma / 100;
					else
						min := aux_d100;
					end if;
					
					aux_suma := aux_suma - 100 * min;
					aux_u100 := min;
					aux_d100 := aux_d100 - min;	
					
					if (aux_suma / 50 < aux_d50) then
						min := aux_suma / 50;
					else
						min := aux_d50;
					end if;
					
					aux_suma := aux_suma - 50 * min;
					aux_u50 := min;
					aux_d50 := aux_d50 - min;	
					
					if (aux_suma / 20 < aux_d20) then
						min := aux_suma / 20;
					else
						min := aux_d20;
					end if;
					
					aux_suma := aux_suma - 20 * min;
					aux_u20 := min;
					aux_d20 := aux_d20 - min;	
					
					if (aux_suma / 10 < aux_d10) then
						min := aux_suma / 10;
					else
						min := aux_d10;
					end if;
					
					aux_suma := aux_suma - 10 * min;
					aux_u10 := min;
					aux_d10 := aux_d10 - min;	
				
					if (aux_suma / 5 < aux_d5) then
						min := aux_suma / 5;
					else
						min := aux_d5;
					end if;
					
					aux_suma := aux_suma - 5 * min;
					aux_u5 := min;
					aux_d5 := aux_d5 - min;	
						
				
				
				if (aux_suma = 0) then				
					o5 <= conv_std_logic_vector(aux_d5, d5'length);
					o10 <= conv_std_logic_vector(aux_d10, d10'length);
					o20 <= conv_std_logic_vector(aux_d20, d20'length);
					o50 <= conv_std_logic_vector(aux_d50, d50'length);
					o100 <= conv_std_logic_vector(aux_d100, d100'length); 
					o500 <= conv_std_logic_vector(aux_d500, d500'length);
									   
					u5 <= conv_std_logic_vector(aux_u5, u5'length);
					u10 <= conv_std_logic_vector(aux_u10, u10'length);
					u20 <= conv_std_logic_vector(aux_u20, u20'length);
					u50 <= conv_std_logic_vector(aux_u50, u50'length);
					u100 <= conv_std_logic_vector(aux_u100, u100'length);  
					u500 <= conv_std_logic_vector(aux_u500, u500'length);
					
					POSIBIL <= '1';
				end if;
				
				
			end if;
		end if;
	end process;
end architecture;