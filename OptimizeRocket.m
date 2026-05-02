function result = OptimizeRocket(params)

best.m0 = inf;
best.sol = [];

for f1 = params.frac1_range
    for f2 = params.frac2_range
        
        f3 = 1 - f1 - f2;
        if f3 <= 0
            continue;
        end
        
        DV = params.DV_total * [f1 f2 f3];
        
        for mr1 = params.mr1_range
            for mr2 = params.mr2_range
                for mr3 = params.mr3_range
                    
                    mr = [mr1 mr2 mr3];
                    
                    sol = RocketModel(DV, mr, params);
                    
                    if sol.valid && sol.m0 < best.m0
                        best.m0 = sol.m0;
                        best.sol = sol;
                    end
                    
                end
            end
        end
        
    end
end

result = best.sol;

end