function compatibleversion = f_check_minimum_version(major,minor)

compatibleversion = 0;

[majorversion, minorversion] = mcrversion;

if majorversion >= major
    if minorversion >= minor
        compatibleversion = 1;
    end
elseif majorversion >= major + 1
    compatibleversion = 1;
end
end