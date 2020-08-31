classdef PhysEng
    % Physics Engine for the Orbital Simulator:
    % Takes in various inputs from Universe and modifies CelestialBodies in
    % said space
    %
    % - keep mode in radians
    
    properties(Constant)
        GravitationalConstant = 6.67408E-11;
    end
    
    methods(Static)
        % Given a celestial body, calculate it's new velocity given
        % gravitational forces from other bodies in universe
        function vect_ve = calcVelocity(cb, bodies)
            
        end
        
        function result = testPhys(obj1, obj2)
            result = PhysEng.getAngleBetween(obj1, obj2);
        end
        
    end
    
    methods(Access = private, Static)
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
        
        % Method to convert polar to rectangular notation
        function recVect = pol2rec(polVec)
            recVect = [polVec(1)*cos(polVec(2)), polVec(1)*sin(polVec(2))];
        end
        
        % Method to calc vect_fg between two distanced obj (kg.m)
        function vect_Fg = getForceGravity(m1, m2, r)
           vect_Fg = [PhysEng.GravitationalConstant*m2*m1/r.^2,
                      PhysEng.getAngleBetween(m1,m2)];
        end
        
        % Method to calc vect_ve of given vect_Fg
        
    end
end

