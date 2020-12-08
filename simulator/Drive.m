function [scenario, egoVehicle] = Drive(speed, positions, obstacleX, obstacleY, ObstaclecarX1, ObstaclecarY1, ObstaclecarX2, ObstaclecarY2)
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
    trajectory(egoVehicle, waypoints, speed);

    % Add the Obstacle vehicle 1
    positionVehicle1 = [ObstaclecarX1; ObstaclecarY1]';
    egoVehicle = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [103.994048300763 13.077549886967 0], ...
        'FrontOverhang', 0.9);
    waypoints = [positionVehicle1 zeros(size(positionVehicle1, 1), 1)];
    trajectory(egoVehicle, waypoints, speed*0.75);
    
    
   % Add the Obstacle vehicle 2
    positionVehicle2 = [ObstaclecarX2; ObstaclecarY2]';
    v2 = vehicle(scenario, ...
        'ClassID', 1, ...
        'Position', [103.994048300763 13.077549886967 0]);
    waypoints = [positionVehicle2 zeros(size(positionVehicle2, 1), 1)];
    trajectory(v2, waypoints, speed*.8);
    
    
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

    % adding camera
    camera = visionDetectionGenerator('SensorLocation',[0 0],'Yaw',0);
    
    drivingScenarioDesigner(scenario, camera)
end