using BenchmarkTools

@warn "Threads: $(Threads.nthreads())"

function foo!(A, B)
    Threads.@threads for i = eachindex(A, B)
        @inbounds A[i] = B[i] * 2 + rand()
    end
end

B = rand(50000)
A = similar(B)
@btime foo!($A, $B)
