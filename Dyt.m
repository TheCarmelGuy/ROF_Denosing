% forward difference in the y direction
function d = Dy(u) 
    
    [rows,cols] = size(u);
    d = zeros(rows, cols); 
    d(1:rows-1,:) = u(1:rows - 1,:) - u(2:rows,:);
    d(rows,:) = u(rows,:) - u(1,:);
return