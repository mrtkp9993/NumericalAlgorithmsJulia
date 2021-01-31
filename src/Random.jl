abstract type RNG end

"Struct for Lagged Fibonacci Generator"
mutable struct LFG <: RNG 
    "first lag"
    p
    "second lag"
    q
    "modulo"
    m
    "state of RNG"
    s
    "Operation (+,-,*)"
    op
end

"Constructor for LFG with default parameter values"
LFG() = LFG(24, 55, 2^32, [rand(UInt) % 2^32 for i = 1:55], +)
"Constructor for LFG with user supplied values, p, q, m"
LFG(p, q, m) = LPG(p, q, m, [rand(UInt) % m for i = 1:q], +)


function Base.rand(rng::LFG)
    new = rng.op(rng.s[rng.p], rng.s[rng.q]) % rng.m
    popfirst!(rng.s)
    push!(rng.s, new)
    new
end

function Base.rand(rng::LFG, n::Int)
    rnd = []
    for j = 1:n
        new = rng.op(rng.s[rng.p], rng.s[rng.q]) % rng.m
        popfirst!(rng.s)
        push!(rng.s, new)
        push!(rnd, new)
    end
    rnd
end

"Struct for RANMAR composite rng"
mutable struct RANMAR <: RNG # RANMAR 
    r::LFG
    t
    s
end

"t_i sequence for RANMAR"
function ranseq(t) 
    if t - 7654321 >= 0
        t = t - 7654321
    else
        t = t - 7654321 + 2^24 - 3
    end
    return t
end

function RANMAR()
    r = LFG(97, 33, 2^24, [rand(UInt) % 2^32 for i = 1:97], -)
    t = [rand(UInt) % 2^24]
    for i = 2:97
        push!(t, ranseq(t[i - 1]))
    end
    s = []
    for i = 1:97
        push!(s, (r.s[i] - t[i]) % 2^24)
    end
    t = t[97]
    RANMAR(r, t, s)
end

function Base.rand(rng::RANMAR)
    rnew = rand(rng.r)
    tnew = ranseq(rng.t)
    rng.t = tnew
    snew = (rnew - tnew) % 2^24
    push!(rng.s, snew)
    snew
end

"van der Corput sequence, simplest one-dimensional low-discrepancy sequence over the unit interval."
function vanderCorputSeq(n, b)
    bn = 0
    j = 0
    while n != 0
        bn += mod(n, b) / (b^(j + 1))
        n = floor(n / b)
        j += 1
    end
    bn
end
