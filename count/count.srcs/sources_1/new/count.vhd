-- UpDownCounter.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UpDownCounter is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        up_down : in STD_LOGIC; -- �Ω��ܥ[/��p�ơG'1'��ܥ[�A'0'��ܴ�
        count : out STD_LOGIC_VECTOR (3 downto 0) -- 4-bit��X�A��ܭp�Ƶ��G
    );
end UpDownCounter;

architecture Behavioral of UpDownCounter is
    signal cnt : STD_LOGIC_VECTOR(3 downto 0) :="0000"; -- ��l�p�ƭȬ�0
begin
    process(clk, reset)
    begin
        if reset='1' then
            cnt<="0000"; -- �� reset �QĲ�o�ɡA�p���k�s
        elsif rising_edge(clk) then
            if up_down='1' then -- �[�p��
                if cnt="1001" then -- ��p�ƨ�9��
                    cnt<="0000"; -- �q�Y�}�l�p��
                else
                    cnt<=cnt+1; -- ���`�[�p��
                end if;
            else -- ��p��
                if cnt="0000" then -- ��p�ƨ�0��
                    cnt<="1001"; -- �^��9
                else
                    cnt<=cnt-1; -- ���`��p��
                end if;
            end if;
        end if;
    end process;
    count<=cnt; -- �N�����p�ƶǰe���X
end Behavioral;
