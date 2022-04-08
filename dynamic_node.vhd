library ieee;
use ieee.std_logic_1164.all;

entity dynamicnode is 
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
end dynamicnode;

architecture behaviour of dynamicnode is 
begin 
gout <= gcurrent or (gprevious and pcurrent);
pout <= pcurrent and Pprevious;
end behaviour ;