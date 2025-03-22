LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY vga_controller_tb IS
END vga_controller_tb;

ARCHITECTURE behavior OF vga_controller_tb IS
  -- ���ե��x���H���w�q
  SIGNAL pixel_clk : STD_LOGIC := '0';  -- 40MHz�e������
  SIGNAL i_reset   : STD_LOGIC := '1';  -- �D�P�B�_��H�� (�w�]������)
  SIGNAL h_sync    : STD_LOGIC;         -- �����P�B�H��
  SIGNAL v_sync    : STD_LOGIC;         -- �����P�B�H��
  SIGNAL o_red         : STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit ����
  SIGNAL o_green         : STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit ���
  SIGNAL o_blue         : STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit �Ŧ�

  -- ��Ҥ�vga_controller
  COMPONENT vga_controller IS
    GENERIC(
      h_pulse  : INTEGER := 128;
      h_bp     : INTEGER := 88;
      h_pixels : INTEGER := 800;
      h_fp     : INTEGER := 40;
      h_pol    : STD_LOGIC := '0';

      v_pulse  : INTEGER := 4;
      v_bp     : INTEGER := 23;
      v_pixels : INTEGER := 600;
      v_fp     : INTEGER := 1;
      v_pol    : STD_LOGIC := '1'
    );
    PORT(
      pixel_clk : IN  STD_LOGIC;
      i_reset   : IN  STD_LOGIC;
      h_sync    : OUT STD_LOGIC;
      v_sync    : OUT STD_LOGIC;
      o_red     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      o_green   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      o_blue    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;

BEGIN
  -- ��Ҥ�vga_controller
  uut: vga_controller
    PORT MAP(
      pixel_clk => pixel_clk,
      i_reset   => i_reset,
      h_sync    => h_sync,
      v_sync    => v_sync,
      o_red     => o_red,
      o_green         => o_green,
      o_blue         => o_blue
    );

  -- ����pixel_clk (40MHz)
  CLOCK_PROC: PROCESS
  BEGIN
    -- 40MHz���� (�C25ns½��@��)
    pixel_clk <= '0';
    WAIT FOR 12.5 ns;
    pixel_clk <= '1';
    WAIT FOR 12.5 ns;
  END PROCESS;

  -- ����reset_n�T��
  RESET_PROC: PROCESS
  BEGIN
    -- ���Ҳն}�l�ɥ��_��
    i_reset <= '0';
    WAIT FOR 20 ns;
    i_reset <= '1';  -- �Ѱ��_��
    WAIT FOR 1000 ns;
    -- �i�H�[�J��h�����լy�{
    WAIT;
  END PROCESS;

END behavior;
