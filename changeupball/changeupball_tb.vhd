library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_changeupball is
end tb_changeupball;

architecture behavior of tb_changeupball is

    -- �H���w�q
    signal i_clk    : std_logic := '0';          
    signal i_rst    : std_logic := '0';         
    signal i_bl     : std_logic := '0';  
    signal i_br     : std_logic := '0';  
    signal o_led    : std_logic_vector(7 downto 0);  

    -- �ɶ��`��
    constant clk_period : time := 10 ns;  -- �]�w�����g����10ns

begin

    -- ��Ҥ� changeupball ����
    uut: entity work.changeupball
        port map (
            i_clk => i_clk,
            i_rst => i_rst,
            i_bl => i_bl,
            i_br => i_br,
            o_led => o_led
        );

    -- �����ͦ�
    clk_process :process
    begin
        i_clk <= '0';
        wait for clk_period/2;
        i_clk <= '1';
        wait for clk_period/2;
    end process;

    -- ���էǦC
    stim_proc: process
    begin    
        -- ��l���m
        i_rst <= '1';
        wait for clk_period*2;
        i_rst <= '0';

        -- �����}�l
        -- ��1������
        wait for clk_period*10;
        i_bl <= '1';   -- �}�l����
        wait for clk_period*10;
        i_bl <= '0';   -- �����
        wait for clk_period*10;

        -- ��2������
        i_br <= '1';   -- �}�l�k��
        wait for clk_period*10;
        i_br <= '0';   -- ����k��
        wait for clk_period*10;

        -- �����y�I�����
        wait for clk_period*5;
        i_bl <= '1';   -- �����
        wait for clk_period*10;
        i_bl <= '0';   -- ������

        wait for clk_period*5;
        i_br <= '1';   -- �k���
        wait for clk_period*10;
        i_br <= '0';   -- ����k���

        -- ���յ���
        wait for clk_period*10;
        assert false report "Test complete" severity note;
        wait;
    end process;

end behavior;
