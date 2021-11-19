clc
clear
%% varibles declaration
ui_population=zeros(20,23);     %   row is population amount time line(sample time:5 years) , and column is
                                %   amount of each age,last column is the sum of all citizens
f_birthrate=0.008;

ui_agelevel=11;
                                
%% initialize parameters
ui_temp=load('data.txt')';
f_deathrate=ui_temp(67:88);
ui_counter=1;
for i=1:ui_agelevel
   ui_population(1,i)=ui_temp(ui_counter);
   ui_counter=ui_counter+3;
end
ui_population(1,23)=sum(ui_population(1,:));

%% start the calculation
for i=2:20
   ui_population(i,1)=ui_population(i-1,23)*f_birthrate;
   for j=2:22
       ui_population(i,j)=ui_population(i-1,j-1)*(1-f_deathrate(j-1));
   end
   ui_population(i,23)=sum(ui_population(i,:)); 
end

%% plot
num=0:5:95;
plot(num,ui_population(:,1:11)');
%legend('0','1-4','5-9','10-14','15-19','20-24','25-29','30-34','35-39','40-44','45-49','50-54','55-59','60-64','65-69','70-74','75-79','80-84','85-89','90-94','95-100');
z=diff(ui_population(:,23)');
