library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity TOP_MODULE is
	port(	  
	CLOCK:in std_logic;
	
	
	-------------------BUTOANE----------------------
	BTN_OK, BTN_INC, BTN_DEC, BTN_NEXT, BTN_PREV: in std_logic;

	
	-------------------SWITCH-URI-------------------
	SWT_CLR, SWT_EXIT, SWT_ADR0, SWT_ADR1, SWT_OP0, SWT_OP1, SWT_10, SWT_20, SWT_50, SWT_100: in std_logic;
	
	------------------LED-URI----------------------
	LED_SUCCES, LED_RETRAGERE_SUCCES, LED_FAIL, LED_CHITANTA:out std_logic;
	
	-------------------AFISOARE--------------------
	DecimalPOINT: out std_logic;
	CAT:out std_logic_vector(6 downto 0); 		  
	ANODE:out std_logic_vector(5 downto 0)
	);
end entity;


architecture TOP of TOP_MODULE is  
component debouncer is
	port(
	CLK,BTN,RST:in std_logic;	
	BTN_DB:out std_logic
	);
end component;		

component div_freq is
	port(
	CLK,RST:in std_logic;
	CLK_div:inout std_logic
	);				
end component;	   


component ORGANIGRAMA is
	port(			
		VALIDARE, PIN_CORECT, IESIRE_CONT, OP_1, OP_0, RETRAGERE_POSIBILA, DEPUNERE_POSIBILA:in std_logic:='0';
		STARE_CURENTA:inout std_logic_vector(4 downto 0);	 
		STARE_VIITOARE:inout std_logic_vector(4 downto 0);
		CLK: in std_logic;
		----------------------------------------------
		----------------------------------------------
		ENABLE_ALGORITM_RETRAGERE, ENABLE_ALGORITM_DEPUNERE:out std_logic;
		status_SOLD, status_RETRAGERE, SCHIMBA_PIN, status_DEPUNERE:out std_logic:='0';
		LED_SUCCES:out std_logic:='0';
		LED_RETRAGERE_SUCCES:out std_logic:='0';
		LED_CHITANTA:out std_logic:='0';
		LED_FAIL:out std_logic:='0'
		);
end component;


component ID_CARD is
	port(	 
	CLK:in std_logic;
	IN_PIN:in std_logic_vector(15 downto 0);
	VW_PIN:in std_logic;
	IN_ADR:in std_logic_vector(1 downto 0);		
	ENABLE_MEM_PIN:in std_logic;
	PIN_CORECT: out std_logic:='0'
	);
end component;		

component legare_IO is
	port(
	-------------------BUTOANE----------------------
	BTN_OK, BTN_INC, BTN_DEC, BTN_NEXT, BTN_PREV: in std_logic;

	
	-------------------SWITCH-URI-------------------
	SWT_EXIT, SWT_ADR0, SWT_ADR1, SWT_OP0, SWT_OP1, SWT_10, SWT_20, SWT_50, SWT_100: in std_logic;	 	
	
	CLOCK:in std_logic;
	RETRAGERE, DEPUNERE, SOLD: in std_logic;							 					
	R_IN0, R_IN1, R_IN2, R_IN3, R_IN4, R_IN5:in std_logic_vector(3 downto 0);
	D_IN0, D_IN1, D_IN2, D_IN3, D_IN4, D_IN5:in std_logic_vector(3 downto 0);
	SOLD0, SOLD1, SOLD2, SOLD3, SOLD4, SOLD5:in std_logic_vector(3 downto 0);
	IO_0, IO_1, IO_2, IO_3, IO_4, IO_5:out std_logic_vector(3 downto 0); 
	VALIDARE:out std_logic;	
	SELECTED: inout std_logic_vector(2 downto 0)
	);
end component;

component mem_SUMA is
	port(	 
	CLK:in std_logic;						   					
	DATA:in std_logic_vector(15 downto 0);
	IN_ADR:in std_logic_vector(1 downto 0);
	WE: in std_logic;						   
	CS: in std_logic;		
	SUMA_OUT: out std_logic_vector(15 downto 0)  
	);
end component;

component mem_BANCNOTE is
	port(	 
	CLK:in std_logic;						   						   
	D_UP5,D_UP10,D_UP20,D_UP50,D_UP100,D_UP500:in std_logic_vector(3 downto 0);
	R_UP5,R_UP10,R_UP20,R_UP50,R_UP100,R_UP500:in std_logic_vector(3 downto 0);
	WE: in std_logic;						   
	CS: in std_logic;	
	DEPUNERE, RETRAGERE:in std_logic;
	DISP5,DISP10,DISP20,DISP50,DISP100,DISP500:out std_logic_vector(3 downto 0)  
	);
end component;


component IO_to_dec is
	port(
	N0,N1,N2,N3,N4,N5:in std_logic_vector(3 downto 0);
	ZECIMAL:out std_logic_vector(15 downto 0)
	);
end component;	 


component dec_to_IO is
	port(
	ZECIMAL:in std_logic_vector(15 downto 0); 
	N5,N4,N3,N2,N1,N0: out std_logic_Vector(3 downto 0)	   
	);
end component;	

component SUME_PREDEFINITE is
	port(		
	SWT_X:in std_logic_vector(5 downto 0);
	IO_LOAD_ENABLE: out std_logic;
	IO_0, IO_1, IO_2, IO_3, IO_4, IO_5: out std_logic_vector(3 downto 0):="0000"
	);
end component;


component DEPUNERE is
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
end component;


component RETRAGERE is
	port (SUMA : in STD_LOGIC_VECTOR(15 downto 0);
		  CLK : in STD_LOGIC;
		  ENABLE : in STD_LOGIC;
		  d5, d10, d20, d50, d100, d500 : in STD_LOGIC_VECTOR(3 downto 0);
		  u5, u10, u20, u50, u100, u500 : out STD_LOGIC_VECTOR(3 downto 0);
		  o5, o10, o20, o50, o100, o500 : out STD_LOGIC_VECTOR(3 downto 0);
		  SUMA_UPDATE: out STD_LOGIC_VECTOR(15 downto 0);
		  POSIBIL : out STD_LOGIC:='0'); 
end component;


component afisare_7seg is
	port(
	RESET:in std_logic;			 		 
	DIGIT0,DIGIT1,DIGIT2,DIGIT3,DIGIT4,DIGIT5:in std_logic_vector(3 downto 0);
	CLOCK:in std_logic;					 
	SELECTED: in std_logic_vector(2 downto 0);
	CAT: out std_logic_vector(6 downto 0); 
	DP: out std_logic;
	ANODE:out std_logic_vector(5 downto 0)
	); 
end component;

---------------debounced buttons----------------
signal DB_OK, DB_INC, DB_DEC, DB_NEXT, DB_PREV: std_logic;	
--------------div_frecventa-----------------------
signal clk_div: std_logic;


---------------organigrama----------------------  
signal STARE_CURENTA: std_logic_vector(4 downto 0):="00000"; 
signal STARE_VIITOARE: std_logic_vector(4 downto 0):="00000"; 
signal ENABLE_MEM_PIN, ENABLE_ALGORITM_DEPUNERE, ENABLE_ALGORITM_RETRAGERE, SCHIMBA_PIN: std_logic:='0';
signal status_SOLD: std_logic:='0';	   	  
signal status_RETRAGERE: std_logic:='0';
signal status_DEPUNERE: std_logic:='0';	  

--------------predef sums------------------------
signal SWT_X: std_logic_vector(5 downto 0);
signal IO_LOAD_ENABLE: std_logic;

---------------ID_CARD---------------------------
signal PIN_CORECT: std_logic:='1';	 
signal IN_ADR: std_logic_vector(1 downto 0);

---------------INTRODUCEREA DATELOR--------------
signal SELECTED: std_logic_vector(2 downto 0):="000";	
signal LOAD: std_logic:='0';
signal IO_0, IO_1, IO_2, IO_3, IO_4, IO_5: std_logic_vector(3 downto 0);
signal VALIDARE: std_logic;
signal ZECIMAL: std_logic_vector(15 downto 0); 


--------------MEMORIE_SUMA---------------------- 
signal WESUMA: std_logic; 
signal SUMA_OUT: std_logic_vector(15 downto 0);	
--------------MEMORIE_BANCNOTE---------------------- 
signal WEBANCNOTE: std_logic; 					
signal d5,d10,d20,d50,d100,d500: std_logic_vector(3 downto 0);

--------------RETRAGERE-------------------------	
signal RETRAGERE_POSIBILA: std_logic:='0';							   				  
signal u5,u10,u20,u50,u100,u500: std_logic_vector(3 downto 0);
signal o5,o10,o20,o50,o100,o500: std_logic_vector(3 downto 0);
-------------DEPUNERE---------------------------			
signal DEPUNERE_POSIBILA: std_logic:='0';	
signal DISP500,DISP100,DISP50,DISP20,DISP10,DISP5: std_logic_vector(3 downto 0);  
signal UPDATE500,UPDATE100,UPDATE50,UPDATE20,UPDATE10,UPDATE5:std_logic_vector(3 downto 0);	 

-------------------ZECIMAL to IO --------------- 
signal N5,N4,N3,N2,N1,N0: std_logic_vector(3 downto 0);
	
--------------------------------------------------

signal SUMA_UPDATE: std_logic_vector(15 downto 0);		
begin	
	IN_ADR<=SWT_ADR1 & SWT_ADR0;   
		
	-------------------------------------------------------------------------------
	slow_CLK: div_freq port map(CLK=>CLOCK, RST=>'0', CLK_div=>CLK_DIV);
	-------------------------------------------------------------------------------
	DB1: debouncer port map(CLK=>CLOCK, BTN=>BTN_OK, RST=>'0', BTN_DB=>DB_OK);
	DB2: debouncer port map(CLK=>CLOCK, BTN=>BTN_INC, RST=>'0', BTN_DB=>DB_INC);	  
	DB3: debouncer port map(CLK=>CLOCK, BTN=>BTN_DEC, RST=>'0', BTN_DB=>DB_DEC);
	DB4: debouncer port map(CLK=>CLOCK, BTN=>BTN_NEXT, RST=>'0', BTN_DB=>DB_NEXT);
	DB5: debouncer port map(CLK=>CLOCK, BTN=>BTN_PREV, RST=>'0', BTN_DB=>DB_PREV);
	-------------------------------------------------------------------------------
 
	to_IO1: dec_to_IO port map(ZECIMAL=>ZECIMAL, N5=>N5, N4=>N4, N3=>N3, N2=>N2, N1=>N1, N0=>N0);
	
	
	DATE: LEGARE_IO port map(CLOCK=>CLOCK, BTN_OK=>DB_OK, BTN_INC=>DB_INC, BTN_DEC=>DB_DEC, BTN_NEXT=>DB_NEXT, BTN_PREV=>DB_PREV, 
	SWT_EXIT=>SWT_EXIT, SWT_ADR0=>SWT_ADR0, SWT_ADR1=>SWT_ADR1, SWT_OP0=>SWT_OP0, SWT_OP1=>SWT_OP1, SWT_10=>SWT_10, SWT_20=>SWT_20, SWT_50=>SWT_50, SWT_100=>SWT_100,
	RETRAGERE=>status_RETRAGERE, DEPUNERE=>status_DEPUNERE, SOLD=>status_SOLD, VALIDARE=>VALIDARE, SELECTED=>SELECTED,
	R_IN0=>o5, R_IN1=>o10, R_IN2=>o20, R_IN3=>o50, R_IN4=>o100, R_IN5=>o500,
	D_IN0=>UPDATE5, D_IN1=>UPDATE10, D_IN2=>UPDATE20, D_IN3=>UPDATE50, D_IN4=>UPDATE100, D_IN5=>UPDATE500,
	SOLD0=>N0, SOLD1=>N1, SOLD2=>N2, SOLD3=>N3, SOLD4=>N4, SOLD5=>N5,
	IO_0=>IO_0, IO_1=>IO_1, IO_2=>IO_2, IO_3=>IO_3, IO_4=>IO_4, IO_5=>IO_5);   
	
	
	to_DEC1: IO_to_dec port map(N0=>IO_0, N1=>IO_1, N2=>IO_2, N3=>IO_3, N4=>IO_4, N5=>IO_5, ZECIMAL=>ZECIMAL);
	
	WEBANCNOTE <= status_RETRAGERE or STATUS_DEPUNERE; 
	MEMORIE_BANCNOTE: mem_BANCNOTE port map(CLK=>CLOCK, R_UP5=>u5, R_UP10=>u10, R_UP20=>u20, R_UP50=>u50, R_UP100=>u100, R_UP500=>u500, 
	D_UP5=>UPDATE5, D_UP10=>UPDATE10, D_UP20=>UPDATE20, D_UP50=>UPDATE50, D_UP100=>UPDATE100, D_UP500=>UPDATE500,
	DISP5=>d5, DISP10=>d10, DISP20=>d20, DISP50=>d50, DISP100=>d100, DISP500=>d500,
	WE=>WEBANCNOTE, CS=>'1', DEPUNERE=>status_DEPUNERE, RETRAGERE=>status_RETRAGERE);
	
	alg_RETRAGERE: RETRAGERE port map(CLK=>CLOCK, SUMA=>ZECIMAL, ENABLE=>ENABLE_ALGORITM_RETRAGERE, POSIBIL=>RETRAGERE_POSIBILA, SUMA_UPDATE=>SUMA_UPDATE, 
	d5=>d5, d10=>d10, d20=>d20, d50=>d50, d100=>d100, d500=>d500, 
	u5=>u5, u10=>u20, u50=>u50, u100=>u100, u500=>u500,
	o5=>o5, o10=>o10, o20=>o20, o50=>o50, o100=>o100, o500=>o500);
	

	MEMORIE_SUMA: mem_SUMA port map(CLK=>CLOCK, DATA=>ZECIMAL, IN_ADR=>IN_ADR, WE=>WESUMA, CS=>'1', SUMA_OUT=>SUMA_OUT);
	
	alg_DEPUNERE: DEPUNERE port map(CLK=>CLOCK, ENABLE=>ENABLE_ALGORITM_DEPUNERE, POSIBIL=>DEPUNERE_POSIBILA, SUMA_CONT=>SUMA_OUT, SUMA_UPDATE=>SUMA_UPDATE, DEP500=>d500, DEP100=>d100, DEP50=>d50, DEP20=>d20, DEP10=>d10, DEP5=>d5,
	DISP500=>IO_5, DISP100=>IO_4, DISP50=>IO_3, DISP20=>IO_2, DISP10=>IO_1, DISP5=>IO_0,
	UPDATE500=>UPDATE500, UPDATE100=>UPDATE100, UPDATE50=>UPDATE50, UPDATE20=>UPDATE20, UPDATE10=>UPDATE10, UPDATE5=>UPDATE5);

	
	AFISARE: afisare_7seg port map(CLOCK=>CLK_DIV, SELECTED=>SELECTED, CAT=>CAT, ANODE=>ANODE, RESET=>SWT_CLR, DIGIT0=>IO_0, DIGIT1=>IO_1, DIGIT2=>IO_2, DIGIT3=>IO_3, DIGIT4=>IO_4, DIGIT5=>IO_5,
	DP=>DecimalPOINT);
	
	ID_CARD1: ID_CARD port map(CLK=>CLOCK, IN_PIN=>ZECIMAL, VW_PIN=>SCHIMBA_PIN, IN_ADR=>IN_ADR, ENABLE_MEM_PIN=>'1', PIN_CORECT=>PIN_CORECT); 
	
	ORG: ORGANIGRAMA port map(CLK=>CLOCK ,VALIDARE=>DB_OK, PIN_CORECT=>PIN_CORECT, IESIRE_CONT=>SWT_EXIT, OP_1=>SWT_OP1, OP_0=>SWT_OP0, RETRAGERE_POSIBILA=>RETRAGERE_POSIBILA, DEPUNERE_POSIBILA=>DEPUNERE_POSIBILA,
	STARE_CURENTA=>STARE_CURENTA, STARE_VIITOARE=>STARE_VIITOARE, 
	ENABLE_ALGORITM_RETRAGERE=>ENABLE_ALGORITM_RETRAGERE, ENABLE_ALGORITM_DEPUNERE=>ENABLE_ALGORITM_DEPUNERE, status_SOLD=>status_SOLD, status_RETRAGERE=>status_RETRAGERE,
	SCHIMBA_PIN=>SCHIMBA_PIN, status_DEPUNERE=>status_DEPUNERE, LED_SUCCES=>LED_SUCCES, LED_RETRAGERE_SUCCES=>LED_RETRAGERE_SUCCES, LED_FAIL=>LED_FAIL, LED_CHITANTA=>LED_CHITANTA);	

end architecture;