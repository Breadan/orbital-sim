classdef Universe

    properties
        bodies;
        timestep;
    end
    
    % Solar System Preset 
    properties(Constant)
        x_limit = [-250E9,250E9];
        y_limit = [-250E9,250E9];
        
        sunMass = 1.989E30;
        sunRadi = 696.340E6;
        sunDRad = 100;
        
        earthDist = -149.6E9;
        earthMass = 5.972E24;
        earthRadi = 6.371E6;
        earthDRad = 10;
    end

    methods(Access = public)
        %Constructor
        function obj = Universe(bodies, timestep)
            obj.bodies   = bodies;
            obj.timestep = timestep;
        end
         
        %Big bang
        function bigBang(obj, frames)
            sim = figure();
            disp("a big bang bangs...");
            for i = 1:frames
                if(~ishghandle(sim))
                    break 
                end
                
                % update physics
                for i = 1:length(obj.bodies)
                    obj.bodies(i) = PhysEng.updateCelestialBody(obj.bodies(i), obj);
                end
                
                % prepare frame below
                clf();
                hold on;
                xlim(Universe.x_limit);
                ylim(Universe.y_limit);
                % draw points below
                for i = 1:length(obj.bodies)
                    scatter(obj.bodies(i).pos(1), obj.bodies(i).pos(2), 2*obj.bodies(i).dradius, obj.bodies(i).col, 'filled');
                end
                hold off;
                drawnow();
            end
            disp("a big crunch crunches...");
        end
        
    end

      
    methods(Static)
        % Preset: Solar System
        function bodies = setSolarSystem()
            % sun
            sun = CelestialBody("The Sun",        ...
                                'RED',            ...
                                [0,0],            ...
                                [0,0],            ...
                                Universe.sunRadi, ...
                                Universe.sunDRad, ...
                                Universe.sunMass, ...
                                'static'          ...
                            );
            % mercury
            
            % venus
                        
            % earth
            earth = CelestialBody("Planet Earth",         ...
                                  'GREEN',                ...
                                  [Universe.earthDist,0], ...
                                  [30E3,1.57079],         ...
                                  Universe.earthRadi,     ...
                                  Universe.earthDRad,     ...
                                  Universe.earthMass      ...
                             ); 
            % mars
            
            % jupiter
            
            % saturn
            
            % uranus
            
            % neptune
            
            bodies = [sun, earth];
        end  
        
    end
    
end




