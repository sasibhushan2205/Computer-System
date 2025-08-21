library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX is
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
opcode: in std_logic_vector(3 downto 0):="0000";
output : out std_logic_vector(15 downto 0) := (others => '0')
);
end MUX;
architecture bhv_mux of MUX is 
begin
mux_proc: process(reset,clk,opcode)
begin
if clk='1' and clk'event then
if reset='0' then
if(to_integer(unsigned(opcode))=0 or to_integer(unsigned(opcode))=2 or to_integer(unsigned(opcode))=3 or to_integer(unsigned(opcode))=4 or to_integer(unsigned(opcode))=5 or to_integer(unsigned(opcode))=6) then
output<=T3;
elsif to_integer(unsigned(opcode))=1 then
output<=ALU_ADI;
elsif to_integer(unsigned(opcode))=8 or to_integer(unsigned(opcode))=9 then
output<=ALU_LHI_LLI;
elsif to_integer(unsigned(opcode))=11 then
output<=MEM_DATAA;
elsif to_integer(unsigned(opcode))=13 then
output<=ALU_TW;
elsif to_integer(unsigned(opcode))=15 then
output<=R7;
end if;
end if;
end if;
end process;
end bhv_mux;