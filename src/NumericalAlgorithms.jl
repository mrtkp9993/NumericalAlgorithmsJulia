__precompile__(true)
"""
Numerical Algorithms in Julia

Copyright 2021 Murat Koptur.

Licensed under GPL License, see LICENSE.md

"""
module NumericalAlgorithms

include("Constants.jl")
include("Differentiation.jl")
include("Distributions.jl")
include("Integration.jl")
include("MCMC.jl")
include("Random.jl")
include("RootFinding.jl")
include("StatisticalTests.jl")

export C_E, C_LOG2E, C_LOG10E, C_LN2, C_LN10, C_PI
export C_PI_2, C_1_PI, C_2_PI, C_2_SQRTPI, C_SQRT2
export C_SQRT1_2, C_SQRTPI, C_SQRT2PI
export primes_1000
export FindRoot1D, FindRootND
export Dual
export CalcSingleIntegral, CalcDoubleIntegral, CalcMonteCarloIntegral
export LFG, RANMAR, vanderCorputSeq, haltonSeq, faureSeq, sobolSeq
export RunsTest
export MCMC
export UniformDistribution, punif, runif

end # module
