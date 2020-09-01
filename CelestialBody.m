classdef CelestialBody
    properties
        isStatic = false;   % default false
        pos;                % vector coordinate
        vel;                % velocity polar vector
        radius;             % body radius
        mass;               % body mass
    end
    
    methods
        %Constructor pos,radius,mass,{isStatic}
        function obj = CelestialBody(varargin)
            obj.pos = varargin{1};
            obj.vel = varargin{2};
            obj.radius = varargin{3};          
            obj.mass = varargin{4};
            if(nargin>4)
                obj.isStatic = true;
                obj.vel = [0,0];
            end
            
            % Ensure positive magnitude of velocity
            obj.vel(1) = abs(obj.vel(1));
        end
        

        
    end
    
end