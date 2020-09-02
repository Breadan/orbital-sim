classdef Universe

    properties
        bodies;
        timestep;
        x_limit;
        y_limit;
    end
    
    % Solar System Preset 
    properties(Constant)
        % scaling properties
        x_limitSol = [-4.5E12,4.5E12];
        y_limitSol = [-4.5E12,4.5E12];
        planetScale = 1;
        
        % sun
        sunCol  = [1,.5,0];
        sunRadi = 696.340E6;
        sunDRad = 20.0;
        sunMass = 1.989E30;
        
        
        % mercury
        mercuryCol    = [.2,.2,.2];
        mercuryDist   = [-63.822E9,0];
        mercuryOrbVel = [48E3, pi/2];
        mercuryRadi   = 2.4397E6;
        mercuryDRad   = (Universe.mercuryRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        mercuryMass   = 3.285E24;
        
        % venus
        venusCol    = [.9,.9,.9];
        venusDist   = [-108.27E9,0];
        venusOrbVel = [35E3, pi/2];
        venusRadi   = 6.0518E6;
        venusDRad   = (Universe.venusRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        venusMass   = 4.867E24;
        
        % earth
        earthCol    = 'g';
        earthDist   = [-149.6E9,0];
        earthOrbVel = [29.78E3,pi/2];
        earthRadi   = 6.371E6;
        earthDRad   = (Universe.earthRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        earthMass   = 5.972E24;
        
        % mars
        marsCol    = 'r';
        marsDist   = [-208.81E9,0];
        marsOrbVel = [24.07E3,pi/2];
        marsRadi   = 3.3895E6;
        marsDRad   = (Universe.marsRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        marsMass   = 6.39E23
            
        % jupiter
        jupiterCol    = [0.952,0.678,0.309];
        jupiterDist   = [-769.11E9,0];
        jupiterOrbVel = [13.06E3,pi/2];
        jupiterRadi   = 69.911E6
        jupiterDRad   = (Universe.jupiterRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        jupiterMass   = 1.898E27;

        % saturn
        saturnCol    = [0.909,0.819,0.450];
        saturnDist   = [-1.4939E12,0]
        saturnOrbVel = [9.68E3,pi/2];
        saturnRadi   = 58.232E6;
        saturnDRad   = (Universe.saturnRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        saturnMass   = 5.683E26;

        % uranus
        uranusCol    = [0.552,0.894,0.925];
        uranusDist   = [-2.9601E12,0];
        uranusOrbVel = [6.8E3,pi/2];
        uranusRadi   = 25.362E6;
        uranusDRad   = (Universe.uranusRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        uranusMass   = 8.681E25;

        % neptune
        neptuneCol    = 'b';
        neptuneDist   = [-4.4764E12,0];
        neptuneOrbVel = [5.43E3,pi/2];
        neptuneRadi   = 24.622E6;
        neptuneDRad   = (Universe.neptuneRadi/Universe.sunRadi)*Universe.sunDRad*Universe.planetScale;
        neptuneMass   = 1.024E26;
    end

    methods(Access = public)
        %Constructor
        function obj = Universe(bodies, timestep, x_limit, y_limit)
            obj.bodies   = bodies;
            obj.timestep = timestep;
            obj.x_limit = x_limit;
            obj.y_limit = y_limit;
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
                disp(obj.bodies(2));
                
                % prepare frame below
                clf();
                hold on;
                xlim(obj.x_limit);
                ylim(obj.y_limit);
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
            % scaling
            Universe.x_limit = Universe.x_limitSol;
            Universe.y_limit = Universe.y_limitSol;
            % sun
            sun = CelestialBody("The Sun",        ...
                                Universe.sunCol,  ...
                                [0,0],            ...
                                [0,0],            ...
                                Universe.sunRadi, ...
                                Universe.sunDRad, ...
                                Universe.sunMass, ...
                                'static'          ...
                            );
            % mercury
            mer = CelestialBody("Bleak Mercury",        ...
                                Universe.mercuryCol,    ...
                                Universe.mercuryDist,   ...
                                Universe.mercuryOrbVel, ...
                                Universe.mercuryRadi,   ...
                                Universe.mercuryDRad,   ...
                                Universe.mercuryMass    ...
                             );
                                
            % venus
            ven = CelestialBody("Broiling Venus",     ...
                                Universe.venusCol,    ...
                                Universe.venusDist,   ...
                                Universe.venusOrbVel, ...
                                Universe.venusRadi,   ...
                                Universe.venusDRad,   ...
                                Universe.venusMass    ...
                            );
            % earth
            ear = CelestialBody("Planet Earth",         ...
                                  Universe.earthCol,    ...
                                  Universe.earthDist,   ...
                                  Universe.earthOrbVel, ...
                                  Universe.earthRadi,   ...
                                  Universe.earthDRad,   ...
                                  Universe.earthMass    ...
                             ); 
            % mars
            mar = CelestialBody("Blood Mars",          ...
                                  Universe.marsCol,    ...
                                  Universe.marsDist,   ...
                                  Universe.marsOrbVel, ...
                                  Universe.marsRadi,   ...
                                  Universe.marsDRad,   ...
                                  Universe.marsMass    ...
                             ); 
            
            % jupiter
            jup = CelestialBody("Colossal Jupiter",       ...
                                  Universe.jupiterCol,    ...
                                  Universe.jupiterDist,   ...
                                  Universe.jupiterOrbVel, ...
                                  Universe.jupiterRadi,   ...
                                  Universe.jupiterDRad,   ...
                                  Universe.jupiterMass    ...
                             ); 
            % saturn
            sat = CelestialBody("Elegant Saturn",       ...
                                  Universe.saturnCol,    ...
                                  Universe.saturnDist,   ...
                                  Universe.saturnOrbVel, ...
                                  Universe.saturnRadi,   ...
                                  Universe.saturnDRad,   ...
                                  Universe.saturnMass    ...
                             ); 
            % uranus
            ura = CelestialBody("Frigid Uranus",         ...
                                  Universe.uranusCol,    ...
                                  Universe.uranusDist,   ...
                                  Universe.uranusOrbVel, ...
                                  Universe.uranusRadi,   ...
                                  Universe.uranusDRad,   ...
                                  Universe.uranusMass    ...
                             ); 
            % neptune
            nep = CelestialBody("Striking Neptune",       ...
                                  Universe.neptuneCol,    ...
                                  Universe.neptuneDist,   ...
                                  Universe.neptuneOrbVel, ...
                                  Universe.neptuneRadi,   ...
                                  Universe.neptuneDRad,   ...
                                  Universe.neptuneMass    ...
                             ); 
            bodies = [sun, mer, ven, ear, mar, jup, sat, ura, nep];
        end  
        
    end
    
end




