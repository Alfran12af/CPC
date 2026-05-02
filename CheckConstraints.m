function valid = CheckConstraints(s1, s2, s3, params)

valid = true;

% Positive masses
if any([s1.mi s2.mi s3.mi] <= 0)
    valid = false;
    return;
end

% Structural ratios sanity check
if any([params.eps1 params.eps2 params.eps3] < 0.04) || ...
   any([params.eps1 params.eps2 params.eps3] > 0.2)
    valid = false;
    return;
end

% Payload consistency
if abs(s3.m_payload - params.m_payload) > 1e-6
    valid = false;
    return;
end

end