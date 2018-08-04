%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lossless Transmission Line Standing Wave Model
% by: Ethan Lyons
% 8/4/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = 0.5;          % ratio of Vo-/Vo+  result of load impedance [-1:1]
R_phi = pi/2;   % phase shift due to load ( dependent on load and line impedence, set as arbitrary in this model)

c = 299792458;  % speed of light
lambda = 1e-3;  
f = c/lambda;
w = 2*pi*f;
v_o_plus = 1;                                                                               % transmitted wave voltage

beta = 2*pi/lambda;                                                                         % lossless propogation constant (alpha=0): sqrt((R+jwL)(G+jwC)) = alpha+j*beta where beta = 2*pi/lambda

num_wavelengths_to_plot = 1;

z = linspace(0,num_wavelengths_to_plot*lambda,num_wavelengths_to_plot*100);                 % distance
t = linspace(0,10/f,10000);                                                                 % time



for i = 1:length(t)

    V_mag = abs(v_o_plus)*sqrt(1+(abs(R)^2)+2*abs(R)*cos(2*beta*z+R_phi));                  % magnitude of standing wave

    V = v_o_plus*exp(1j*w*t(i))*(exp(-1j*beta*z)+abs(R)*exp(1j*R_phi)*exp(1j*beta*z));      % interfered standing wave
    
    v1 = v_o_plus*exp(1j*w*t(i))*exp(-1j*beta*z);                                           % transmission
    v2 = abs(R)*exp(1j*R_phi)*v_o_plus*exp(1j*w*t(i))*exp(1j*beta*z);                       % reflection
    
    plot(z,V_mag,'r')
    hold on
    plot(z,-V_mag,'r')
    plot(z,real(V),'bo')
    plot(0,2*v_o_plus)  % to keep axes from shrinking with wave
    plot(0,-2*v_o_plus) % not relevant data...
    plot(z,real(v1),'c');
    plot(z,real(v2),'g');
    
    legend('+magnitude','-magnitude','standingwave','transmission wave', 'reflection wave')
    %title('Standing Wave vs Distance')
    
    hold off
    
    pause(0.0001)
end