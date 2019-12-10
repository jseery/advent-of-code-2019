using DelimitedFiles
using Printf

function get_module_fuel_requirement(module_mass)
    return Int(floor(module_mass / 3) - 2)
end

function test_module_fuel_requirement()
    test_questions = [12; 14; 1969; 100756]
    test_answers = [2; 2; 654; 33583]
    for (q, a) in zip(test_questions, test_answers)
        got_answer = get_module_fuel_requirement(q)
        println("input: $q, expected output: $a, got output: $got_answer")
        @assert get_module_fuel_requirement(q) == a
    end
end
test_module_fuel_requirement()

function get_fuel_fuel_requirement(module_fuel_req)
    old_fuel = module_fuel_req
    all_fuels = Int[module_fuel_req]
    while true
        new_fuel = get_module_fuel_requirement(old_fuel)
        if new_fuel <= 0
            break
        end
        push!(all_fuels, clamp(new_fuel, 0, Inf))
        old_fuel = new_fuel
    end
    return all_fuels
end

function test_fuel_fuel()
    println("testing fuel fuel requirements...")
    test_module_mass = 100756
    test_module_fuel_req = get_module_fuel_requirement(test_module_mass)
    test_fuel_fuel_reqs = get_fuel_fuel_requirement(test_module_fuel_req)
    expected_all_fuels = [33583, 11192, 3728, 1240, 411, 135, 43, 12, 2]
    println("$test_fuel_fuel_reqs")
    @assert test_fuel_fuel_reqs == expected_all_fuels
    expected_sum_requirement = 50346
    @assert sum(test_fuel_fuel_reqs) == expected_sum_requirement
end
test_fuel_fuel()


data = DelimitedFiles.readdlm("data-1-1.csv", Int)
module_fuel_reqs = map(get_module_fuel_requirement, data)
answer_1 = sum(module_fuel_reqs)
println("answer 1 is: $answer_1")

# answer_1 is the input for part 2.
all_fuel_reqs = map(get_fuel_fuel_requirement, module_fuel_reqs)
answer_2 = sum(map(sum, all_fuel_reqs))
println("answer 2: $answer_2")
