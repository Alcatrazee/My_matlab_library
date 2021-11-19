target_coorx = 5;
target_coory = 1
start_coorx = 1;
start_coory = 5;
map = zeros(5,5);
h = zeros(5,5);
g = zeros(5,5);
f = zeros(5,5);
for i=1:5
   for k=1:5
      h(i,k) = Manhaton_distance(i,k,target_coorx,target_coory);
      g(i,k) = Manhaton_distance(i,k,start_coorx,start_coory);
   end
end
h
g
f = h+g