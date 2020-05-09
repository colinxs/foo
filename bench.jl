using BenchmarkTools

@warn "Threads: $(Threads.nthreads())"
@info "" ENV["OPENBLAS_NUM_THREADS"] ENV["JULIA_NUM_THREADS"]
display(Sys.cpu_info())

function foo!(A, B)
    Threads.@threads for i = eachindex(A, B)
        @inbounds A[i] = B[i] * 2 + rand()
    end
end

B = rand(50000)
A = similar(B)
@btime foo!($A, $B)
