function [scenario, egoVehicle] = vehicleSimulatorSpeed(speedEgo, positions, obstacleX, obstacleY, speedObstacle, ObstaclecarX, ObstaclecarY)
    % createDrivingScenario Returns the drivingScenario defined in the Designer
    % Edited by Prasad and Frank
    % createDrivingScenario Returns the drivingScenario defined in the Designer

    % Generated by MATLAB(R) 9.7 (R2019b) and Automated Driving Toolbox 3.0 (R2019b).
    % Generated on: 07-Dec-2020 17:19:04

    % Construct a drivingScenario object.
    scenario = drivingScenario;

    % Add all road segments
    roadCenters = [0 20 0;
        110 20 0];
    marking = [laneMarking('Solid', 'Color', [0.98 0.86 0.36], 'Width', 1e-05, 'Strength', 0)
        laneMarking('Dashed')];
    laneSpecification = lanespec(1, 'Width', 20, 'Marking', marking);
    road(scenario, roadCenters, 'Lanes', laneSpecification);

    % Add the ego vehicle
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [103.994048300763 13.077549886967 0], ...
        'FrontOverhang', 0.9);
    waypoints = [positions zeros(size(positions, 1), 1)];
    trajectory(egoVehicle, waypoints, speedEgo);

    % Add the Obstacle vehicle
    positionVehicle = [ObstaclecarX; ObstaclecarY]';
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [103.994048300763 13.077549886967 0], ...
        'FrontOverhang', 0.9);
    waypoints = [positionVehicle zeros(size(positionVehicle, 1), 1)];
    trajectory(egoVehicle, waypoints, speedObstacle);
    
    % Add the non-ego actors
    for i = 1:length(obstacleX)
        obstacleXi = obstacleX(i);
        obstacleYi = obstacleY(i);
        actor(scenario, ...
            'ClassID', 5, ...
            'Length', 2.4, ...
            'Width', 0.76, ...
            'Height', 0.8, ...
            'Position', [obstacleXi obstacleYi 0]);
    end

    drivingScenarioDesigner(scenario)
end