clear; clc; close all;

fprintf('Starting 3D projectile trajectory simulation...\n');

g = 9.81;
m = 0.145;
rho = 1.225;
C_d = 0.47;
A = 0.0042;

drag_const = 0.5 * rho * A * C_d;

v0_magnitude = 50;
launch_angle = 35;
azimuth_angle = 10;

theta = deg2rad(launch_angle);
phi = deg2rad(azimuth_angle);

v0_x = v0_magnitude * cos(theta) * cos(phi);
v0_y = v0_magnitude * cos(theta) * sin(phi);
v0_z = v0_magnitude * sin(theta);

initial_conditions = [0; 0; 0; v0_x; v0_y; v0_z];

t_start = 0;
t_end = 10;
t_span = [t_start t_end];

ode_system = @(t, y) [
    y(4);
    y(5);
    y(6);
    -(drag_const/m) * sqrt(y(4)^2 + y(5)^2 + y(6)^2) * y(4);
    -(drag_const/m) * sqrt(y(4)^2 + y(5)^2 + y(6)^2) * y(5);
    -g - (drag_const/m) * sqrt(y(4)^2 + y(5)^2 + y(6)^2) * y(6);
];

options = odeset('Events', @ground_hit_event);
[t, sol] = ode45(ode_system, t_span, initial_conditions, options);

t_ideal = linspace(0, t(end), length(t));
x_ideal = v0_x * t_ideal;
y_ideal = v0_y * t_ideal;
z_ideal = v0_z * t_ideal - 0.5 * g * t_ideal.^2;
z_ideal(z_ideal < 0) = 0;
ideal_traj = [x_ideal', y_ideal', z_ideal'];

save('projectile_data.mat', 't', 'sol', 'ideal_traj');

fprintf('Simulation finished. Data saved to projectile_data.mat\n');

function [value, isterminal, direction] = ground_hit_event(t, y)
    value = y(3);
    isterminal = 1;
    direction = -1;
end
