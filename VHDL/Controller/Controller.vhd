library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
	port(
		
		ctl_clk, ctl_rst: in std_logic;
		
		ctl_comp_eq, ctl_comp_lt: in std_logic;
		ctl_C, ctl_O, ctl_S: in std_logic;
		ctl_RI: in std_logic_vector(15 downto 0);
		
		ctl_ld_i0, ctl_ld_i1: out std_logic;
		
		ctl_ld_o0, ctl_ld_o1: out std_logic;
		
		ctl_addr_i0, ctl_addr_o0, ctl_addr_o1, ctl_addr_pc: out std_logic_vector(1 downto 0);
		ctl_addr_o2: out std_logic;
		
		ctl_ld_r0, ctl_ld_r1, ctl_ld_r2, ctl_ld_r3: out std_logic;
		ctl_ld_o, ctl_ld_c, ctl_ld_s: out std_logic;
		ctl_ld_pc, ctl_rst_pc, ctl_ld_rp, ctl_ld_ri, ctl_ld_eq, ctl_ld_lt: out std_logic;
		
		ctl_wr_md: out std_logic;
		
		ctl_ula_code: out std_logic_vector(2 downto 0)
		
		-- Controle de Estado
		--s_state: out integer
	);
end controller;

architecture arc_controller of controller is
type state_type is (init, fetch, decoder, 
							s_add, s_sub, s_and, s_or, s_xor, s_srl, s_sll, s_sra, 
							s_addi, s_andi, s_ori, s_xori, 
							s_ld, s_st, s_nop, 
							s_beq1, s_beq, s_blt1, s_blt, s_bge1, s_bge,
							s_call, s_ret, 
							s_in, s_out, 
							s_brc, s_brs,s_bro,
							s_delay);
							
signal state: state_type := init;
signal s_state: integer;

begin

	-- Logic to advance to the next state
	process (ctl_clk, ctl_rst)
	begin
		if ctl_rst = '1' then
			state <= init;
			s_state <= 0;
		elsif (rising_edge(ctl_clk)) then
			case state is
				when init =>
					state <= fetch;
					s_state <= 1;
				when fetch =>
					state <= decoder;
					s_state <= 2;
				when decoder =>
					
					case ctl_RI(15 downto 13) is
						when "000" =>
							case ctl_RI(12 downto 10) is
								when "000" =>
									state <= s_add;
									s_state <= 10;
								when "001" =>
									state <= s_sub;
									s_state <= 11;
								when "010" =>
									state <= s_and;
									s_state <= 12;
								when "011" =>
									state <= s_or;
									s_state <= 13;
								when "100" =>
									state <= s_xor;
									s_state <= 14;
								when "101" =>
									state <= s_srl;
									s_state <= 15;
								when "110" =>
									state <= s_sll;
									s_state <= 16;
								when "111" =>
									state <= s_sra;
									s_state <= 17;
							end case;
						when "001" =>
							case ctl_RI(12) is
								when '0' =>
									state <= s_addi;
									s_state <= 20;
								when '1' =>
									state <= s_andi;
									s_state <= 21;
							end case;
						when "010" =>
							case ctl_RI(12) is
								when '0' =>
									state <= s_ori;
									s_state <= 30;
								when '1' =>
									state <= s_xori;
									s_state <= 31;
							end case;
						when "011" =>
							case ctl_RI(12 downto 11) is
								when "00" =>
									state <= s_ld;
									s_state <= 40;
								when "01" =>
									state <= s_st;
									s_state <= 41;
								when "10" =>
									state <= s_nop;
									s_state <= 42;
								when "11" =>
									state <= fetch;
									s_state <= 1;
							end case;
						when "100" =>
							case ctl_RI(12 downto 11) is
								when "00" =>
									state <= s_beq1;
									s_state <= 50;
								when "01" =>
									state <= s_blt1;
									s_state <= 51;
								when "10" =>
									state <= s_bge1;
									s_state <= 52;
								when "11" =>
									state <= fetch;
									s_state <= 1;
							end case;
						when "101" =>
							case ctl_RI(12) is
								when '0' =>
									state <= s_call;
									s_state <= 60;
								when '1' =>
									state <= s_ret;
									s_state <= 61;
							end case;
						when "110" =>
							case ctl_RI(12) is
								when '0' =>
									state <= s_in;
									s_state <= 70;
								when '1' =>
									state <= s_out;
									s_state <= 71;
							end case;
						when "111" =>
							case ctl_RI(12 downto 11) is
								when "00" =>
									state <= s_brc;
									s_state <= 80;
								when "01" =>
									state <= s_bro;
									s_state <= 81;
								when "10" =>
									state <= s_brs;
									s_state <= 82;
								when "11" =>
									state <= fetch;
									s_state <= 1;
							end case;
					end case;
					
				when s_add =>
					state <= s_delay;
					s_state <= 100;
				when s_sub =>
					state <= s_delay;
					s_state <= 100;
				when s_and =>
					state <= s_delay;
					s_state <= 100;
				when s_or =>
					state <= s_delay;
					s_state <= 100;
				when s_xor =>
					state <= s_delay;
					s_state <= 100;
				when s_srl =>
					state <= s_delay;
					s_state <= 100;
				when s_sll =>
					state <= s_delay;
					s_state <= 100;
				when s_sra =>
					state <= s_delay;
					s_state <= 100;
				when s_addi =>
					state <= s_delay;
					s_state <= 100;
				when s_andi =>
					state <= s_delay;
					s_state <= 100;
				when s_ori =>
					state <= s_delay;
					s_state <= 100;
				when s_xori =>
					state <= s_delay;
					s_state <= 100;
				when s_ld =>
					state <= s_delay;
					s_state <= 100;
				when s_st =>
					state <= s_delay;
					s_state <= 100;
				when s_nop =>
					state <= s_delay;
					s_state <= 100;
				when s_beq1 =>
					state <= s_beq;
					s_state <= 90;
				when s_beq =>
					state <= fetch;
					s_state <= 1;
				when s_blt1 =>
					state <= s_blt;
					s_state <= 91;
				when s_blt =>
					state <= fetch;
					s_state <= 1;
				when s_bge1 =>
					state <= s_bge;
					s_state <= 92;
				when s_bge =>
					state <= fetch;
					s_state <= 1;
				when s_call =>
					state <= s_delay;
					s_state <= 100;
				when s_ret =>
					state <= s_delay;
					s_state <= 100;
				when s_in =>
					state <= s_delay;
					s_state <= 100;
				when s_out =>
					state <= s_delay;
					s_state <= 100;
				when s_brc =>
					state <= s_delay;
					s_state <= 100;
				when s_bro =>
					state <= s_delay;
					s_state <= 100;
				when s_brs =>
					state <= s_delay;
					s_state <= 100;
				when s_delay =>
					state <= fetch;
					s_state <= 1;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process(state)
	begin
		case state is
			when init =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				ctl_ld_r0 <= '1';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '1';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when fetch =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '1';
				
				--ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
			when decoder =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
			when s_add =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '1';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";

			when s_sub =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '1';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "001";

			when s_and =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "010";

			when s_or =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "011";
				
			when s_xor =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "100";
								
			when s_srl =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "101";

			when s_sll =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "110";

			when s_sra =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(9 downto 8) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(7 downto 6);
				ctl_addr_o1 <= ctl_RI(5 downto 4);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "111";

			when s_addi =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(11 downto 10) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '1';
				ctl_ld_c <= '1';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(9 downto 8); --RS1
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '1';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_andi =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(11 downto 10) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(9 downto 8); --RS1
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '1';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "010";
				
			when s_ori =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(11 downto 10) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(9 downto 8); --RS1
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '1';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "011";

			when s_xori =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '1';
				
				case ctl_RI(11 downto 10) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '1';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "11";
				ctl_addr_o0 <= ctl_RI(9 downto 8); --RS1
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '1';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "100";
				
			when s_ld =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				
				case ctl_RI(10 downto 9) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "10";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= ctl_RI(8 downto 7);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_st =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "10";
				ctl_addr_o0 <= ctl_RI(8 downto 7);
				ctl_addr_o1 <= ctl_RI(10 downto 9);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '1';
				
				ctl_ula_code <= "000";
				
			when s_nop =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_beq1 =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				ctl_ld_r0 <= '1';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= ctl_RI(10 downto 9);
				ctl_addr_o1 <= ctl_RI(8 downto 7);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_beq =>
				ctl_ld_pc <= '1';
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				if (ctl_comp_eq = '1') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
			when s_blt1 =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				ctl_ld_r0 <= '1';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= ctl_RI(10 downto 9);
				ctl_addr_o1 <= ctl_RI(8 downto 7);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_blt =>
				ctl_ld_pc <= '1';
				
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				if (ctl_comp_lt = '1') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
			when s_bge1 =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				ctl_ld_r0 <= '1';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= ctl_RI(10 downto 9);
				ctl_addr_o1 <= ctl_RI(8 downto 7);
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_bge =>
				ctl_ld_pc <= '1';
				
				ctl_ld_eq <= '1';
				ctl_ld_lt <= '1';
				
				if (ctl_comp_lt = '0') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
			when s_call =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '1';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "01";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_ret =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "10";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_in =>
				ctl_ld_i0 <= '1';
				ctl_ld_i1 <= '1';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				
				case ctl_RI(11 downto 10) is --RD
					when "00" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "01" =>
						ctl_ld_r1 <= '1';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '0';
						
					when "10" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '1';
						ctl_ld_r3 <= '0';
						
					when "11" =>
						ctl_ld_r1 <= '0';
						ctl_ld_r2 <= '0';
						ctl_ld_r3 <= '1';
						
				end case;
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				
				case ctl_RI(9) is
					when '0' =>
						ctl_addr_i0 <= "00";
					
					when '1' =>
						ctl_addr_i0 <= "01";
						
				end case;
				
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_out =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
				
				case ctl_RI(9) is
					when '0' =>
						ctl_ld_o0 <= '1';
						ctl_ld_o1 <= '0';
					
					when '1' =>
						ctl_ld_o0 <= '0';
						ctl_ld_o1 <= '1';
						
				end case;
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				ctl_addr_pc <= "00";
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= ctl_RI(11 downto 10);
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_brc =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				if (ctl_C = '1') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_bro =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				if (ctl_O = '1') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_brs =>
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '1';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
				
				if (ctl_S = '1') then
					ctl_addr_pc <= "11";
				else
					ctl_addr_pc <= "00";
				end if;
				
				ctl_addr_i0 <= "00";
				ctl_addr_o0 <= "00";
				ctl_addr_o1 <= "00";
				ctl_addr_o2 <= '0';
				
				ctl_wr_md <= '0';
				
				ctl_ula_code <= "000";
				
			when s_delay =>
				-- Nada (Apenas Atraso)
				ctl_ld_i0 <= '0';
				ctl_ld_i1 <= '0';
		
				ctl_ld_o0 <= '0';
				ctl_ld_o1 <= '0';
				
				--ctl_ld_r0 <= '0';
				ctl_ld_r1 <= '0';
				ctl_ld_r2 <= '0';
				ctl_ld_r3 <= '0';
				
				ctl_ld_o <= '0';
				ctl_ld_c <= '0';
				ctl_ld_s <= '0';
				
				ctl_ld_eq <= '0';
				ctl_ld_lt <= '0';
				
				ctl_ld_pc <= '0';
				ctl_rst_pc <= '0';
				ctl_ld_rp <= '0';
				ctl_ld_ri <= '0';
		end case;
	end process;

end arc_controller;