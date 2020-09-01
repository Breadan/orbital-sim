classdef CelestialBody
    properties
        isStatic = false;   % default false
        name;               % body name
        col;                % body color
        pos;                % vector coordinate
        vel;                % velocity polar vector
        radius;             % body radius
        dradius;            % body drawn radius
        mass;               % body mass
    end
    
    methods
        %Constructor pos,radius,mass,{isStatic}
        function obj = CelestialBody(varargin)
            obj.name    = varargin{1};
            obj.col     = varargin{2};
            obj.pos     = varargin{3};
            obj.vel     = varargin{4};
            obj.radius  = varargin{5};
            obj.dradius = varargin{6};
            obj.mass    = varargin{7};
            if(nargin>7)
                obj.isStatic = true;
                obj.vel      = [0,0];
            end
            
            % Ensure positive magnitude of velocity
            obj.vel(1) = abs(obj.vel(1));
        end
        
        

        
    end
    
end