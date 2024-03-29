using DelimitedFiles
using Test
using Printf
using Logging

part_1_data = DelimitedFiles.readdlm("data-2.txt", ',', Int)

function run_program(program)
    @debug "Starting program run..." program[1]
    pos = 1
    iteration = 0
    while program[pos] != 99
        @debug "iteration " iteration
        iteration += 1
        (opcode, loc1, loc2, loc3) = program[pos],
            program[pos+1],
            program[pos+2],
            program[pos+3]
        if opcode == 1
            program[loc3+1] = program[loc1+1] + program[loc2+1]
        elseif opcode == 2
            program[loc3+1] = program[loc1+1] * program[loc2+1]
        else
            error("iter $iteration, opcode: $opcode at position $pos not recognized")
        end
        pos += 4
    end
    return program
end

test_1 = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
expect_1 = [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]

test_2 = [2, 3, 0, 3, 99]
expect_2 = [2, 3, 0, 6, 99]

test_3 = [2, 4, 4, 5, 99, 0]
expect_3 = [2, 4, 4, 5, 99, 9801]

test_4 = [1, 1, 1, 4, 99, 5, 6, 0, 99]
expect_4 = [30, 1, 1, 4, 2, 5, 6, 0, 99]

@test run_program(test_1) == expect_1
@test run_program(test_2) == expect_2
@test run_program(test_3) == expect_3
@test run_program(test_4) == expect_4

part_1_data[2] = 12
part_1_data[3] = 2
part_1_prog_result = run_program(part_1_data)
println("$part_1_prog_result")

function run_with_noun_and_verb(program, noun, verb)
    op_on = program[:]
    op_on[2] = noun
    op_on[3] = verb
    @debug "run_with_noun_and_verb program idx 1:" op_on[1]
    prog_result = run_program(op_on)
    return prog_result[1]
end

part_2_target = 19690720
part_2_program = DelimitedFiles.readdlm("data-2.txt", ',', Int)
for noun = 0:99
    for verb = 0:99
        output = run_with_noun_and_verb(part_2_program, noun, verb)
        if output == part_2_target
            print("output: $output - $(@sprintf("%s", 100 * noun + verb))")
            break
        end
    end
end
