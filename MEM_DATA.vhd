library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity MEM_DATA is
port(
input_val : in std_logic_vector(15 downto 0);
read_en : in std_logic;
write_en : in std_logic;
addr : in std_logic_vector(15 downto 0);
clk : in std_logic;
reset: in std_logic;
out_val : out std_logic_vector(15 downto 0)
);
end MEM_DATA;
architecture bhav_ins of MEM_DATA is
type MemoryArray is array (0 to 8191) of STD_LOGIC_VECTOR(15 downto 0);
    signal memory : MemoryArray;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            for i in 0 to 8191 loop
					memory(i) <= std_logic_vector(to_unsigned(i, 16));
				end loop;
        elsif rising_edge(clk) then
            if write_en = '1' then
                memory(to_integer(unsigned(addr))) <= input_val;
            end if;
				if read_en = '1' then
					out_val <= memory(to_integer(unsigned(addr)));
				end if;
        end if;
    end process;
end bhav_ins;