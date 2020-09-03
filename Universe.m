classdef Universe

    properties
        bodies;
        timestep;
        x_limit;
        y_limit;
    end
    
    % Solar System Preset 
    properties(Constant)
       
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
        function bigBang(obj, frames, trailType)
            % calculate prediction trail below
            % TODO: Currently only predicts as if all other bodies were
            % STATIC
            pPos = Universe.calcPPos(obj, frames);
            sim = figure();    
            disp("a big bang bangs...");
            for frame = 1:frames
                if(~ishghandle(sim))
                    break 
                end
                
                

                
                % prepare frame below
                clf();
                ax  = axes();
                set(ax,'Color','k');
                hold on;
                xlim(obj.x_limit);
                ylim(obj.y_limit);
                % draw prediction trail below
                if(trailType > 0)                    
                    Universe.drawPPos(obj, pPos, frames, frame, trailType);
                end
                % draw points below
                for i = 1:length(obj.bodies)
                    scatter(pPos{i}{1}{frame}, pPos{i}{2}{frame}, 2*obj.bodies(i).dradius, obj.bodies(i).col, 'filled');
                end
                hold off;
                drawnow();
            end
            disp("a big crunch crunches...");
        end
        
    end
    
    methods(Access = private, Static)
        %Calculate predictive trails
        function pPos = calcPPos(obj, pFrames)
            pUni = obj;
            planets = length(pUni.bodies);
            pPos = cell(1,planets);
            for i = 1:planets
                pPos{i} = {cell(1,pFrames),cell(1,pFrames)};
            end         
            for i = 1:pFrames
                for j = 1:planets
                    planetPos      = PhysEng.updateCelestialBody(pUni.bodies(j), pUni).pos;
                    pPos{j}{1}{i}  = planetPos(1);
                    pPos{j}{2}{i}  = planetPos(2);
                    pUni.bodies(j) = PhysEng.updateCelestialBody(pUni.bodies(j), pUni);
                    pUni.bodies(j) = pUni.bodies(j);
                end
                
            end
        end
        
        %Draw predictive trails
        function drawPPos(obj, ptrails, pFrames, cFrames, trailType)
            plotX = zeros(length(pFrames));
            plotY = zeros(length(pFrames));
            for i = 1:length(obj.bodies) 
                if(~obj.bodies(i).isStatic)
                    if(trailType == 1)
                        for j = 1:pFrames
                            plotX(j) = ptrails{i}{1}{j};
                            plotY(j) = ptrails{i}{2}{j};
                        end
                    elseif(trailType == 2)
                        for j = 1:cFrames
                            plotX(j) = ptrails{i}{1}{j};
                            plotY(j) = ptrails{i}{2}{j};
                        end
                    end
                    plot(plotX,plotY,'Color',obj.bodies(i).col,'LineWidth',1.5);
                end
            end
        end
    end
      
    methods(Static)
        % Preset: Solar System
        function bodies = setSolarSystem()
            % scaling properties
            planetScale = 100;

            % sun
            sunCol  = [1,.5,0];
            sunRadi = 696.340E6;
            sunDRad = 50.0;
            sunMass = 1.989E30;

            % mercury
            mercuryCol    = [.2,.2,.2];
            mercuryDist   = [-63.822E9,0];
            mercuryOrbVel = [48E3, pi/2];
            mercuryRadi   = 2.4397E6;
            mercuryDRad   = (mercuryRadi/sunRadi)*sunDRad*planetScale;
            mercuryMass   = 3.285E24;

            % venus
            venusCol    = [.9,.9,.9];
            venusDist   = [-108.27E9,0];
            venusOrbVel = [35E3, pi/2];
            venusRadi   = 6.0518E6;
            venusDRad   = (venusRadi/sunRadi)*sunDRad*planetScale;
            venusMass   = 4.867E24;

            % earth
            earthCol    = 'g';
            earthDist   = [-149.6E9,0];
            earthOrbVel = [29.78E3,pi/2];
            earthRadi   = 6.371E6;
            earthDRad   = (earthRadi/sunRadi)*sunDRad*planetScale;
            earthMass   = 5.972E24;

            % mars
            marsCol    = 'r';
            marsDist   = [-208.81E9,0];
            marsOrbVel = [24.07E3,pi/2];
            marsRadi   = 3.3895E6;
            marsDRad   = (marsRadi/sunRadi)*sunDRad*planetScale;
            marsMass   = 6.39E23;

            % jupiter
            jupiterCol    = [0.952,0.678,0.309];
            jupiterDist   = [-769.11E9,0];
            jupiterOrbVel = [13.06E3,pi/2];
            jupiterRadi   = 69.911E6;
            jupiterDRad   = (jupiterRadi/sunRadi)*sunDRad*planetScale;
            jupiterMass   = 1.898E27;

            % saturn
            saturnCol    = [0.909,0.819,0.450];
            saturnDist   = [-1.4939E12,0];
            saturnOrbVel = [9.68E3,pi/2];
            saturnRadi   = 58.232E6;
            saturnDRad   = (saturnRadi/sunRadi)*sunDRad*planetScale;
            saturnMass   = 5.683E26;

            % uranus
            uranusCol    = [0.552,0.894,0.925];
            uranusDist   = [-2.9601E12,0];
            uranusOrbVel = [6.8E3,pi/2];
            uranusRadi   = 25.362E6;
            uranusDRad   = (uranusRadi/sunRadi)*sunDRad*planetScale;
            uranusMass   = 8.681E25;

            % neptune
            neptuneCol    = 'b';
            neptuneDist   = [-4.4764E12,0];
            neptuneOrbVel = [5.43E3,pi/2];
            neptuneRadi   = 24.622E6;
            neptuneDRad   = (neptuneRadi/sunRadi)*sunDRad*planetScale;
            neptuneMass   = 1.024E26;

            
            % Constructing
            % sun
            sun = CelestialBody("The Sun", ...
                                sunCol,    ...
                                [0,0],     ...
                                [0,0],     ...
                                sunRadi,   ...
                                sunDRad,   ...
                                sunMass,   ...
                                'static'   ...
                            );
            % mercury
            mer = CelestialBody("Bleak Mercury", ...
                                mercuryCol,      ...
                                mercuryDist,     ...
                                mercuryOrbVel,   ...
                                mercuryRadi,     ...
                                mercuryDRad,     ...
                                mercuryMass      ...
                             );
                                
            % venus
            ven = CelestialBody("Broiling Venus", ...
                                venusCol,         ...
                                venusDist,        ...
                                venusOrbVel,      ...
                                venusRadi,        ...
                                venusDRad,        ...
                                venusMass         ...
                            );
            % earth
            ear = CelestialBody("Planet Earth", ...
                                  earthCol,     ...
                                  earthDist,    ...
                                  earthOrbVel,  ...
                                  earthRadi,    ...
                                  earthDRad,    ...
                                  earthMass     ...
                             ); 
            % mars
            mar = CelestialBody("Blood Mars", ...
                                  marsCol,    ...
                                  marsDist,   ...
                                  marsOrbVel, ...
                                  marsRadi,   ...
                                  marsDRad,   ...
                                  marsMass    ...
                             ); 
            
            % jupiter
            jup = CelestialBody("Colossal Jupiter", ...
                                  jupiterCol,       ...
                                  jupiterDist,      ...
                                  jupiterOrbVel,    ...
                                  jupiterRadi,      ...
                                  jupiterDRad,      ...
                                  jupiterMass       ...
                             ); 
            % saturn
            sat = CelestialBody("Elegant Saturn", ...
                                  saturnCol,      ...
                                  saturnDist,     ...
                                  saturnOrbVel,   ...
                                  saturnRadi,     ...
                                  saturnDRad,     ...
                                  saturnMass      ...
                             ); 
            % uranus
            ura = CelestialBody("Frigid Uranus", ...
                                  uranusCol,     ...
                                  uranusDist,    ...
                                  uranusOrbVel,  ...
                                  uranusRadi,    ...
                                  uranusDRad,    ...
                                  uranusMass     ...
                             ); 
            % neptune
            nep = CelestialBody("Striking Neptune", ...
                                  neptuneCol,       ...
                                  neptuneDist,      ...
                                  neptuneOrbVel,    ...
                                  neptuneRadi,      ...
                                  neptuneDRad,      ...
                                  neptuneMass       ...
                             ); 
            bodies = [sun, mer, ven, ear, mar, jup, sat, ura, nep];
        end  
        
    end
    
end




