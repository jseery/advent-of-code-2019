println(PROGRAM_FILE); for x in ARGS; println(x); end

function get_module_fuel_requirement(module_mass)
    floor(module_mass / 3) - 2
end
