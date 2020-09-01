classdef PhysEng
    % Physics Engine for the Orbital Simulator:
    % Takes in various inputs from Universe and modifies CelestialBodies in
    % said space
    %
    % - keep mode in radians
    % - keep vect in polar
    % ! NOTE: probably not using time, t, in correct sense...
    
    properties(Constant)
        GravitationalConstant = 6.67408E-11;
    end
    
    methods(Static)
        % Method to update velocity and position of celestial body in given
        % universe
        % DEBUG: velocity -> position
        function cb_new = updateCelestialBody(cb, universe)
            cb_new = cb;
            newVel = PhysEng.calcNewVelocity(cb, universe.bodies, universe.time);
            %cb_new.pos = PhysEng.calcNewPosition(cb, newVel, universe.time);
            cb_new.vel = newVel;
            
            
        end
        
        
        % Given a celestial body, calculate a new (COPY!!!) velocity given
        % gravitational forces from other bodies in universe over given
        % time
        function cb_newVel = calcNewVelocity(cb, bodies, t)
            cb_newVel = cb.vel; % copied temp velocity to hold cb's modified vel
            for body = bodies
                if(~isequal(cb, body))
                    vect_Fg   = PhysEng.getForceGravity(cb, body);
                    vect_ve   = PhysEng.getVelocity(vect_Fg, cb, t);
                    cb_newVel = PhysEng.addPolVec(cb_newVel,vect_ve);
                end
            end
        end
        
        % Calculate change in position of given celestial body based on
        % new velocity vector
        function cb_newPos = calcNewPosition(cb, cb_newVel, t)
           deltaPos  = ((cb.vel(1)+cb_newVel(1))/2)*t; % REVIEW needs Dx and Dy
           deltaPos_X = deltaPos*cos(cb_newVel(2));
           deltaPos_Y = deltaPos*sin(cb_newVel(2));
           cb_newPos = [cb.pos(1)+deltaPos_X,cb.pos(2)+deltaPos_Y];
        end
        
        function result = testPhys(cb, bodies, t)
            result = PhysEng.calcNewVelocity(cb, bodies, t);
        end
        
    end
    
    methods(Access = private, Static)
        % Method to calc distance between two obj
        function dist = getDistanceBetween(obj1, obj2)
            dist = sqrt((obj2.pos(1)-obj1.pos(1))^2 + (obj2.pos(2)-obj1.pos(2))^2);
        end
        
        % Method to calc angle between two obj (oriented right.rads)
        function rad = getAngleBetween(obj1, obj2)
            delta_y = obj2.pos(2) - obj1.pos(2);
            delta_x = obj2.pos(1) - obj1.pos(1);
            rad     = atan(delta_y / delta_x);

            if(delta_x > 0 && delta_y < 0)
                rad = rad + 2*pi;
            elseif(delta_x < 0 || delta_y < 0)
                rad = rad + pi;
            end
        end
        
        % Method to calc vect_fg between two distanced obj (kg.m)
        function vect_Fg = getForceGravity(obj1, obj2)
           vect_Fg = [PhysEng.GravitationalConstant*obj2.mass*obj1.mass/ ...
                      PhysEng.getDistanceBetween(obj1,obj2)^2,           ...
                      PhysEng.getAngleBetween(obj1,obj2)];
        end
        
        % Method to calc vect_ve of given vect_Fg exerted on an obj over
        % time
        function vect_ve = getVelocity(vect_Fg, obj, t)
            vect_ve = [vect_Fg(1)/obj.mass*t, vect_Fg(2)];
        end
        
        % Method to convert polar to rectangular notation
        function recVec = pol2rec(polVec)
            recVec = [polVec(1)*cos(polVec(2)), polVec(1)*sin(polVec(2))];
        end
        
        % Method to convert rectangular to polar notation
        function polVec = rec2pol(recVec)
            mag = sqrt(recVec(1)^2 + recVec(2)^2);
            dir = atan(recVec(2)/recVec(1));
            if(recVec(1)>0 && recVec(2)<0)
                dir = dir+2*pi;
            elseif(recVec(1)<0 || recVec(2)<0)
                dir = dir+pi;
            end
            polVec = [mag,dir];
        end
        
        % Method to add two polar vectors as polar vector
        function polVec_sum = addPolVec(polVec1, polVec2)
            polVec_sum = PhysEng.rec2pol(PhysEng.pol2rec(polVec1) + PhysEng.pol2rec(polVec2));
        end
        
    end
end

