classdef Universe

    properties
        bodies;
        time;
    end

    methods
        %Constructor
        function obj = Universe(bodies, time)
            obj.bodies = bodies;
            obj.time = time;
        end
        
    end
        
    
end




