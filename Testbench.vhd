library ieee;
use ieee.std_logic_1164.all;
entity Testbench is
end entity;

architecture TB_BEHAVIOR of Testbench is

component mem_ins
port(
input_val : in std_logic_vector(15 downto 0);
read_en : in std_logic;
addr : in std_logic_vector(7 downto 0);
clk : in std_logic;
out_val : out std_logic_vector(15 downto 0);
load_en:in std_logic;
);
end component;
signal clock:std_logic:='0';
signal load_en:std_logic:='1';
signal read_en:std_logic:='0';
constant timeperiod:time:=20 ns;
signal input_val:std_logic_vector(15 downto 0):="0000000000000000";

begin
dut_instance: mem_ins port map(input_val,read_en,addr,clk,open,load_en);
clock<= not(clock) after timeperiod/2;
input_val<=to_stdlogicvector((to_integer(unsigned(input_val))+1),16) after timeperiod/2;
end TB_BEHAVIOR;