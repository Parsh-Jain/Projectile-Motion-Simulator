clear; clc; close all;

try
    load('projectile_data.mat');
catch
    error('Could not find projectile_data.mat. Please run projectile_simulation.m first.');
end

x_drag = sol(:, 1);
y_drag = sol(:, 2);
z_drag = sol(:, 3);

x_ideal = ideal_traj(:, 1);
y_ideal = ideal_traj(:, 2);
z_ideal = ideal_traj(:, 3);

fprintf('Data loaded. Generating 3D plot...\n');

figure('Name', '3D Projectile Trajectory', 'Color', 'w');
hold on;

plot3(x_drag, y_drag, z_drag, 'b-', 'LineWidth', 2.5);
plot3(x_ideal, y_ideal, z_ideal, 'r--', 'LineWidth', 2);

plot3(x_drag(1), y_drag(1), z_drag(1), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot3(x_drag(end), y_drag(end), z_drag(end), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');

max_range = max(max(x_ideal), max(y_ideal));
ground_x = [0, max_range, max_range, 0];
ground_y = [0, 0, max_range, max_range];
ground_z = [0, 0, 0, 0];
patch(ground_x, ground_y, ground_z, 'k', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

title('Projectile Traje
