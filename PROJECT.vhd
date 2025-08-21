library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PROJECT is
port(
reset : in std_logic:='1';
clk : in std_logic:='1'
);
end PROJECT;

architecture behaviour of PROJECT is

component register_file is
port(
clk : in std_logic;
reset : in std_logic;
read_en : in std_logic;
write_en : in std_logic;
addr : in std_logic_vector(2 downto 0);
in_val : in std_logic_vector(15 downto 0);
out_val : out std_logic_vector(15 downto 0));
end component register_file;

component MUX_locn is
port(
inst : in std_logic_vector(15 downto 0);
reset : in std_logic;
clk : in std_logic;
output : out std_logic_vector(3 downto 0);
opcode: in std_logic_vector(3 downto 0));
end component MUX_locn;

component MUX_pc is
port(
temp1 : in std_logic_vector(15 downto 0);
ALU_TW : in std_logic_vector(15 downto 0);
T2 : in std_logic_vector(15 downto 0);
T3 : in std_logic_vector(15 downto 0);
reset : in std_logic;
clk : in std_logic;
output : out std_logic_vector(3 downto 0);
opcode: in std_logic_vector(3 downto 0));
end component MUX_pc;

component MUX is
port(
R7 : in std_logic_vector(15 downto 0) := (others => '0');
reset : in std_logic:='1';
clk : in std_logic:='1';
T1 : in std_logic_vector(15 downto 0) := (others => '0');
T2 : in std_logic_vector(15 downto 0) := (others => '0');
T3 : in std_logic_vector(15 downto 0) := (others => '0');
ALU_TW : in std_logic_vector(15 downto 0) := (others => '0');
ALU_ADI : in std_logic_vector(15 downto 0) := (others => '0');
ALU_LHI_LLI : in std_logic_vector(15 downto 0) := (others => '0');
MEM_DATAA : in std_logic_vector(15 downto 0) := (others => '0');
opcode: in std_logic_vector(3 downto 0):="000";
output : out std_logic_vector(15 downto 0) := (others => '0'));
end component MUX;

component ALU is
port(
input_val1 : in std_logic_vector(15 downto 0);
input_val2 : in std_logic_vector(15 downto 0);
opcode : in std_logic_vector(3 downto 0);
reset : in std_logic;
clk : in std_logic;
out_val : out std_logic_vector(15 downto 0));
end component ALU;

component MEM_INS is
port(
read_en : in std_logic;
addr : in std_logic_vector(15 downto 0);
clk : in std_logic;
reset: in std_logic;
out_val : out std_logic_vector(15 downto 0));
end component MEM_INS;

component MEM_DATA is
port(
input_val : in std_logic_vector(15 downto 0);
read_en : in std_logic;
write_en : in std_logic;
addr : in std_logic_vector(15 downto 0);
clk : in std_logic;
reset: in std_logic;
out_val : out std_logic_vector(15 downto 0));
end component MEM_DATA;

    signal T1 :STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal T2 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal T3 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal output : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal inst : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal ALU_TW : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal ALU_TWB : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal ALU_ADI : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal ALU_LHI_LLI : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal ALU_nineten : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal MEM_READ_EN : STD_LOGIC:='0';
	 signal MEM_WRITE_EN : STD_LOGIC:='0';
	 signal register_final_write: std_logic;
	 signal MEM_DATAA : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal temp1 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal temp2 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal R7 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	 signal opcode : std_logic_vector(3 downto 0):="000";
	 signal zero_flag : std_logic_vector(15 downto 0) := (others => '0');
	 signal mux_loc : std_logic_vector(3 downto 0):="000";
	 signal bufferr : std_logic_vector(15 downto 0) := (others => '0');
begin

MEM_INS_inst: MEM_INS port map
(read_en => '1',
  addr => R7,
  clk => clk,
  reset => reset,
  out_val => inst);
ALU_inst: ALU port map 
	(
    input_val1 => R7,
    input_val2 => "0000000000000010",
    opcode => "0000",
    reset => reset,
    clk => clk,
    out_val => temp1
  );
regin1:register_file port map(clk,reset,'1','0',inst(11 downto 9),bufferr,T1);
regin2:register_file port map(clk,reset,'1','0',inst(8 downto 6),bufferr,T2);
ALU_R:ALU port map(T1,T2,opcode,reset,clk,T3);
MUX_locn_final: MUX_locn port map (inst,reset,clk,mux_loc,opcode);
ALU_adi1: ALU port map(T1,inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5 downto 0),opcode,reset,clk,ALU_ADI);
opcode<=inst(15 downto 12);
ALU_LHI_LLI1:ALU port map(inst(7 downto 0),bufferr,opcode,reset,clk,ALU_LHI_LLI);
ALU_NINETEN1:ALU PORT map(T2,inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5 downto 0),opcode,reset,clk,ALU_nineten);
MEM_READ_EN<=(opcode(3) and not(opcode(2)) and opcode(1) and not(opcode(0)));
MEM_WRITE_EN<=(opcode(3) and not(opcode(2)) and opcode(1) and opcode(0));
MEM_DATAA1:MEM_DATA port map(T1,MEM_READ_EN,MEM_WRITE_EN,ALU_nineten,clk,reset,MEM_DATAA);
ALU_TWA1: ALU port map(inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5)&inst(5 downto 0)&'0',R7,"0000",reset,clk,ALU_TW);
register_final_write<=not((opcode(3) and opcode(2) and not(opcode(1)) and not(opcode(0))) or (opcode(3) and not(opcode(2)) and opcode(1) and opcode(0)));
MUX_REG_WRITE: MUX port map(R7=>R7,reset=>reset,clk=>clk,T1=>T1,T2=>T2,T3=>T3,ALU_TW=>ALU_TW,ALU_ADI=>ALU_ADI,ALU_LHI_LLI=>ALU_LHI_LLI,MEM_DATAA=>MEM_DATAA,opcode=>opcode,output=>output);
regin3:register_file port map(clk,reset,'0',register_final_write,mux_loc,output,bufferr);
MUX_PC_FInal:  MUX_pc port map(temp1,ALU_TW,T2,T3,reset,clk,R7,opcode);

end behaviour;