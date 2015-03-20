function [ local_min_location, local_max_location ] = localmmFind( mat )
%find the location of local_min and local_max
t = 0 : length(mat) - 1;
Lmax = diff(sign(diff(mat))) == -2;
Lmin = diff(sign(diff(mat))) == 2;

Lmax = [false; Lmax; false];
Lmin =  [false; Lmin; false];
local_max_location = t (Lmax); % locations of the local max elements
local_min_location = t (Lmin); % locations of the local min elements


end

