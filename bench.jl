using BenchmarkTools

function foo!(A, B)
    Threads.@threads for i = eachindex(A, B)
        @inbounds A[i] = B[i] * 2 + rand()
    end
end

B = rand(100)
A = similar(B)
@btime foo!($A, $B)

B = rand(1000)
A = similar(B)
@btime foo!($A, $B)

B = rand(10000)
A = similar(B)
@btime foo!($A, $B)
