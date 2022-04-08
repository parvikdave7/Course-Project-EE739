----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2020 20:38:38
-- Design Name: 
-- Module Name: KS_Adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity KS_Adder is
port(
    x   : IN std_logic_vector (15 downto 0);
    y   : IN std_logic_vector (15 downto 0);
    cin : IN std_logic;
    sum : OUT std_logic_vector (15 downto 0);
    cout: OUT std_logic);
end KS_Adder;

architecture Behavioral of KS_Adder is
component essentialnode is 
port (
    -- node input terminal 
    x : IN std_logic ;
    -- node input terminal 
    y : IN std_logic ;
    -- g output terminlal of node 
    g : OUT std_logic ;
    -- P output terminal  of node 
    p : OUT std_logic 
    );
    end component;
    ----------------------------------------------
    -- the dynamic node which change and get the previous p and g and give new state 
    ----------------------------------------------
component dynamicnode is 
port (
    -- node inputs terminals 
    Pprevious : IN std_logic ;
    Gprevious : IN std_logic ;
    pcurrent  : IN std_logic ;
    gcurrent  : IN std_logic ;
    -- node outputs terminals 
    pout : OUT std_logic ;
    gout : OUT std_logic 
    );
end component;
signal gin: std_logic_vector (15 downto 0);
signal pin: std_logic_vector (15 downto 0);
signal g1: std_logic_vector (15 downto 0);
signal p1: std_logic_vector (15 downto 0);
signal g2: std_logic_vector (15 downto 0);
signal p2: std_logic_vector (15 downto 0);
signal g3: std_logic_vector (15 downto 0);
signal p3: std_logic_vector (15 downto 0);
signal g4: std_logic_vector (15 downto 0);
signal p4: std_logic_vector (15 downto 0);
signal c : std_logic_vector (15 downto 0);
begin
-- Stage 0
    s0n1: essentialnode port map (x => x(0),y => y(0),g => gin(0),p => pin(0));
    s0n2: essentialnode port map (x => x(1),y => y(1),g => gin(1),p => pin(1));
    s0n3: essentialnode port map (x => x(2),y => y(2),g => gin(2),p => pin(2));
    s0n4: essentialnode port map (x => x(3),y => y(3),g => gin(3),p => pin(3));
    s0n5: essentialnode port map (x => x(4),y => y(4),g => gin(4),p => pin(4));
    s0n6: essentialnode port map (x => x(5),y => y(5),g => gin(5),p => pin(5));
    s0n7: essentialnode port map (x => x(6),y => y(6),g => gin(6),p => pin(6));
    s0n8: essentialnode port map (x => x(7),y => y(7),g => gin(7),p => pin(7));
    s0n9: essentialnode port map (x => x(8),y => y(8),g => gin(8),p => pin(8));
    s0n10: essentialnode port map (x => x(9),y => y(9),g => gin(9),p => pin(9));
    s0n11: essentialnode port map (x => x(10),y => y(10),g => gin(10),p => pin(10));
    s0n12: essentialnode port map (x => x(11),y => y(11),g => gin(11),p => pin(11));
    s0n13: essentialnode port map (x => x(12),y => y(12),g => gin(12),p => pin(12));
    s0n14: essentialnode port map (x => x(13),y => y(13),g => gin(13),p => pin(13));
    s0n15: essentialnode port map (x => x(14),y => y(14),g => gin(14),p => pin(14));
    s0n16: essentialnode port map (x => x(15),y => y(15),g => gin(15),p => pin(15));

-- Stage 1
g1(0) <= gin(0);
p1(0) <= pin(0);

    s1n1: dynamicnode port map (Gprevious => gin(0),Pprevious => pin(0),gcurrent => gin(1),pcurrent => pin(1) ,gout => g1(1) ,pout => p1(1));
    s1n2: dynamicnode port map (Gprevious => gin(1),Pprevious => pin(1),gcurrent => gin(2),pcurrent => pin(2) ,gout => g1(2) ,pout => p1(2));
    s1n3: dynamicnode port map (Gprevious => gin(2),Pprevious => pin(2),gcurrent => gin(3),pcurrent => pin(3) ,gout => g1(3) ,pout => p1(3));
    s1n4: dynamicnode port map (Gprevious => gin(3),Pprevious => pin(3),gcurrent => gin(4),pcurrent => pin(4) ,gout => g1(4) ,pout => p1(4));
    s1n5: dynamicnode port map (Gprevious => gin(4),Pprevious => pin(4),gcurrent => gin(5),pcurrent => pin(5) ,gout => g1(5) ,pout => p1(5));
    s1n6: dynamicnode port map (Gprevious => gin(5),Pprevious => pin(5),gcurrent => gin(6),pcurrent => pin(6) ,gout => g1(6) ,pout => p1(6));
    s1n7: dynamicnode port map (Gprevious => gin(6),Pprevious => pin(6),gcurrent => gin(7),pcurrent => pin(7) ,gout => g1(7) ,pout => p1(7));
    s1n8: dynamicnode port map (Gprevious => gin(7),Pprevious => pin(7),gcurrent => gin(8),pcurrent => pin(8) ,gout => g1(8) ,pout => p1(8));
    s1n9: dynamicnode port map (Gprevious => gin(8),Pprevious => pin(8),gcurrent => gin(9),pcurrent => pin(9) ,gout => g1(9) ,pout => p1(9));
    s1n10: dynamicnode port map (Gprevious => gin(9),Pprevious => pin(9),gcurrent => gin(10),pcurrent => pin(10) ,gout => g1(10) ,pout => p1(10));
    s1n11: dynamicnode port map (Gprevious => gin(10),Pprevious => pin(10),gcurrent => gin(11),pcurrent => pin(11) ,gout => g1(11) ,pout => p1(11));
    s1n12: dynamicnode port map (Gprevious => gin(11),Pprevious => pin(11),gcurrent => gin(12),pcurrent => pin(12) ,gout => g1(12) ,pout => p1(12));
    s1n13: dynamicnode port map (Gprevious => gin(12),Pprevious => pin(12),gcurrent => gin(13),pcurrent => pin(13) ,gout => g1(13) ,pout => p1(13));
    s1n14: dynamicnode port map (Gprevious => gin(13),Pprevious => pin(13),gcurrent => gin(14),pcurrent => pin(14) ,gout => g1(14) ,pout => p1(14));
    s1n15: dynamicnode port map (Gprevious => gin(14),Pprevious => pin(14),gcurrent => gin(15),pcurrent => pin(15) ,gout => g1(15) ,pout => p1(15));

-- Stage 2
g2(0) <= g1(0);
p2(0) <= p1(0);
g2(1) <= g1(1);
p2(1) <= p1(1);

    s2n1: dynamicnode port map (Gprevious => g1(0),Pprevious => p1(0),gcurrent => g1(2),pcurrent => p1(2) ,gout => g2(2) ,pout => p2(2));
    s2n2: dynamicnode port map (Gprevious => g1(1),Pprevious => p1(1),gcurrent => g1(3),pcurrent => p1(3) ,gout => g2(3) ,pout => p2(3));
    s2n3: dynamicnode port map (Gprevious => g1(2),Pprevious => p1(2),gcurrent => g1(4),pcurrent => p1(4) ,gout => g2(4) ,pout => p2(4));
    s2n4: dynamicnode port map (Gprevious => g1(3),Pprevious => p1(3),gcurrent => g1(5),pcurrent => p1(5) ,gout => g2(5) ,pout => p2(5));
    s2n5: dynamicnode port map (Gprevious => g1(4),Pprevious => p1(4),gcurrent => g1(6),pcurrent => p1(6) ,gout => g2(6) ,pout => p2(6));
    s2n6: dynamicnode port map (Gprevious => g1(5),Pprevious => p1(5),gcurrent => g1(7),pcurrent => p1(7) ,gout => g2(7) ,pout => p2(7));
    s2n7: dynamicnode port map (Gprevious => g1(6),Pprevious => p1(6),gcurrent => g1(8),pcurrent => p1(8) ,gout => g2(8) ,pout => p2(8));
    s2n8: dynamicnode port map (Gprevious => g1(7),Pprevious => p1(7),gcurrent => g1(9),pcurrent => p1(9) ,gout => g2(9) ,pout => p2(9));
    s2n9: dynamicnode port map (Gprevious => g1(8),Pprevious => p1(8),gcurrent => g1(10),pcurrent => p1(10) ,gout => g2(10) ,pout => p2(10));
    s2n10: dynamicnode port map (Gprevious => g1(9),Pprevious => p1(9),gcurrent => g1(11),pcurrent => p1(11) ,gout => g2(11) ,pout => p2(11));
    s2n11: dynamicnode port map (Gprevious => g1(10),Pprevious => p1(10),gcurrent => g1(12),pcurrent => p1(12) ,gout => g2(12) ,pout => p2(12));
    s2n12: dynamicnode port map (Gprevious => g1(11),Pprevious => p1(11),gcurrent => g1(13),pcurrent => p1(13) ,gout => g2(13) ,pout => p2(13));    
    s2n13: dynamicnode port map (Gprevious => g1(12),Pprevious => p1(12),gcurrent => g1(14),pcurrent => p1(14) ,gout => g2(14) ,pout => p2(14));
    s2n14: dynamicnode port map (Gprevious => g1(13),Pprevious => p1(13),gcurrent => g1(15),pcurrent => p1(15) ,gout => g2(15) ,pout => p2(15));
    
-- Stage 3
g3(0) <= g2(0);
p3(0) <= p2(0);
g3(1) <= g2(1);
p3(1) <= p2(1);
g3(2) <= g2(2);
p3(2) <= p2(2);
g3(3) <= g2(3);
p3(3) <= p2(3);

    s3n1: dynamicnode port map (Gprevious => g2(0),Pprevious => p2(0),gcurrent => g2(4),pcurrent => p2(4) ,gout => g3(4) ,pout => p3(4));
    s3n2: dynamicnode port map (Gprevious => g2(1),Pprevious => p2(1),gcurrent => g2(5),pcurrent => p2(5) ,gout => g3(5) ,pout => p3(5));
    s3n3: dynamicnode port map (Gprevious => g2(2),Pprevious => p2(2),gcurrent => g2(6),pcurrent => p2(6) ,gout => g3(6) ,pout => p3(6));
    s3n4: dynamicnode port map (Gprevious => g2(3),Pprevious => p2(3),gcurrent => g2(7),pcurrent => p2(7) ,gout => g3(7) ,pout => p3(7));
    s3n5: dynamicnode port map (Gprevious => g2(4),Pprevious => p2(4),gcurrent => g2(8),pcurrent => p2(8) ,gout => g3(8) ,pout => p3(8));
    s3n6: dynamicnode port map (Gprevious => g2(5),Pprevious => p2(5),gcurrent => g2(9),pcurrent => p2(9) ,gout => g3(9) ,pout => p3(9));
    s3n7: dynamicnode port map (Gprevious => g2(6),Pprevious => p2(6),gcurrent => g2(10),pcurrent => p2(10) ,gout => g3(10) ,pout => p3(10));
    s3n8: dynamicnode port map (Gprevious => g2(7),Pprevious => p2(7),gcurrent => g2(11),pcurrent => p2(11) ,gout => g3(11) ,pout => p3(11));
    s3n9: dynamicnode port map (Gprevious => g2(8),Pprevious => p2(8),gcurrent => g2(12),pcurrent => p2(12) ,gout => g3(12) ,pout => p3(12));
    s3n10: dynamicnode port map (Gprevious => g2(9),Pprevious => p2(9),gcurrent => g2(13),pcurrent => p2(13) ,gout => g3(13) ,pout => p3(13));
    s3n11: dynamicnode port map (Gprevious => g2(10),Pprevious => p2(10),gcurrent => g2(14),pcurrent => p2(14) ,gout => g3(14) ,pout => p3(14));
    s3n12: dynamicnode port map (Gprevious => g2(11),Pprevious => p2(11),gcurrent => g2(15),pcurrent => p2(15) ,gout => g3(15) ,pout => p3(15));
    
-- Stage 4
g4(0) <= g3(0);
p4(0) <= p3(0);
g4(1) <= g3(1);
p4(1) <= p3(1);
g4(2) <= g3(2);
p4(2) <= p3(2);
g4(3) <= g3(3);
p4(3) <= p3(3);
g4(4) <= g3(4);
p4(4) <= p3(4);
g4(5) <= g3(5);
p4(5) <= p3(5);
g4(6) <= g3(6);
p4(6) <= p3(6);
g4(7) <= g3(7);
p4(7) <= p3(7);

    s4n1: dynamicnode port map (Gprevious => g3(0),Pprevious => p3(0),gcurrent => g3(8),pcurrent => p3(8) ,gout => g4(8) ,pout => p4(8));
    s4n2: dynamicnode port map (Gprevious => g3(1),Pprevious => p3(1),gcurrent => g3(9),pcurrent => p3(9) ,gout => g4(9) ,pout => p4(9));
    s4n3: dynamicnode port map (Gprevious => g3(2),Pprevious => p3(2),gcurrent => g3(10),pcurrent => p3(10) ,gout => g4(10) ,pout => p4(10));
    s4n4: dynamicnode port map (Gprevious => g3(3),Pprevious => p3(3),gcurrent => g3(11),pcurrent => p3(11) ,gout => g4(11) ,pout => p4(11));
    s4n5: dynamicnode port map (Gprevious => g3(4),Pprevious => p3(4),gcurrent => g3(12),pcurrent => p3(12) ,gout => g4(12) ,pout => p4(12));
    s4n6: dynamicnode port map (Gprevious => g3(5),Pprevious => p3(5),gcurrent => g3(13),pcurrent => p3(13) ,gout => g4(13) ,pout => p4(13));
    s4n7: dynamicnode port map (Gprevious => g3(6),Pprevious => p3(6),gcurrent => g3(14),pcurrent => p3(14) ,gout => g4(14) ,pout => p4(14));
    s4n8: dynamicnode port map (Gprevious => g3(7),Pprevious => p3(7),gcurrent => g3(15),pcurrent => p3(15) ,gout => g4(15) ,pout => p4(15));
    
-- Computation of Carry & Sum

c(0) <= g4(0) or (cin and p4(0));
c(1) <= g4(1) or (cin and p4(1));
c(2) <= g4(2) or (cin and p4(2));
c(3) <= g4(3) or (cin and p4(3));
c(4) <= g4(4) or (cin and p4(4));
c(5) <= g4(5) or (cin and p4(5));
c(6) <= g4(6) or (cin and p4(6));
c(7) <= g4(7) or (cin and p4(7));
c(8) <= g4(8) or (cin and p4(8));
c(9) <= g4(9) or (cin and p4(9));
c(10) <= g4(10) or (cin and p4(10));
c(11) <= g4(11) or (cin and p4(11));
c(12) <= g4(12) or (cin and p4(12));
c(13) <= g4(13) or (cin and p4(13));
c(14) <= g4(14) or (cin and p4(14));
c(15) <= g4(15) or (cin and p4(15));

cout <= c(15);

sum(0) <= cin xor pin(0);
sum(1) <= c(0) xor pin(1);
sum(2) <= c(1) xor pin(2);
sum(3) <= c(2) xor pin(3);
sum(4) <= c(3) xor pin(4);
sum(5) <= c(4) xor pin(5);
sum(6) <= c(5) xor pin(6);
sum(7) <= c(6) xor pin(7);
sum(8) <= c(7) xor pin(8);
sum(9) <= c(8) xor pin(9);
sum(10) <= c(9) xor pin(10);
sum(11) <= c(10) xor pin(11);
sum(12) <= c(11) xor pin(12);
sum(13) <= c(12) xor pin(13);
sum(14) <= c(13) xor pin(14);
sum(15) <= c(14) xor pin(15);               
end Behavioral;
